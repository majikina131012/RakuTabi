# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# グループを作成
group = Group.create!(name: "開発チーム")

# イベントを作成
event = Event.create!(
  group_id: 1,
  title: "9月の飲み会候補日", 
  start_time: Time.zone.now, 
  end_time: Time.zone.now + 2.days
)

# ユーザーを作成
user1 = User.create!(name: "Alice", group: group)
user2 = User.create!(name: "Bob", group: group)
user3 = User.create!(name: "Charlie", group: group)