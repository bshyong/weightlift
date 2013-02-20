class Badge
  include Mongoid::Document

  has_and_belongs_to_many :users

  field :name, type: String
  field :point_value, type: Integer
  field :level, type: Integer, default: 1

  validates :name, presence: true, uniqueness: {case_sensitive: false}
  validates :point_value, presence: true

end
