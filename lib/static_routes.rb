# frozen_string_literal: true

class StaticRoutes
  class << self
    def route_from_action(action)
      action.to_s.gsub(/[^a-zA-Z]/, '-')
    end

    def controller_from_chars(chars)
      "#{chars.to_s.camelize}Controller".constantize
    end

    def for(controller, context)
      controller_constant = controller_from_chars(controller)
      controller_constant.instance_methods(false).each do |action|
        context.get(route_from_action(action), to: "#{controller}##{action}")
      end
    end
  end
end
