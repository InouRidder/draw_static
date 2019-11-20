# frozen_string_literal: true
require 'pry'

require_relative 'static_routes'

module DrawStatic
  def draw_static(*arguments)
    generator = StaticRoutes.new(context: self)

    generator.for(arguments: arguments, prefixed_modules: get_prefixed_modules)
  end

  def get_prefixed_modules
    instance_variable_get('@scope')&.instance_variable_get('@hash')&.try(:[], :module)
  end
end

ActionDispatch::Routing::Mapper.prepend DrawStatic
