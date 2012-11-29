namespace :db do
  desc "Populate db with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    Product.transaction do
      6.times do
        Product.create!(
          :title => Faker::Lorem.words(2).join(' ').capitalize,
          :description => Faker::Lorem.paragraph(5),
          :price => rand(100..9999)
        )
      end
    end
    Showcase.transaction do
      6.times { FactoryGirl.create(:showcase) }
    end
  end
end
