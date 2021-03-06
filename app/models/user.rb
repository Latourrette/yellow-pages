class User < ApplicationRecord
  has_secure_password
  validates_presence_of :email
  validates_uniqueness_of :email, case_sensitive: false
  validates_format_of :email, with: /@/
  before_save :email_downcase_space_removal

  def email_downcase_space_removal
    self.email = self.email.delete(' ').downcase
  end

end
