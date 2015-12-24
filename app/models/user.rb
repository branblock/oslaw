class User < ActiveRecord::Base
  has_many :posts
  has_many :comments

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:login]

  validates_presence_of :first_name, :last_name

  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

  def self.find_first_by_auth_conditions(warden_conditions)
  conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["username = :value OR lower(email) = lower(:value)", { :value => login }]).first
    else
      if conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username]).first
      end
    end
  end

  validates :username,
    :presence => true,
    :uniqueness => {
      :case_sensitive => false
    }

  # Extra level of validation to avoid issues where usernames and emails may overlap
  validate :validate_username

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

  # Roles
  after_initialize :set_role

  def set_role
    self.role  ||= 'standard'
  end

  def standard?
    role == 'standard'
  end

  def admin?
    role == 'admin'
  end

  # paperclip
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "60x60>", nav: "28x28>" }, default_url: "/images/:style/missing.png"
    # Validate content type
  validates_attachment_content_type :avatar, content_type: /\Aimage/

  # act_as_votable
  acts_as_voter
end
