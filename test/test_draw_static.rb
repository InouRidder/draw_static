require 'minitest/autorun'
require 'rails'
require 'draw_static'
require_relative 'draw_static_tests_controller'
require 'pry'

class DrawStaticTest < Minitest::Test
  def test_route_from_action
    assert_equal "my-home-page", StaticRoutes.route_from_action("my_home_page")
    assert_equal "hyphenized-pages-are-great", StaticRoutes.route_from_action("hyphenized2pages$are(great")
    assert_equal "iFcknLove-hyphens", StaticRoutes.route_from_action("iFcknLove9hyphens")
  end

  def test_controller_from_action
    assert_equal DrawStaticTestsController, StaticRoutes.controller_from_chars(:draw_static_tests)
  end

  module DrawStaticTestApp
    # Creating a rails app for testing.
    class Application < Rails::Application
    end
  end

  def test_draw_static
    Rails.application.routes.draw do
      draw_static :draw_static_tests
    end
    assert_equal Rails.application.routes.set.count, 4
    test_if_routes_includes_tests_controller_actions
  end

  private

  def test_if_routes_includes_tests_controller_actions
    routes = DrawStaticTestsController.instance_methods(false).map { |action| StaticRoutes.route_from_action(action) }
    routes.each do |route|
      assert_equal !!Rails.application.routes.recognize_path(route), true
    end
  end
end
