require 'spec_helper'

describe ProductsController do

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ProductsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET #index" do
    it "assigns all products as @products" do
      product = create(:product)
      get :index, {}, valid_session
      assigns(:products).should eq([product])
    end

    it "assigns products in right order" do
      older_product = create(:product, created_at: 2.days.ago)
      newer_product = create(:another_product)
      get :index, {}, valid_session
      assigns(:products).should eq([newer_product, older_product])
    end
  end

  describe "GET #show" do
    it "assigns the requested product as @product" do
      product = create(:product)
      get :show, {:id => product.to_param}, valid_session
      assigns(:product).should eq(product)
    end
  end

  describe "GET #new" do
    it "assigns a new product as @product" do
      get :new, {}, valid_session
      assigns(:product).should be_a_new(Product)
    end
  end

  describe "GET #edit" do
    it "assigns the requested product as @product" do
      product = create(:product)
      get :edit, {:id => product.to_param}, valid_session
      assigns(:product).should eq(product)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Product" do
        expect {
          post :create, {:product => attributes_for(:product)}, valid_session
        }.to change(Product, :count).by(1)
      end

      it "assigns a newly created product as @product" do
        post :create, {:product => attributes_for(:product)}, valid_session
        assigns(:product).should be_a(Product)
        assigns(:product).should be_persisted
      end

      it "redirects to the created product" do
        post :create, {:product => attributes_for(:product)}, valid_session
        response.should redirect_to(Product.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved product as @product" do
        post :create, {:product => attributes_for(:invalid_product)}, valid_session
        assigns(:product).should be_a_new(Product)
      end

      it "re-renders the 'new' template" do
        post :create, {:product => attributes_for(:invalid_product)}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT #update" do
    before :each do
      @product = create(:product)
    end

    describe "with valid params" do
      before :each do
        @update_hash = {id: @product.to_param, product: attributes_for(:product, :updated_title)}
      end

      it "updates the requested product" do
        put :update, @update_hash, valid_session
        @product.reload
        @product.title.should eq(@update_hash[:product][:title])
      end

      it "assigns the requested product as @product" do
        put :update, @update_hash, valid_session
        assigns(:product).should eq(@product)
      end

      it "redirects to the product" do
        put :update, @update_hash, valid_session
        response.should redirect_to(@product)
      end
    end

    describe "with invalid params" do
      before :each do
        @invalid_hash = {:id => @product.to_param, :product => attributes_for(:invalid_product)}
      end

      it "does not change @product attributes" do
        put :update, @invalid_hash, valid_session
        @product.reload
        @product.title.should_not eq(@invalid_hash[:product][:title])
      end

      it "assigns the product as @product" do
        put :update, @invalid_hash, valid_session
        assigns(:product).should eq(@product)
      end

      it "re-renders the 'edit' template" do
        put :update, @invalid_hash, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    before :each do
      @product = create(:product)
    end

    it "destroys the requested product" do
      expect {
        delete :destroy, {:id => @product.to_param}, valid_session
      }.to change(Product, :count).by(-1)
    end

    it "redirects to the products list" do
      delete :destroy, {:id => @product.to_param}, valid_session
      response.should redirect_to(products_url)
    end
  end
end
