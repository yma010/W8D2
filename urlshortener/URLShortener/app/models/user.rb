# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ApplicationRecord

  has_many :submitted_urls,
   class_name: "ShortenedUrl",
   primary_key: :id,
   foreign_key: :user_id
  
   has_many :visited_urls,
    class_name: "Visit",
    primary_key: :id,
    foreign_key: :user_id
    
validates :email, presence: true
validates :email, uniqueness: true

end
