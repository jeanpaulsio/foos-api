class User < ApplicationRecord
  has_secure_password

  validates :handle, presence: true, length: { maximum: 15 }
end
