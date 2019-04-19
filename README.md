# A gem for rails avoid repetition in writing static routes

```
get 'home', to: 'pages#home'
get 'about', to: 'pages#about'
get 'contact-us', to: 'pages#contact_us'
```

### Familiar?

Add

```
# Gemfile
gem 'draw_static'
```
To the Gemfile and run bundle install

```
# routes.rb

Rails.application.routes.draw do
  draw_static :pages
end
```

This set up will generate the static routes based on the controller actions.
In this case we are generating the routes for the PagesController, if you want to do it for your PublicPagesController then you would pass: :public_pages

disclaimer: The controller action has to be the same name as the route. All non-word characters in the controller actions name are replaced by hyphens.
e.g.
```
def about_us
end
```
Will become
```
get 'about-us', to: 'pages#about_us'
```

### Enjoy!


# Rails

draw_static is based on rails, read more about the rails frame work here
https://github.com/rails/rails
