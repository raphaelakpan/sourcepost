class User < ApplicationRecord
  before_save :downcase_email

  validates :name, presence: true,
            length: { minimum: 5, maximum: 50 }

  validates :email, presence: true,
            uniqueness: { case_sensitive: false },
            length: { maximum: 255 },
            format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }

  private

  def downcase_email
    email.downcase!
  end
end
