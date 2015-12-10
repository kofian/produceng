CatarseBraintree::Engine.routes.draw do
  resources :braintree, only: [], path: 'payment/braintree' do
    member do
      get  :review
      post :charge
      post :pay
    end
  end
end


