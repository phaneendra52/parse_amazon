# parse_amazon

rake db:create
rake db:migrate
rake db:seed

rails c
website = Website.first
website.parse_products