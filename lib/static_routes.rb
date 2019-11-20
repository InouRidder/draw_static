# frozen_string_literal: true

class StaticRoutes
  attr_accessor :context, :limits
  def initialize(attributes = {})
    @context = attributes[:context]
    @limits = {}
  end

  def route_from_action(action)
    action.to_s.gsub(/[^a-zA-Z]/, '-')
  end

  def controller_from_chars(chars)
    "#{chars.to_s.camelize}Controller".constantize
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

  def for(arguments)
    splice_limits(arguments)
    controllers.each do |controller|
      write_routes_for(controller)
    end
  end

  private

  def splice_limits(arguments)
    return unless arguments.last.is_a? Hash

    self.limits = arguments.last
  end

  def write_routes_for(controller)
    controller_constant = controller_from_chars(controller)
    desired_routes_from(controller_constant).each do |action|
      context.get(route_from_action(action), to: "#{controller}##{action}")
    end
  end
end
