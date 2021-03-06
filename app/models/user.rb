class User < ActiveRecord::Base
  ROLES = %w[admin blogger dj]

  VALID_STYLES =
    ["lovely",
     "freaky",
     "pretty",
     "cutie",
     "freestyle",
     "no-style",
     "funky",
     "spooky",
     "relaxy",
     "hopeless",
     "bored",
     "sporty",
     "worky"]
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :password, :password_confirmation, :remember_me,
  #                 :password_hash, :password_salt, :username, :role, :avatar,
  #                 :login, :role_ids, :time_zone
  attr_accessor :login

  has_many :shows
  has_many :podcasts
  has_attached_file :avatar,
    styles: { :thumb => "x120" },
    path: ":style/:filename"

  validates_presence_of :username
  validates_uniqueness_of :username
  validates_presence_of     :password, :if => :password_required?
  validates_confirmation_of :password, :if => :password_required?
  validates_length_of :password, :within => Devise.password_length, :allow_blank => true
  validates_presence_of :time_zone

  validate :valid_role
  validates_inclusion_of :time_zone, :in => ActiveSupport::TimeZone.all.map { |m| m.name }, :message => "is not a valid Time Zone"

  def self.valid_styles
    VALID_STYLES
  end


  after_create do |user|
    roles = user.roles
    roles << "dj"
    user.role_ids = roles
  end

  def valid_role
    if !role.to_s.blank?
      self.roles.each do |r|
        if !ROLES.include?(r)
          errors.add :role, "is not a valid role."
        end
      end
    end
  end

  def role_ids=(roles)
    role_string = ""
    roles.each do |r|
      role_string << "#{r} "
    end
    role_string.strip!
    self.update_attribute :role, role_string
    self.save!
  end

  ROLES.each do |r|
    define_method "#{r}?" do
      has_role? r
    end
  end

  def roles
    self.role.to_s.split(' ')
  end

  def has_role?(r)
    roles.include?(r)
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
