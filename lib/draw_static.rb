# frozen_string_literal: true

require_relative 'static_routes'

module DrawStatic
  def draw_static(*controllers)
    controllers.each do |controller|
      StaticRoutes.for(controller, self)
    end
  end
end

ActionDispatch::Routing::Mapper.prepend DrawStatic
