Threedog::Application.routes.draw do
  root to: 'application#index'


  get :stream_listen, to: 'stream#stream_listen'
  post :stream_broadcast, to: 'stream#stream_broadcast'
  get :broadcast, to: 'stream#broadcast'
  get :listen, to: 'stream#listen'

  require 'sidekiq/web'
  mount Sidekiq::Web, at: 'sidekiq'
  mount PgHero::Engine, at: 'pghero'
end
