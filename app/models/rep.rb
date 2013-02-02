class Rep
  include Mongoid::Document
  field :count, type: Integer
  field :weight, type: Integer
  field :lift_id, type: Integer
end
