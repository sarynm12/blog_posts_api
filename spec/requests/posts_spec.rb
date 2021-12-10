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
    
    get "/api/posts?sort_by=id&direction=asc"

    expect(response).to be_successful

    posts = JSON.parse(response.body, symbolize_names: true)
    
    expect(response.status).to eq(200)
    expect(posts[0][:id]).to eq(1)
    expect(posts[1][:id]).to eq(2)
    expect(posts[2][:id]).to eq(3)
  end

  it 'can return posts that have been sorted by popularity' do
    post1 = create(:post, popularity: 0.80)
    post2 = create(:post, popularity: 0.62)
    post3 = create(:post, popularity: 0.94)
    post4 = create(:post, popularity: 0.12)
    post5 = create(:post, popularity: 0.04)

    
    get "/api/posts?sort_by=popularity&direction=desc"

    expect(response).to be_successful

    posts = JSON.parse(response.body, symbolize_names: true)
    
    expect(response.status).to eq(200)
    expect(posts[0][:popularity]).to eq(0.94)
    expect(posts[1][:popularity]).to eq(0.80)
    expect(posts[2][:popularity]).to eq(0.62)
    expect(posts[3][:popularity]).to eq(0.12)
    expect(posts[4][:popularity]).to eq(0.04)
  end

  it 'can return posts that have been sorted by likes' do
    post1 = create(:post, likes: 12)
    post2 = create(:post, likes: 2)
    post3 = create(:post, likes: 84)
    post4 = create(:post, likes: 0)

    
    get "/api/posts?sort_by=likes&direction=desc"

    expect(response).to be_successful

    posts = JSON.parse(response.body, symbolize_names: true)
    
    expect(response.status).to eq(200)
    expect(posts[0][:likes]).to eq(84)
    expect(posts[1][:likes]).to eq(12)
    expect(posts[2][:likes]).to eq(2)
    expect(posts[3][:likes]).to eq(0)
  end

  it 'can return posts that have been sorted by reads' do
    post1 = create(:post, reads: 1242)
    post2 = create(:post, reads: 24)
    post3 = create(:post, reads: 1802)
    post4 = create(:post, reads: 6)

    
    get "/api/posts?sort_by=reads&direction=asc"

    expect(response).to be_successful

    posts = JSON.parse(response.body, symbolize_names: true)
    
    expect(response.status).to eq(200)
    expect(posts[0][:reads]).to eq(6)
    expect(posts[1][:reads]).to eq(24)
    expect(posts[2][:reads]).to eq(1242)
    expect(posts[3][:reads]).to eq(1802)
  end

   it 'throws an error if sort by parameter is invalid' do
    get "/api/posts?sort_by="

    error = { 'error': 'sortBy parameter is invalid' }

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
  end
end
