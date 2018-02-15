User.destroy_all
Game.destroy_all
Team.destroy_all

# Create Users
users = %w[
  jp cru daniel extros frank
  hellojebus jm johnny max mj
  seaczar softpaws
]

users.each do |user|
  u                       = User.new
  u.handle                = user
  u.password              = 'password'
  u.password_confirmation = 'password'
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
team1.captain = hellojebus
team1.player  = extros
team1.save

team2 = Team.new
team2.captain = jm
team2.player  = daniel
team2.save

team3 = Team.new
team3.captain = seaczar
team3.player  = frank
team3.save

puts '======== Created 3 Teams ========'
