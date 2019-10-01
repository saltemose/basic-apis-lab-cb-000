class RepositoriesController < ApplicationController

  def search

  end

  def github_search
    @resp = Faraday.get'https://api.github.com/search/repositories' do |req|
      req.params['client_id'] = 'ec0c70033670cfb14d75'
      req.params['client_secret'] = '773b6ff13c6dfa2a8c08c60ffe55831515799fd8'
      req.params['q'] = params[:query]
    end
    hash = JSON.parse(@resp.body)
    if @resp.success?
      @items = hash['items']
      @name = hash['items'][0]['name']
      @url = hash['items'][0]['owner']['url']
    else
      @error = hash['errors'][0]['message']
    end
    render 'search'
  end
end
