# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Website

website = Website.new
website.name = "Amazon"
website.save

# Web page 1

web_page = WebPage.new
web_page.website_id = website.id
web_page.url = 'http://www.amazon.com/gp/bestsellers/grocery/ref=pd_dp_ts_gro_1'
web_page.next_page_link_path = '#pagnNextLink'
web_page.pagination_links_parent_path = '.zg_pagination .zg_page'
web_page.pagination_links_path = 'a[1]'
web_page.products_parent_path = '#zg_centerListWrapper .zg_itemImmersion'
web_page.products_link_path = '.zg_title a[1]'
web_page.file_name = 'test_products.xlsx'
web_page.sheet_name = 'test100_products'
web_page.save

# Page content 1

page_content = PageContent.new
page_content.content_field = 'Product Title'
page_content.content_path = '#productTitle'
page_content.web_page_id = web_page.id
page_content.save

page_content = PageContent.new
page_content.content_field = 'Brand'
page_content.content_path = '#brand'
page_content.web_page_id = web_page.id
page_content.save

page_content = PageContent.new
page_content.content_field = 'Price'
page_content.content_path = '#priceblock_ourprice'
page_content.web_page_id = web_page.id
page_content.save

# # web page 2
# web_page = WebPage.new
# web_page.website_id = website.id
# web_page.url = 'http://www.amazon.com/s/ref=lp_2238192011_nr_p_n_feature_three_br_4?fst=as%3Aoff&rh=n%3A2238192011%2Cp_n_feature_three_browse-bin%3A2749134011&bbn=2238192011&ie=UTF8&qid=1441034182&rnid=7239370011'
# web_page.next_page_link_path = '#pagnNextLink'

# web_page.pagination_links_parent_path = ''
# web_page.pagination_links_path = ''
# web_page.products_parent_path = '#s-results-list-atf .s-result-item'
# web_page.products_link_path = '.s-item-container .a-spacing-mini .a-link-normal'
# web_page.file_name = 'test_products'
# web_page.save