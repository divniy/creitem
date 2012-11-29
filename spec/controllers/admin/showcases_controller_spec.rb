require 'spec_helper'

describe Admin::ShowcasesController do
  describe "GET index" do
    it "assigns all showcases to @showcases" do
      showcase = create(:showcase)
      get :index
      expect(assigns(:showcases)).to eq([showcase])
    end
  end

  describe "GET show" do
    it "assigns the requested showcase as @showcase" do
      showcase = create(:showcase)
      get :show, { id: showcase.to_param }
      expect(assigns(:showcase)).to eq(showcase)
    end
  end

  describe "GET new" do
    it "assigns a new showcase as @showcase" do
      get :new
      expect(assigns(:showcase)).to be_a_new(Showcase)
    end
  end

  describe "GET edit" do
    it "assigns the requested showcase as @showcase" do
      showcase = create(:showcase)
      get :edit, { id: showcase.to_param }
      expect(assigns(:showcase)).to eq(showcase)
    end
  end

  describe "POST create" do
    context "valid attributes" do
      let(:post_valid_attributes) do
        post :create, { :showcase => attributes_for(:showcase) }
      end

      it "assigns a newly created Showcase as @showcase" do
        post_valid_attributes
        expect(assigns(:showcase)).to be_a(Showcase)
      end
      it "creates a new Showcase" do
        expect{post_valid_attributes}.to change{Showcase.count}.by(1)
        expect(assigns(:showcase)).to be_persisted
      end
      it "redirects to the created showcase" do
        post_valid_attributes
        expect(response).to redirect_to action: 'show', id: assigns(:showcase).to_param
      end
    end
    context "invalid attributes" do
      let(:post_invalid_attributes) do
        post :create, { :showcase => attributes_for(:showcase, :title => nil) }
      end

      before { post_invalid_attributes }
      it "assigns a newly showcase as @showcase" do
        expect(assigns(:showcase)).to be_a_new(Showcase)
      end
      it "re-renders the #new action" do
        expect(response).to render_template('new')
      end
    end
  end

  describe "PUT update" do
    before do
      @showcase = create(:showcase)
      put :update, { id: @showcase.to_param, showcase: updated_attributes }
    end

    context "with valid attributes" do
      let(:updated_attributes) { attributes_for(:showcase, title: "Updated title") }

      it "assigns the requested showcase to @showcase" do
        expect(assigns(:showcase)).to eq(@showcase)
      end
      it "updates the requested showcase" do
        expect{@showcase.reload}.to change{@showcase.title}.to(updated_attributes[:title])
      end
      it "redirect to @showcase path" do
        expect(response).to redirect_to(admin_showcase_path(@showcase))
      end
    end

    context "with invalid attributes" do
      let(:updated_attributes) { attributes_for(:showcase, title: nil) }

      it "assigns the showcase as @showcase" do
        expect(assigns(:showcase)).to eq(@showcase)
      end
      it "renders the 'edit' template" do
        expect(response).to render_template('edit')
      end
    end
  end

  describe "DELETE destroy" do
    before do
      @showcase = create(:showcase)
      delete :destroy, { id: @showcase }
    end

    it "destroys the request showcase" do
      expect{Showcase.find(@showcase.id)}.to raise_exception(ActiveRecord::RecordNotFound)
    end
    it "redirect to admin showcases" do
      expect(response).to redirect_to(admin_showcases_path)
    end
  end
end
