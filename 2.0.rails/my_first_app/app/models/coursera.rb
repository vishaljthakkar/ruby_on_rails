# frozen_string_literal: true

class Coursera
  include HTTParty

  base_uri 'https://api.coursera.org/api/catalog.v1/courses'
  default_params fields: 'smallIcon,shortDescription', q: 'search'
  format :json

  def self.for(search_term)
    get('', query: { query: search_term })['elements']
  end
end
