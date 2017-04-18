class HomeController < ApplicationController
  def index
    @featured_creations = Creation.where('featured = ?', true)
  end

  def contact
  end

  def help
  end
end
