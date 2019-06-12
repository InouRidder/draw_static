# frozen_string_literal: true

class SecondTestsController < ActionController::Base
  before_action :home, :do_nothing

  def hyphen_me; end

  def more_pages; end

  def about0tests; end

  private

  def hope_im_not_a_route; end
end
