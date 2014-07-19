require 'rails_helper'

describe User do
  it 'should have valid factories' do
    expect(FactoryGirl.create(:user)).to be_valid
    expect(FactoryGirl.create(:confirmed_user)).to be_valid
  end

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it 'should require time_zone to be nil or one of ActiveRecords standard types' do
    user1 = FactoryGirl.build(:user, time_zone: nil)
    user2 = FactoryGirl.build(:user, time_zone: "Pacific Time (US & Canada)")
    user3 = FactoryGirl.build(:user, time_zone: "Not a valid time_zone")

    expect(user1).to be_valid
    expect(user2).to be_valid
    expect(user3).to_not be_valid
  end
end
