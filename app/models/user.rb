class User < ApplicationRecord
  has_secure_password
  has_many :primary_teams,   class_name: 'Team', foreign_key: 'captain_id'
  has_many :secondary_teams, class_name: 'Team', foreign_key: 'player_id'

  VALID_HANDLE_REGEX = /\A[a-z\d]*\Z/i

  validates :handle, presence: true, length: { maximum: 15 },
                     format: {
                       with: VALID_HANDLE_REGEX,
                       message: 'Username must use letters and numbers only'
                     },
                     uniqueness: {
                       case_sensitive: false,
                       message: 'Username is taken'
                     }

  def self.from_token_request(request)
    handle = request.params['auth'] && request.params['auth']['handle']
    find_by(handle: handle)
  end
end
