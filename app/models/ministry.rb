class Ministry < ApplicationRecord
    has_many :members, dependent: :destroy
    has_one :admin, dependent: :destroy
end
