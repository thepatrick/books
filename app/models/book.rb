class Book < ActiveRecord::Base
  
  scope :finished, where('ended IS NOT NULL')
  
  belongs_to :kind
  
end
