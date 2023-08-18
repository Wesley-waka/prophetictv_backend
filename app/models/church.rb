class Church < ApplicationRecord
    has_many :members
    belongs_to :admin
  end
  