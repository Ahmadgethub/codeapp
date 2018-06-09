# == Schema Information
#
# Table name: posts
#
#  id               :bigint(8)        not null, primary key
#  title            :string(255)
#  body             :text(65535)
#  description      :text(65535)
#  slug             :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  banner_image_url :string(255)
#  author_id        :integer
#  puplished        :boolean          default(FALSE)
#  published_at     :datetime
#
 
class Post < ApplicationRecord
    extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :author

scope :most_recent,->{order(published_at: :desc) }
scope :published, -> { where(published: true) }
def should_generate_new_friendly_id?
    title_changed?
end

def display_day_published
    if published_at.present?
    "published #{published_at.strftime('%-b %-d %-Y')}"
    else
        "Not published yet."
    end
end

def publish
    update(published: true, published_at: Time.now)
end

def unpublish
    update(published: false, published_at: nil)
end    
end


