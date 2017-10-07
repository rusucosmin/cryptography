Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/' => 'application#show'
  post '/encrypt' => 'application#encrypt'
  post '/decrypt' => 'application#decrypt'
end
