class List < ActiveRecord::Base
  belongs_to :user
  has_many :items, dependent: :destroy
  
  validates :list_name, presence: true
  
  accepts_nested_attributes_for :items, reject_if: lambda{ |a| a[:name].blank? }, allow_destroy: true
end
