Final::Application.routes.draw do
  
  
  root to: "static_pages#home"  
  
  resources :attributes do
    collection do
      put 'dashboard'
    end
  end    

  resources :tables do
    collection do
      put 'dashboard'
    end
  end
    
  resources :queries

  resources :songs do
    collection do
      get 'analysis'
    end
  end  
  
  resources :terms do
    collection do
      get 'term_analysis'
    end
  end
  resources :artists do
    collection do
      get 'analysis'
    end
  end

end      
 

