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

scope :most_recent,->{order(id: :desc) }
scope :published, -> { where(published: true) }
def should_generate_new_friendly_id?
    title_changed?
end

def display_day_published
    "published #{created_at.strftime('%-b %-d %-Y')}"
end
end
