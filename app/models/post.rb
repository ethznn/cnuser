class Post < ActiveRecord::Base
    has_many :replies
    def self.search(search)
        where("post_title LIKE ? OR post_content LIKE ? OR post_name LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%")
    end
end
