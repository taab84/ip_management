class User < ApplicationRecord
  attribute :type, :string, default: 'Reception'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  def self.types
    %w(Administrator Reception)
  end
end

class Administrator < User

end

class Reception < User

end
