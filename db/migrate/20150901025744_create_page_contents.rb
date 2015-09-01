class CreatePageContents < ActiveRecord::Migration
  def change
    create_table :page_contents do |t|
      t.string :content_path
      t.string :content_field
      t.integer :web_page_id
      t.timestamps null: false
    end
  end
end