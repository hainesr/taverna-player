TavernaPlayer::Engine.routes.draw do
  resources :runs, :except => :edit do
    member do
      put "cancel", :action => "cancel"
      get "input/:port", :action => "input"
      get "output/:port(/*path)", :action => "output"
      get "log", :action => "download_log"
      get "results", :action => "download_results"

      scope "proxy" do
        get ":int_id/:name", :action => "read_interaction"
        put ":int_id/:name", :action => "save_interaction"
        post ":int_id", :action => "notification"
      end
    end
  end

  resources :service_credentials
end
