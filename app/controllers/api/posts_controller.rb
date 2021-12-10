class Api::PostsController < ApplicationController

  def index
    attribute = params.keys.first
    value = params[attribute]
    if attribute == "tags"
      if params[:tags].nil? || params[:tags].empty?
        render json: { 'error': 'Tags parameter is required' }, status: 400
      else
        split = value.split(/\W+/)
        posts = Post.where("array_to_string(tags, '||') ILIKE :tags", tags: "%#{params[:tags]}%")
        render json: posts
      end
    end
  end

  private

  def post_params
    params.permit(:author, :author_id, :likes, :popularity, :reads, :tags)
  end
end
