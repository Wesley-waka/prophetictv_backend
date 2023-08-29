class Church < ApplicationRecord
    has_many :members
    has_one :admin
  end
  