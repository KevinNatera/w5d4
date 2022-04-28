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
    validates :email, uniqueness: true
    validates :email, presence: true

    has_many :urls,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :ShortenedURL

    has_many :visited_urls,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :Visit
end
