# frozen_string_literal: true

class StaticRoutes
  class << self
    attr_accessor :context
    @limits= {}

    def route_from_action(action)
      action.to_s.gsub(/[^a-zA-Z]/, '-')
    end

    def controller_from_chars(chars)
      "#{chars.to_s.camelize}Controller".constantize
    end

    def desired_routes_from_actions(controller)
      @limits[:only] || controller.instance_methods(false).reject { |route| @limits[:except].include?(route) }
    end

    def for(controllers)
      controllers, @limits = controllers[0..-2], controllers.last if controller.last.is_a? Hash
      controllers.each do |controller|
        write_routes_for(controller)
      end
    end

    private

    def write_routes_for(controller, args)
      controller_constant = controller_from_chars(controller)
      desired_routes_from_actions(controller, args).each do |action|
        context.get(route_from_action(action), to: "#{controller}##{action}")
      end
    end
  end
end
