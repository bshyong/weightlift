class Quote
  include Mongoid::Document
  include Mongoid::Timestamps

  field :content, type: String
  field :attribution, type: String
end
