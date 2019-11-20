# frozen_string_literal: true

require_relative 'static_routes'

module DrawStatic
  def draw_static(*arguments)
    generator = StaticRoutes.new(context: self)

    generator.for(arguments: arguments, prefixed_modules: prefixed_modules)
  end

  def prefixed_modules
    instance_variable_get('@scope')&.instance_variable_get('@hash')&.try(:[], :module)
  end
end

ActionDispatch::Routing::Mapper.prepend DrawStatic
