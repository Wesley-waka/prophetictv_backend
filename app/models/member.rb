class Member < ApplicationRecord
    # require 'securerandom'
    has_secure_password
    validates :password_digest,confirmation: true
    # validates :password_confirmation, presence: true
    has_many :prayers
    belongs_to :ministry
    has_one :admin
    validates :email,uniqueness: true,presence: true
end
