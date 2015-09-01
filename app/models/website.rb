class Website < ActiveRecord::Base

  has_many :web_pages

  accepts_nested_attributes_for :web_pages, :allow_destroy => true

  attr_accessor :next_page_link_path, :pagination_links_parent_path, :pagination_links_path, :products_parent_path, :products_link_path, :file_name, :sheet_name, :product_links, :agent, :page, :web_page

  def parse_products
    web_pages.each do |web_page|
      @web_page = web_page
      set_params
      parse_webpage
    end
  end

  def parse_webpage
    get_all_product_links
    #for presentation purpose only
    # @product_links = ["http://www.amazon.com/KIND-Spices-Chocolate-Ounce-Count/dp/B007PE7ANY", "http://www.amazon.com/Natures-Way-Organic-Coconut-32-Ounce/dp/B003OGKCDC", "http://www.amazon.com/KIND-Peanut-Butter-Chocolate-Protein/dp/B003TNANSO"]
    sheet, book = return_worksheet_and_workbook
    @product_links.each_with_index do |product_link, product_index|
      agent = Mechanize.new
      page = agent.get(product_link)
      sleep(3)
      @web_page.page_contents.each_with_index do |page_content, column_index|
      if product_index == 0
        cell = sheet.add_cell(0, column_index, page_content.content_field)
      end
        content = page.at(page_content.content_path)
        if content.present?
          cell = sheet.add_cell(product_index+1, column_index, content.text)
        end
      end
    end
    book.write @file_name
  end

  private

    def set_params
      webpage_url = @web_page.url
      @next_page_link_path = @web_page.next_page_link_path
      @pagination_links_parent_path = @web_page.pagination_links_parent_path
      @pagination_links_path = @web_page.pagination_links_path
      @products_parent_path = @web_page.products_parent_path
      @products_link_path = @web_page.products_link_path
      @file_name = @web_page.file_name
      @sheet_name = @web_page.sheet_name
      @product_links = []
      @agent = Mechanize.new
      @page = @agent.get(webpage_url)
    end

    def return_workbook
      if File.exist?(@file_name)
        book = RubyXL::Parser.parse(@file_name)
      else
        book = RubyXL::Workbook.new
      end
      return book
    end

    def return_worksheet_and_workbook
      book = return_workbook
      sheet = book[@sheet_name]
      if sheet.blank?
        @sheet_name = @sheet_name.gsub("/", "-")
        sheet = book[@sheet_name]
        if sheet.blank?
          sheet = book["Sheet1"]
          if sheet.present?
            sheet.sheet_name = @sheet_name
          else
            sheet = book.add_worksheet(sheet_name)
          end
        end
      end
      sheet.delete_column
      return [sheet, book]
    end

    def get_product_view_links
      @page.search(products_parent_path).each do |product|
        @product_links << product.at(products_link_path).attr('href').strip
      end
    end

    def get_all_product_links
      if @page.present?
        next_page = @page.at(@next_page_link_path)
        pagination_links = @page.search(@pagination_links_parent_path)
        get_product_view_links
        if next_page.present?
          while next_page.present? do
            next_page_link = next_page.attr('href')
            @page = @agent.get(next_page_link)
            sleep(3)
            next_page = @page.at(@next_page_link_path)
            get_product_view_links
          end
        elsif pagination_links.present?
          pagination_links = pagination_links[1..-1]
          pagination_links.each do |pagination_link|
            pagination_link = pagination_link.attr('href')
            @page = @agent.get(pagination_link)
            sleep(3)
            get_product_view_links
          end
        end
      else
        puts "page doesn't exist"
      end
    end

end