class Item < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true
  validates :price, :numericality => { :greater_than_or_equal_to => 0 }
  validates :user_id, presence: true

  has_attached_file :picture,
    :styles => { :medium => "300x300>", :thumb => "100x100>" },
    :default_url => "missing.png"
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/
end
