require 'spec_helper'

describe Admin::ShowcasesController do

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to be_success
    end
    it "assigns all showcases to @showcases" do
      showcase = create(:showcase)
      get :index
      expect(assigns(:showcases)).to eq([showcase])
    end
  end

end
