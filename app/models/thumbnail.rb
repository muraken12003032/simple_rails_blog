class Thumbnail < ActiveRecord::Base
  belongs_to :blog
  belongs_to :picture
end
