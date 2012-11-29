class Admin::ShowcasesController < ApplicationController
  layout 'admin'

  # GET /admin/showcases
  def index
    @showcases = Showcase.all
  end

  # GET /admin/showcases/1
  def show
    @showcase = Showcase.find(params[:id])
  end

  # GET /admin/showcases/new
  def new
    @showcase = Showcase.new
  end

  # POST /admin/showcases
  def create
    @showcase = Showcase.new(params[:showcase])
    if @showcase.save
      redirect_to admin_showcase_path(@showcase)
    else
      render action: 'new'
    end
  end

  # GET /admin/showcases/1/edit
  def edit
    @showcase = Showcase.find(params[:id])
  end

  # PUT /admin/showcases/1
  def update
    @showcase = Showcase.find(params[:id])
    if @showcase.update_attributes(params[:showcase])
      redirect_to admin_showcase_path(@showcase)
    else
      render action: 'edit'
    end
  end

  # DELETE /admin/showcases/1
  def destroy
    @showcase = Showcase.find(params[:id])
    @showcase.destroy
    redirect_to admin_showcases_path
  end
end
