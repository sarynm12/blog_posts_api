class Api::PostsController < ApplicationController

  def index
    attribute = params.keys.first
    value = params[attribute]
    case attribute
    when "tags" then tags_query
    when "sort_by" then sort_by_query
    end
  end

  private

  def post_params
    params.permit(:author, :author_id, :likes, :popularity, :reads, :tags)
  end

  def tags_query
    if params[:tags].nil? || params[:tags].empty?
      render json: { 'error': 'Tags parameter is required' }, status: 400
    else
      posts = Post.where("array_to_string(tags, '||') ILIKE :tags", tags: "%#{params[:tags]}%")
      render json: posts
    end
  end

  def sort_by_query
    attribute = params.keys.first
    value = params[attribute]
    direction = params.keys[1]
    formatted = params[direction].upcase
    if value.nil? || value.empty? 
      render json: { 'error': 'sortBy parameter is invalid' }, status: 400
    else
      posts = Post.order("#{value} #{formatted}")
      render json: posts
    end
  end
end
