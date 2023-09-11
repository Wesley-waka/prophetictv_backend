class Admin < ApplicationRecord
    # require 'securerandom'
    has_secure_password
    
    belongs_to :ministry
    has_many :members, through: :church
    has_many :sermons
    has_many :prayers
    validates :password,presence: true
    validates :email,uniqueness: true,presence: true
end
