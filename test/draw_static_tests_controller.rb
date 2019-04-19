# frozen_string_literal: true

class DrawStaticTestsController < ActionController::Base
  before_action :home, :do_nothing

  def home; end

  def contact; end

  def crazy_Public_page; end

  def about_us; end

  private

  def do_nothing; end

  def not_to_be_included; end
end
