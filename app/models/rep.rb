class Rep
  include Mongoid::Document
  include Mongoid::Timestamps

  field :count, type: Integer
  field :weight, type: Integer
  field :lift_id, type: Integer
  belongs_to :lift, inverse_of: :reps
end
