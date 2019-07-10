# frozen_string_literal: true

require_relative 'static_routes'

module DrawStatic
  def draw_static(*arguments)
    generator = StaticRoutes.new(context: self)
    generator.for(arguments)
  end
end

ActionDispatch::Routing::Mapper.prepend DrawStatic
