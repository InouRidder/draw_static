A gem for rails routes to avoid repetition

```
get 'home', to: 'pages#home'
get 'about', to: 'pages#about'
get 'contact-us', to: 'pages#contact_us'
```
Familiar?


```
# Gemfile
gem 'draw_static'
```

```
# routes.rb
Rails.application.routes.draw do
  draw_static :pages
end
```


This set up will generate the static routes based on the controller actions.
In this case we are generating the routes for the PagesController

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



