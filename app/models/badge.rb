class Badge
  include Mongoid::Document

  field :name, type: String
  field :point_value, type: Integer
  field :level, type: Integer, default: 1

  validates :name, presence: true, uniqueness: {case_sensitive: false}
  validates :point_value, presence: true

  index({ name: 1 }, { unique: true, background: true })

end
