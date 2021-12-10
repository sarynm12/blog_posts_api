require 'rails_helper'

RSpec.describe "Posts", type: :request do
  it 'can return posts that match the tags query param' do
    post1 = create(:post, tags: ["health", "food"])
    post2 = create(:post, tags: ["news", "sports"])
    post3 = create(:post, tags: ["health", "sports"])
    post4 = create(:post, tags: ["news", "celebrities"])
    
    get "/api/posts?tags=health"

    expect(response).to be_successful

    posts = JSON.parse(response.body, symbolize_names: true)
    
    expect(response.status).to eq(200)
    expect(posts.count).to eq(2)
  end

  it 'throws an error if no tag is provided' do
    get "/api/posts?tags="

    error = { 'error': 'Tags parameter is required' }

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
  end

  it 'can return posts that have been sorted by id' do
    post1 = create(:post, id: 2)
    post2 = create(:post, id: 1)
    post3 = create(:post, id: 3)
    
    get "/api/posts?sort_by=id"

    expect(response).to be_successful

    posts = JSON.parse(response.body, symbolize_names: true)
    
    expect(response.status).to eq(200)
    expect(posts[0][:id]).to eq(1)
    expect(posts[1][:id]).to eq(2)
    expect(posts[2][:id]).to eq(3)
  end
end
