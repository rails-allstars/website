class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  has_and_belongs_to_many :tags
  
end
