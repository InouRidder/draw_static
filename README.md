A gem for rails routes to avoid repetition

get 'home', to: 'pages#home'
get 'about', to: 'pages#about'
get 'contact-us', to: 'pages#contact_us'

Familiar?

gem 'draw_static'

draw_static :pages

Will auto generate the static routes

disclaimer: The controller action has to be the same as the route. All non-word characters in the controller actions name are replaced by hyphens.

