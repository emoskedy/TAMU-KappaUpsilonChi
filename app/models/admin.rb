class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :omniauthable, omniauth_providers: [:google_oauth2]
  has_many :checks

  def officer?
    is_officer
  end

  def admin?
    is_admin
  end

  def member?
    is_member
  end

  def self.from_google(email:, full_name:, uid:, avatar_url:)
    # return nil unless email =~ /@mybusiness.com\z/
    create_with(uid: uid, full_name: full_name, avatar_url: avatar_url).find_or_create_by!(email: email)
  end

  validates :email, presence: true  # Add other validations as needed
  validates :full_name, presence: true
  attr_accessor :role

end
