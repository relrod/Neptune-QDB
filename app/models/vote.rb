class Vote < ActiveRecord::Base
  belongs_to :quote
  #validates_uniqueness_of :ip_address, :scope => :quote_id, :message => "has already rated this quote."
  validates_presence_of :quote_id, :ip_address, :direction
  validates_associated :quote

  named_scope :up, :conditions => {:direction => '+'}
  named_scope :down, :conditions => {:direction => '-'}
end
