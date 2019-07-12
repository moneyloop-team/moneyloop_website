class BlogsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_blog, only: [:show, :edit, :update, :destroy]

  # GET /blogs
  # GET /blogs.json
  def index
    if cookies[:consumer] == 'true'
      @blogs = Blog.where(consumer: 'For Consumer') + Blog.where(consumer: nil)
    else
      @blogs = Blog.where(consumer: 'For Insurer')
    end
    
    @images = []

    # Iterate through each of the blog posts
    @blogs.each do |b|
      # Find the first image attached to the blog, if one exists
      blogimage = Blogimage.where(blog_ref: b.id).first
      if !blogimage.nil?
        @images.push(Image.find(blogimage.im_ref).photo)
      else
        @images.push(nil)
      end
    end

    # zip them together 
    @blogs.zip @images
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
    @blog = Blog.find(params[:id])
    @image = []

    # Get all images attached to the blog_id, if they exist
    blogimage = Blogimage.where(blog_ref: params[:id])
    blogimage.each do |b|
      @image.push(Image.find(b.im_ref).photo)
    end
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
    @blog = Blog.find(params[:id])
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = Blog.new(blog_params)
    respond_to do |format|
      if @blog.save
        # Check if any images have been uploaded
        if !params[:blog][:im_id].nil?
          # Get the ID's of the images and add them to a new blogimage object
          params[:blog][:im_id].each do |im_id|
            @blogimage = Blogimage.new(blog_ref: @blog.id, im_ref: im_id)
            @blogimage.save
          end
        end
        format.html { redirect_to @blog, notice: 'Blog was successfully created.' }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: 'Blog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /blogs/upload
  def upload
    # Create a new image model && attach an Active Storage photo to it
    @image = Image.new(image_params)
    @image.photo.attach(params[:image][:photo])

    respond_to do |format|
      if @image.save
        # Image is in db, return AJAX request with the url and ID
        format.json { render json: {image: url_for(@image.photo), id: @image.id, refs: 1}}   
      else
        # Something went wrong, send an error
        format.json { render json: @image.errors, status: :unprocessable_entity  }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Form parameters for the blog model
    def blog_params
      params.require(:blog).permit(:title, :text, :consumer)
    end

    # Form parameters for the image model
    def image_params
      params.require(:image).permit(:photo)
    end
end
