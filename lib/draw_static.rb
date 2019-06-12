# frozen_string_literal: true

require_relative 'static_routes'

module DrawStatic
  def draw_static(*controllers)
    StaticRoutes.context = self
    StaticRoutes.for(controllers)
  end
end

ActionDispatch::Routing::Mapper.prepend DrawStatic
