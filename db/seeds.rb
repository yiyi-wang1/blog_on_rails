# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Post.destroy_all

60.times do |n|
    p = Post.create(
        title: Faker::Lorem.unique.sentence,
        body: Faker::Lorem.paragraph(sentence_count: 3)
    )

    if p.valid?
        rand(1..10).times do 
            Comment.create(
                body: Faker::Lorem.paragraph(sentence_count: 2),
                post: p
            )
        end
    end
end

posts = Post.all
comments = Comment.all

p "Created #{posts.count} posts and #{comments.count} comments"
