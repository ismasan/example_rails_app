namespace :db do
  desc "populate posts"
  task :populate => :environment do
    require 'faker'
    Post.destroy_all
    
    1.upto(50) do |i|
      p = Post.create do |post|
        post.title = Faker::Lorem.words.join(' ')
        post.body = Faker::Lorem.paragraphs.join('\rn\rn')
      end
      puts "Created post #{i} #{p.to_param}"
      p.comments.create(:body => Faker::Lorem.sentences.join('\rn'))
    end
  end
end