# frozen_string_literal: true

require 'rails/all'
require_relative 'draw_static_tests_controller'
require_relative 'second_tests_controller'
require 'minitest/autorun'
require 'draw_static'

class DrawStaticTest < Minitest::Test
  def test_route_from_action
    assert_equal 'my-home-page', StaticRoutes.route_from_action('my_home_page')
    assert_equal 'hyphenized-pages-are-great', StaticRoutes.route_from_action('hyphenized2pages$are(great')
    assert_equal 'iFcknLove-hyphens', StaticRoutes.route_from_action('iFcknLove9hyphens')
  end

  def test_controller_from_action
    assert_equal DrawStaticTestsController, StaticRoutes.controller_from_chars(:draw_static_tests)
  end

  module DrawStaticTestApp
    # Creating a rails app for testing.
    class Application < Rails::Application
    end
  end

  def test_draw_static_multiple
      Rails.application.routes.draw do
      draw_static :draw_static_tests, :second_tests
    end
    assert_equal Rails.application.routes.set.count, 7
    test_if_routes_includes_tests_controller_actions
  end

  def test_only_draw_static
    Rails.application.routes.draw do
      draw_static :draw_static_tests, only: [ :home ]
    end
    assert_equal Rails.application.routes.set.count, 3
    test_if_routes_only_include(:home)
  end

  def test_except_draw_static
    Rails.application.routes.draw do
      draw_static :draw_static_tests, except: [ :home, :contact ]
    end
    assert_equal Rails.application.routes.set.count, 2
    test_if_routes_do_not_include([ :home, :contact ])
  end

  def test_draw_static_single
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

  def test_if_routes_do_not_include(routes)
    routes = DrawStaticTestsController.instance_methods(false).map { |action| StaticRoutes.route_from_action(action) }
    routes.each do |route|
      assert_equal !!Rails.application.routes.recognize_path(route), true
    end
  end

  def test_if_routes_only_include(route)
    route = StaticRoutes.route_from_action([:home])
    assert_equal !!Rails.application.routes.recognize_path(route), true
  end
end
