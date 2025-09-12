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
event = Event.create!(group: group, title: "9月の飲み会候補日")

# ユーザーを作成
user1 = User.create!(name: "Alice", group: group)
user2 = User.create!(name: "Bob", group: group)
user3 = User.create!(name: "Charlie", group: group)

# 投票を作成
Vote.create!(event: event, user: user1, name: "Alice", date: Date.today + 1, status: :ok)
Vote.create!(event: event, user: user2, name: "Bob", date: Date.today + 1, status: :no)
Vote.create!(event: event, user: user3, name: "Charlie", date: Date.today + 1, status: :maybe)

Vote.create!(event: event, user: user1, name: "Alice", date: Date.today + 2, status: :no)
Vote.create!(event: event, user: user2, name: "Bob", date: Date.today + 2, status: :ok)
Vote.create!(event: event, user: user3, name: "Charlie", date: Date.today + 2, status: :ok)

Vote.create!(event: event, user: user1, name: "Alice", date: Date.today + 3, status: :maybe)
Vote.create!(event: event, user: user2, name: "Bob", date: Date.today + 3, status: :maybe)
Vote.create!(event: event, user: user3, name: "Charlie", date: Date.today + 3, status: :no)

