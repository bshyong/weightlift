class Lift
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :description, type: String
  has_many :reps
  accepts_nested_attributes_for :reps

  belongs_to :user, inverse_of: :lifts

  validates_presence_of :name
  validates_uniqueness_of :name

end
