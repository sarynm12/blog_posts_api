class Post < ApplicationRecord
  validates_presence_of :author,
                        :author_id,
                        :likes,
                        :popularity,
                        :reads,
                        :tags
end
