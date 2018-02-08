class User < ApplicationRecord
  has_many :primary_teams,   class_name: 'Team', foreign_key: 'captain_id'
  has_many :secondary_teams, class_name: 'Team', foreign_key: 'player_id'

  before_save :downcase_email

  has_secure_password
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :handle, presence: true, length: { maximum: 15 }
  validates :email,  presence: true, length: { maximum: 255 },
                     format: { with: VALID_EMAIL_REGEX },
                     uniqueness: { case_sensitive: false }

  def self.from_token_request(request)
    handle = request.params['auth'] && request.params['auth']['handle']
    self.find_by(handle: handle)
  end

  private

  def downcase_email
    self.email = email.downcase
  end
end
