# frozen_string_literal: true

require_relative 'static_routes'
require_relative 'module_finder'

module DrawStatic
  def draw_static(*arguments)
    generator = StaticRoutes.new(context: self)

    generator.for(arguments: arguments, prefixed_modules: prefixed_modules)
  end

  def prefixed_modules
    ModuleFinder.dig(self)
  end
end

ActionDispatch::Routing::Mapper.prepend DrawStatic
