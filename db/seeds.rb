User.destroy_all
Game.destroy_all
Team.destroy_all

# Create Users
users = %w[
  jp jm daniel extros
  hellojebus cru seaczar
  frank
]

users.each do |user|
  u                       = User.new
  u.handle                = user
  u.password              = 'foobar'
  u.password_confirmation = 'foobar'
  u.save
end

puts "======== Created #{users.length} Users ========"

# Create Teams
jp         = User.find_by_handle('jp')
hellojebus = User.find_by_handle('hellojebus')
extros     = User.find_by_handle('extros')
jm         = User.find_by_handle('jm')
daniel     = User.find_by_handle('daniel')
seaczar    = User.find_by_handle('seaczar')
frank      = User.find_by_handle('frank')

team1         = Team.new
team1.captain = jp
team1.player  = extros
team1.save

team2         = Team.new
team2.captain = hellojebus
team2.player  = extros
team2.save

team3 = Team.new
team3.captain = jm
team3.player  = daniel
team3.save

team4 = Team.new
team4.captain = seaczar
team4.player  = frank
team4.save

puts '======== Created 4 Teams ========'
