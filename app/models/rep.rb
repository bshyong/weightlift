class Rep
  include Mongoid::Document
  include Mongoid::Timestamps

  field :count, type: Integer
  field :weight, type: Integer
  field :total_weight, type: Integer

  scope :recent, order_by(:created_at => :desc)

  belongs_to :lift, inverse_of: :reps
  belongs_to :user, inverse_of: :reps

  before_save :calculate_total_weight

  def calculate_total_weight
    self.total_weight = self.count*self.weight
  end

end
