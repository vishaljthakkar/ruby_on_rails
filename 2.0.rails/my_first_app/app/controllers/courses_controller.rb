class CoursesController < ApplicationController

  def index
    # @search_term = 'jhu'
    @search_term = params[:looking_for] || 'jhu'
    @courses = Coursera.for(@search_term)
    # @courses = Coursera.for(@search_term) || [] # If Coursera returns nil send empty to view. You can even fix this in view
  end
end
