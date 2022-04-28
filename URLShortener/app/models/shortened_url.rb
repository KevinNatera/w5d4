# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint           not null, primary key
#  short_url  :string           not null
#  long_url   :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ShortenedURL < ApplicationRecord

    belongs_to :user,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :User

    has_many :visitors,
        primary_key: :id,
        foreign_key: :short_url_id,
        class_name: :Visit


    def self.random_code 
        url = SecureRandom::urlsafe_base64(22)
        
        while self.exists?(url)
            url = SecureRandom::urlsafe_base64(22)
        end

        url
    end

    def self.generate_shorturl(user, long_url)
        short_url = self.random_code
       
        ShortenedURL.create!(short_url: short_url[0..5], long_url: long_url, user_id: user.id)
    end
end

# require 'base64'
# $global_hash = Hash.new
# def encode(longUrl)
#     shortUrl = Base64.encode64(longUrl)[0..5]
#     $global_hash[shortUrl] = longUrl
#     shortUrl
# end
# def decode(shortUrl)
#   $global_hash[shortUrl]
# end
# p decode(encode("https://leetcode.com/problems/design-tinyurl"))
# p decode(encode("https://www.google.com"))
