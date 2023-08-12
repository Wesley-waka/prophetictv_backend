class Member < ApplicationRecord
    # require 'securerandom'
    has_secure_password
    

    belongs_to :church
    has_one :admin
end
