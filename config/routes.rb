Rails.application.routes.draw do

  match 'new_action', :to => 'foreman_monitoring/hosts#new_action'

end
