class Api::PostsController < ApplicationController

  def index
    attribute = params.keys.first
    value = params[attribute]
    if attribute == "tags"
      if params[:tags].nil? || params[:tags].empty?
        render json: { 'error': 'Tags parameter is required' }, status: 400
      else
        tags_query
      end
    elsif attribute == "sort_by"
      sort_by_attribute
    end
  end

  private

  def post_params
    params.permit(:author, :author_id, :likes, :popularity, :reads, :tags)
  end

  def tags_query
    posts = Post.where("array_to_string(tags, '||') ILIKE :tags", tags: "%#{params[:tags]}%")
    render json: posts
  end

  def sort_by_attribute
    attribute = params.keys.first
    value = params[attribute]
    direction = params.keys[1]
    formatted = params[direction].upcase
    posts = Post.order("#{value} #{formatted}")
    render json: posts
  end
end
