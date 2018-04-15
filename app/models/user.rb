class User < ApplicationRecord
  belongs_to :group, optional: true
  attribute :type, :string, default: 'Public'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable, :authentication_keys => [:login]
  # Rails Admin config
  rails_admin do
    weight 1
    edit do
      field :username
      field :type
      field :group
      field :email
    end
    list do
      field :username
      field :type
      field :group
      field :email
      field :created_at
      field :current_sign_in_at
    end
  end

  attr_accessor :login

  validate :validate_username
  validates :group, presence: true, on: :update, unless: :public_type?

  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

  validates :username,
  :presence => true,
  :uniqueness => {
    :case_sensitive => false
  }
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true

  # enum type: { Public: 'Public', Employee: 'Employee', Administrator: 'Administrator' }

  def type_enum
    # ['Public', 'Employee', 'Administrator']
    # [ %w(Public Public), %w(Employee Employee), %w(Administrator Administrator) ]
    { I18n.t('activerecord.models.public.one') => 'Public', 
    I18n.t('activerecord.models.employee.one') => 'Employee', 
    I18n.t('activerecord.models.administrator.one') => 'Administrator',
    I18n.t('activerecord.models.accountant.one') => 'Accountant',
    I18n.t('activerecord.models.executive.one') => 'Executive' }
  end

  def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      elsif conditions.has_key?(:username) || conditions.has_key?(:email)
        where(conditions.to_h).first
      end
  end

  def public_type?
    type == "Public"
  end

end

class Administrator < User
  belongs_to :group
end

class Employee < User
  belongs_to :group
end

class Accountant < User
  belongs_to :group
end

class Executive < User
  belongs_to :group
end

class Public < User

end
