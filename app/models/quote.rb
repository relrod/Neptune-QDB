class Quote < ActiveRecord::Base
  has_many :votes
  cattr_reader :per_page
  @@per_page = 10
end
