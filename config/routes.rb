Threedog::Application.routes.draw do
  root to: 'application#index'


  get :stream_listen, to: 'stream#stream_listen'
  post :broadcast, to: 'stream#broadcast'

  require 'sidekiq/web'
  mount Sidekiq::Web, at: 'sidekiq'
  mount PgHero::Engine, at: 'pghero'
end
