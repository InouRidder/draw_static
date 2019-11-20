# frozen_string_literal: true

class StaticRoutes
  attr_accessor :context, :limits, :prefixed_modules
  def initialize(attributes = {})
    @context = attributes[:context]
    @limits = {}
  end

  def for(attributes)
    splice_limits(attributes[:arguments])

    self.prefixed_modules = attributes[:prefixed_modules]&.split('/') || []

    attributes[:arguments].each do |controller|
      write_routes_for(controller)
    end
  end

  private

  def route_from_action(action)
    action.to_s.gsub(/[^a-zA-Z]/, '-')
  end

  def controller_from_chars(chars)
    create_namespaced_controller(chars).constantize
  end

  def create_namespaced_controller(chars)
    main_controller = "#{chars.to_s.camelize}Controller"

    if prefixed_modules
      (prefixed_modules.map(&:camelize) << main_controller).join('::')
    else
      main_controller
    end
  end

  def splice_limits(arguments)
    return unless arguments.last.is_a? Hash

    self.limits = arguments.slice!(-1)
  end

  def write_routes_for(controller)
    controller_constant = controller_from_chars(controller)
    desired_routes_from(controller_constant).each do |action|
      context.get(route_from_action(action), to: "#{controller}##{action}")
    end
  end

  def desired_routes_from(controller)
    instance_methods = controller.instance_methods(false)
    if limits[:only]
      limits[:only].select { |method| instance_methods.include?(method) }
    else
      instance_methods.reject do |route|
        limits[:except]&.include?(route)
      end
    end
  end
end
