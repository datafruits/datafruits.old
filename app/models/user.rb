class User < ActiveRecord::Base
  ROLES = %w[admin blogger dj]
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :password_hash, :password_salt, :username, :role, :avatar, :login
  attr_accessor :login

  has_many :shows
  has_attached_file :avatar,
    styles: { :thumb => "140x#" },
    storage: :s3,
    :path => "/:style/:filename",
    s3_credentials: {
      access_key_id: ENV['S3_KEY'],
      secret_access_key: ENV['S3_SECRET']
    },
    bucket: 'datafruits.fm'

  validates_presence_of :username
  validates_uniqueness_of :username
  validates_presence_of     :password, :if => :password_required?
  validates_confirmation_of :password, :if => :password_required?
  validates_length_of :password, :within => Devise.password_length, :allow_blank => true

  validate :valid_role

  def valid_role
    if !ROLES.include?(role)
      errors.add :role, "is not a valid role."
    end
  end

  ROLES.each do |r|
    define_method "#{r}?" do
      role == r
    end
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

end
