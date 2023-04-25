class User < ApplicationRecord
  has_secure_password
  validates :email, uniqueness: { case_sensitive: false }, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, length: { minimum: 6 }, presence: true
  validates :password_confirmation, presence: true
  before_save :downcase_email

  def self.authenticate_with_credentials(email, password)
      user = User.find_by_email(email.strip.downcase)
      if user && user.authenticate(password)
          user
      else
          nil
      end
  end

  private

  def downcase_email
      self.email.downcase!
  end  
end
