class User < ApplicationRecord

    validates :email, presence: true, uniqueness: true, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/ }

    has_secure_password

    has_many :posts, dependent: :nullify
    has_many :comments, dependent: :nullify


end
