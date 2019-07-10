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
    limits[:only] || instance_methods.reject do |route|
      limits[:except]&.include?(route)
    end
    # check_if_only_is_alreadyd_drawn!
  end

  def for(arguments)
    controllers = split_controllers_and_limits(arguments)
    controllers.each do |controller|
      write_routes_for(controller)
    end
  end

  private

  def split_controllers_and_limits(arguments)
    if arguments.last.is_a? Hash
      self.limits = arguments.last
      return arguments[0..-2]
    end
    arguments
  end

  def write_routes_for(controller)
    controller_constant = controller_from_chars(controller)
    desired_routes_from(controller_constant).each do |action|
      context.get(route_from_action(action), to: "#{controller}##{action}")
    end
  end
end
