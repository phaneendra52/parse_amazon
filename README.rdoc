
Step1: Open terminal and fire command 'git clone https://github.com/phaneendra52/parse_amazon.git'

Step2: cd parse_amazon

Step3: rake db:drop

Step4: rake db:create

Step5: rake db:migrate

Step6: rake db:seed

Step7: rails c

Step8:

  website = Website.first
  website.parse_products

Step9:

  Then you can see file with name "test_products.xlsx", in this file all 100 products details will be saved.
  Now I am saving "Product Title, Brand, Price".

Step10:

  You can see explanation about seed data in "seed.png"

Step11:

  If you want to get data from any other pages you can configure from "http://localhost:3000/websites/new".