class WebsitesController < ApplicationController
  before_action :set_website, only: [:show, :edit, :update, :destroy]

  def index
    @websites = Website.all
  end

  def show
  end

  def new
    @website = Website.new
    build_objects
  end

  def edit
  end

  def create
    @website = Website.new(website_params)
    respond_to do |format|
      if @website.save
        format.html { redirect_to @website, notice: 'Website was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @website.update(website_params)
        format.html { redirect_to @website, notice: 'Website was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @website.destroy
    respond_to do |format|
      format.html { redirect_to websites_url, notice: 'Website was successfully destroyed.' }
    end
  end

  private

    def set_website
      @website = Website.find(params[:id])
    end

    def build_objects
      web_page = @website.web_pages.build
      web_page.page_contents.build
    end

    def website_params
      params.require(:website).permit(
        :name,
        :_destroy,
        web_pages_attributes: [
          :id,
          :_destroy,
          :url,
          :next_page_link_path,
          :pagination_links_parent_path,
          :pagination_links_path,
          :products_parent_path,
          :products_link_path,
          :website_id,
          :file_name,
          :sheet_name,
          page_contents_attributes: [
            :id,
            :_destroy,
            :content_path,
            :content_field,
            :web_page_id
          ]
        ]
      )
    end

end