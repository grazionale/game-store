if Rails.env.development? || Rails.env.test?
  require 'factory_bot'

  namespace :dev do
    desc 'Sample data for local development environment'
    # db:setup é muito útil aqui porque ele é capaz de criar o banco (se não existir), 
    # recarregar o schema do zero e executar os seeds. Então cada vez que executarmos esta task, 
    # teremos um banco novo
    task prime: 'db:setup' do
      include FactoryBot::Syntax::Methods

      # criando 15 usuários aleatórios
      15.times do
        profile = [:admin, :client].sample
        create(:user, profile: profile)
      end

      1.times do
        profile = :admin
        create(:user, profile: profile, email: 'admin@admin.com', password: '123456')
      end

      system_requirements = []
      ['Basic', 'Intermediate', 'Advanced'].each do |sr_name|
        system_requirements << create(:system_requirement, name: sr_name)
      end

      15.times do
        coupon_status = [:active, :inactive].sample
        create(:coupon, status: coupon_status)
      end

      categories = []
      25.times do
        categories << create(:category, name: Faker::Game.unique.genre)
      end

      30.times do
        game_name = Faker::Game.unique.title
        availability = [:available, :unavailable].sample
        categories_count = rand(0..3)
        game_categories_ids = []
        categories_count.times { game_categories_ids << Category.all.sample.id }
        game = create(:game, system_requirement: system_requirements.sample)
        create(:product, name: game_name, status: availability, 
                         category_ids: game_categories_ids, productable: game)
      end 

      50.times do 
        game = Game.all[0...5].sample
        status = [:available, :in_use, :inactive].sample
        platform = [:steam, :battle_net, :origin].sample
        create(:license, game: game, status: status, platform: platform)
      end   
    end
  end
end