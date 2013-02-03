class Lift
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :description, type: String
  has_many :reps
  has_key :name, unique: true
  belongs_to :user, inverse_of: :lifts

  validates_presence_of :name
  validates_uniquness_of :name

end
