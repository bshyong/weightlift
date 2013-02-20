class User
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :reps
  accepts_nested_attributes_for :reps
  has_and_belongs_to_many :badges

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""

  validates_presence_of :email
  validates_presence_of :encrypted_password

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String
  # run 'rake db:mongoid:create_indexes' to create indexes
  index({ email: 1 }, { unique: true, background: true })
  index({ username: 1 }, { unique: true, background: true })

  field :username, :type => String
  validates_presence_of :username
  validates_format_of :username, :with => /^[A-Za-z\d]+$/, :message => ": Only letters and digits, please!"
  validates_uniqueness_of :username, :case_sensitive => false

  field :username_slug, :type => String

  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :created_at, :updated_at

  before_save :build_username_slug

  # downcases username and removes non alphanumerics
  def build_username_slug
    self.username_slug = self.username.delete(' ').downcase
  end

  def top_lifts_by_rep_count(limit = 4)
    raise "Parameter must be an Integer!" unless limit.kind_of? Integer
    lifts = Hash.new
    self.reps.each do |x|
      begin
        lifts[x.lift.name] += x.count
      rescue
        lifts[x.lift.name] ||= x.count
      end
    end
    lifts.sort{|a,b| b[1] <=> a[1]}.take(limit)
  end

end
