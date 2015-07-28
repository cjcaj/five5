require "rails_helper"

RSpec.describe UsersController, :type => :controller do
  let(:user) { double(User).as_null_object }
  let(:users) { double([user]).as_null_object }

  describe "index" do
    before do
      allow(User).to receive(:page) { users }
    end

    it "assigns @users" do
      get 'index'
      expect(assigns(:users)).to eq(users)
    end
  end

  describe "new" do
    it "assigns @user" do
      get 'new'
      expect(assigns(:user)).to be
    end
  end

  describe "create" do
    it "renders new when fields are missing" do
      data = {user: {name: "NAME"}}
      post 'create', data
      expect(response).to render_template(:new)
    end

    it "redirects to user#show when successful" do
      username = "TEST"
      data = {user: {name: "NAME", username: username, password: "PASSW)RD"}}
      post 'create', data
      expect(response).to redirect_to(username_show_path(username))
    end
  end

  describe "show" do
    let(:username) { "USERNAME" }
    let(:data) { {username: username} }

    it "finds User by username" do
      expect(User).to receive(:find_by).with(username: username)
      get 'show', data
    end

    it "assigns @user" do
      allow(User).to receive(:find_by) { user }
      get 'show', data
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "update" do
    let(:preloaded) { double(Cloudinary::PreloadedFile).as_null_object }
    before do
      allow(User).to receive(:find_by) { user }
      allow(user).to receive(:picture) { "picture" }
    end

    context "image_id is present" do
      let (:data) { {id: 1, image_id: "PICTURE"} }
      before do
        allow(Cloudinary::PreloadedFile).to receive(:new) { preloaded }
      end

      it "only updates user's picture when image_id is present" do
        expect(user).to receive(:update_attributes).with(picture: preloaded)
        put 'update', data
      end

      it "only calls update once" do
        expect(user).to receive(:update_attributes).once
        put 'update', data
      end
    end

    context "image_id not present" do
      let (:data) { {id: 1} }
      it "should not update user" do
        expect(user).to_not receive(:update_attributes)
        put 'update', data
      end
    end
  end

end

