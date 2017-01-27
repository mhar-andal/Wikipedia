# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
def create_random_paragraph
  paragraph = ""
  rand(5..20).times do
    paragraph = paragraph + " " + Faker::Hacker.say_something_smart
  end
  paragraph
end

categories = ["food", "music", "math", "science", "literature", "animals"]
categories.each do |category|
  Category.create(
    name: category
    )
end

12.times do
  User.create(
    username: Faker::Internet.user_name,
    password: "password1"
    )
end

User.create(
  username: "Dereck",
  password: "password1",
  admin: true
  )
User.create(
  username: "Mhar",
  password: "password1",
  admin: true
  )
User.create(
  username: "Kam",
  password: "password1",
  admin: true
  )

puts "articles"

100.times do
  article = Article.create(
    author_id: rand(1..15),
    submission_status: ["submitted", "unsubmitted", "needs sources"].sample,
    category_id: rand(1..6)
    )
    p article.errors
end

puts "sections"

300.times do
  Section.create(
    article_id: rand(1..100)
    )
end

x = 1
100.times do
  Section.create(
    article_id: x
    )
  x = x + 1
end

puts "notes and bib"

300.times do
  Note.create(
    comment: Faker::ChuckNorris.fact,
    article_id: rand(1..100)
    )
  Bibliography.create(
    article_id: rand(1..100),
    reference: [Faker::Internet.url, Faker::Book.title].sample,
    resource_type: ["Book", "Link"].sample
    )
end

puts "revision 1"

200.times do
  Revision.create(
    title: Faker::Book.publisher,
    paragraph: create_random_paragraph,
    revisionable_id: rand(1..100),
    revisionable_type: "Article"
    )
end

puts "revision 2"


x = 1
100.times do
  Revision.create(
    title: Faker::Book.publisher,
    paragraph: create_random_paragraph,
    publication_status: true,
    revisionable_id: x,
    revisionable_type: "Article"
    )
  x += 1
end

puts "revision 3"


600.times do
  Revision.create(
    title: Faker::Book.publisher,
    paragraph: create_random_paragraph,
    publication_status: false,
    revisionable_id: rand(1..300),
    revisionable_type: "Section"
    )
end

puts "revision 3"

x = 301
100.times do
  Revision.create(
    title: Faker::Book.publisher,
    paragraph: create_random_paragraph,
    publication_status: true,
    revisionable_id: x,
    revisionable_type: "Section"
    )
  x += 1
end

puts "article revisions"

Article.all.each do |article|
  if article.submission_status == "submitted"
    article.revisions << Revision.new(
    title: Faker::Book.publisher,
    paragraph: create_random_paragraph,
    publication_status: false
    )
  end
end

Article.all.each do |article|
  if article.submission_status == "submitted"
    article.sections.sample.revisions << Revision.new(
    title: Faker::Book.publisher,
    paragraph: create_random_paragraph,
    publication_status: false
    )
  end
end

Article.all.each do |article|
  if article.submission_status == "submitted"
    article.sections.sample.revisions << Revision.new(
    title: Faker::Book.publisher,
    paragraph: create_random_paragraph,
    publication_status: false
    )
  end
end

puts "categories"
