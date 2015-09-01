class CreateWebPages < ActiveRecord::Migration
  def change
    create_table :web_pages do |t|
      t.string :url
      t.string :next_page_link_path
      t.string :pagination_links_parent_path
      t.string :pagination_links_path
      t.string :products_parent_path
      t.string :products_link_path
      t.integer :website_id
      t.string :file_name
      t.string :sheet_name
      t.timestamps null: false
    end
  end
end
