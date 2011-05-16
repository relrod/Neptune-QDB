class Quote < ActiveRecord::Base
  has_many :votes
end
