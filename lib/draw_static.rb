require_relative 'static_routes'

begin
  ActionDispatch::Routing::Mapper.class_eval do
    def draw_static(*controllers)
      controllers.each do |controller|
        StaticRoutes.for(controller, self)
      end
    end
  end
rescue
  puts "Please add this gem to rails - it is dependent on ActionDispatch::Routing::Mapper"
end
