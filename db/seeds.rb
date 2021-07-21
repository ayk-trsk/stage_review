# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
  email: 'admin@example.com',
  password: 'admins'
)

Genre.create!(
  name: 'ストレートプレイ'
)

Genre.create!(
  name: 'ミュージカル'
)

Genre.create!(
  name: 'お笑い'
)

Genre.create!(
  name: '2.5次元舞台'
)

Genre.create!(
  name: '落語・寄席'
)

Genre.create!(
  name: '伝統芸能'
)

Genre.create!(
  name: 'ダンス・パフォーマンス'
)
