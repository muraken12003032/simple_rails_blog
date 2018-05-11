class Blog < ActiveRecord::Base
  belongs_to :picture
  has_many :comments, dependent: :destroy
end
