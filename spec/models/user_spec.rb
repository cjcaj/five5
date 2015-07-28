require "rails_helper"

RSpec.describe User, :type => :model do
  subject { User.new }
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(6) }
  end

  describe "password" do
    it "does not store in plain text" do
      password = "ABC321"
      subject.password = password
      expect(subject.password_digest).to_not eq(password)
    end
  end
end

