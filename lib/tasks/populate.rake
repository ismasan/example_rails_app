namespace :db do
  desc "populate posts"
  task :populate => :environment do
    require 'faker'
    Post.destroy_all
    
    1.upto(50) do |i|
      p = Post.create do |post|
        post.title = Faker::Lorem.words.join(' ')
        post.body = Faker::Lorem.paragraphs.join('\rn\rn')
        set_dates(post,i)
      end
      puts "Created post #{i} #{p.to_param}"
      1.upto(rand(50)) do |c|
        puts "-------------- creating comment #{c} for post #{i}"
        p.comments.create do |com|
          com.body = Faker::Lorem.sentences.join('\rn')
          set_dates(com,c)
        end
      end
    end
  end
end


def set_dates(model,i=1,max=50)
  model.is_published = [true,false][rand(2)]
  d = (max/2).days.ago + i.days
  model.created_at = d
  model.publish_at = d
  if rand(2) < 1
    model.unpublish_at = d + (rand(20)+1).days
  end
end