# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint           not null, primary key
#  long_url   :string
#  short_url  :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShortenedUrl < ApplicationRecord

    belongs_to :submitter, 
        class_name: "User",
        primary_key: :id,
        foreign_key: :user_id

    has_many :visits,
     class_name: "Visit",
     primary_key: :id,
     foreign_key: :url_id

     has_many :visitors,
        Proc.new { distinct }, #<<<
        through: :visits,
        source: :visitor

    validates :long_url, :short_url, :user_id, presence: true 
    validates :long_url, :short_url, uniqueness: true

    def self.random_code
        until !self.short_url.exists? 
            random_code = SecureRandom.urlsafe_base64(16)
        end
    end

    def self.create_url(user, long_url)
        ShortenedUrl.create!
        {user_id: user.id, long_url: long_url, short_url: self.random_code}
    end

    def num_clicks
        visits.count
    end

    def num_uniques
        visitors.count
    end



    def num_recent_uniques
        (<<-SQL )
            SELECT 
            COUNT(DISTINCT user_id)
            FROM
            visits
            WHERE
            visits.shortened_url_id = ? AND
            visits.created_at < 10.minutes.ago
        SQL
    end


end
