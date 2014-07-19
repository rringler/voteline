require 'rails_helper'

describe Poll do
  it 'should have valid factories' do
    expect(FactoryGirl.create(:poll)).to be_valid
  end

  describe 'validations' do
    it { should belong_to(:user) }
    it { should validate_presence_of(:start) }
    it { should validate_presence_of(:finish) }
    it { should validate_presence_of(:vote_min) }
    it { should validate_presence_of(:vote_max) }
    it 'should require a valid vote range to be set' do
      poll = FactoryGirl.build(:poll, vote_min: 5, vote_max: 0)
      expect(poll).to_not be_valid
    end
  end

  describe 'instance methods' do
    let(:poll) { FactoryGirl.create(:poll) }

    describe '#vote_range' do
      it 'should return a range from vote_min to vote_max' do
        expect(poll.vote_range).to eq(poll.vote_min..poll.vote_max)
      end
    end

    describe '#vote_range_given?' do
      it 'should return true if vote_min and vote_max are defined' do
        expect(poll.vote_range_given?).to be_truthy
      end

      it 'should return false if vote_min or vote_max are not defined' do
        poll1 = FactoryGirl.build(:poll, vote_min: nil)
        poll2 = FactoryGirl.build(:poll, vote_max: nil)

        expect(poll1.vote_range_given?).to be_falsy
        expect(poll2.vote_range_given?).to be_falsy
      end
    end

    describe '#valid_vote_range' do
      it 'should add an error if the vote_min is not less than the vote_max' do
        poll = FactoryGirl.build(:poll, vote_min: 5, vote_max: 0)

        expect { poll.valid_vote_range }.to change{poll.errors.count}.by(1)
      end
    end

    describe '#active?' do
      it 'should return true if the current time is between the poll start and finish' do
        expect(poll.active?).to be_truthy
      end

      it 'should return false if the current time is not between the poll start and finish' do
        poll.start  = DateTime.now + 1.day
        poll.finish = DateTime.now + 1.day + 2.hours

        expect(poll.active?).to be_falsy
      end
    end
  end
end
