# == Schema Information
#
# Table name: visits
#
#  id      :bigint           not null, primary key
#  user_id :integer          not null
#  url_id  :integer          not null
#


class Visit < ApplicationRecord
    belongs_to :visitor, 
        class_name: "User",
        primary_key: :id,
        foreign_key: :user_id

    belongs_to :visted_url,
        class_name: "ShortendUrl",
        primary_key: :id,
        foreign_key: :url_id

  validates :url_id, presence: true
  validates :user_id , presence: true

  def self.record_visit!(user, shortened_url)
    self.create!
    {user_id: user.id, short_url: shortened_url.id}
  end

end
