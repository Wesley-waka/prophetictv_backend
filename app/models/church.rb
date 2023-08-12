class Church < ApplicationRecord
    has_many :members
    has_many :admins
  end
  