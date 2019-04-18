require_relative 'static_routes'

ActionDispatch::Routing::Mapper.class_eval do
  def draw_static(*controllers)
    controllers.each do |controller|
      StaticRoutes.for(controller, self)
    end
  end
end
