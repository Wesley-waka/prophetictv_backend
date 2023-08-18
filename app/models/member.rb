class Member < ApplicationRecord
    # require 'securerandom'
    has_secure_password
    validates :password_digest,confirmation: true
    # validates :password_confirmation, presence: true
    has_one :appointment
    has_many :prayers
    # belongs_to :church
    has_one :admin
end
