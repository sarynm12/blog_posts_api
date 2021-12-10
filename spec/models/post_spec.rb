require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    it { should validate_presence_of :author }
    it { should validate_presence_of :author_id }
    it { should validate_presence_of :likes }
    it { should validate_presence_of :popularity }
    it { should validate_presence_of :reads }
    it { should validate_presence_of :tags }
  end
end
