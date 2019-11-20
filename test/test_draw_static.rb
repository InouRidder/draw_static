# frozen_string_literal: true

require 'rails/all'
require_relative 'draw_static_tests_controller'
require_relative 'second_tests_controller'
require_relative 'namespaced_controller'
require 'minitest/autorun'
require_relative '../lib/draw_static'
require 'pry'

class DrawStaticTest < Minitest::Test
  def test_route_from_action
    assert_equal 'my-home-page', StaticRoutes.new.send(:route_from_action, 'my_home_page')
    assert_equal 'hyphenized-pages-are-great', StaticRoutes.new.send(:route_from_action, 'hyphenized2pages$are(great')
    assert_equal 'iFcknLove-hyphens', StaticRoutes.new.send(:route_from_action, 'iFcknLove9hyphens')
  end

  def test_controller_from_action
    assert_equal DrawStaticTestsController, StaticRoutes.new.send(:controller_from_chars, :draw_static_tests)
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
    route_presence(true, %i[home contact about_us crazy_Public_page hyphen_me more_pages about_tests])
  end

  def test_only_draw_static
    Rails.application.routes.draw do
      draw_static :draw_static_tests, only: [:home]
    end
    assert_equal 1, Rails.application.routes.set.count
    route_presence(true, [:home])
    route_presence(false, %i[contact crazy_Public_page about_us])
  end

  def test_except_draw_static
    Rails.application.routes.draw do
      draw_static :draw_static_tests, except: %i[home contact]
    end

    assert_equal 2, Rails.application.routes.set.count
    route_presence(false, %i[home contact])
  end

  def test_draw_static_single_controller
    Rails.application.routes.draw do
      draw_static :draw_static_tests
    end
    assert_equal 4, Rails.application.routes.set.count
    route_presence(true, %i[home contact about_us crazy_Public_page])
  end

  def test_multiple_with_only_limit
    Rails.application.routes.draw do
      draw_static :draw_static_tests, :second_tests, only: [:home]
    end
    assert_equal 1, Rails.application.routes.set.count
    route_presence(true, [:home])
  end

  def test_multiple_with_except_limit
    Rails.application.routes.draw do
      draw_static :draw_static_tests, :second_tests, except: [:home]
    end
    assert_equal 6, Rails.application.routes.set.count
    route_presence(false, [:home])
  end

  def test_with_namespaced_route
    Rails.application.routes.draw do
      namespace :v1 do
        namespace :api do
          draw_static :namespaced
        end
      end
    end

    route_presence(true, [:v1_api_home])
  end

  private

  def route_presence(condition, routes)
    routes.each do |route|
      assert_equal condition, rails_recognizes_route?(route)
    end
  end

  def rails_recognizes_route?(route)
    Rails.application.routes.named_routes.route_defined?("#{route}_path")
  end
end
