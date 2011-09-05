require 'spec_helper'

describe Event do
  it {should have_many(:attendances)}
  it {should belong_to(:location)}
  it {should belong_to(:organizer)}
  
  context "with some events" do
    before(:each) do
      @past = Factory(:event, :start_time => 1.day.ago)
      @future = Factory(:event, :start_time => 1.day.from_now)
    end

    describe "upcoming scope" do
      before(:each) do
        @other_future = Factory(:event, :start_time => 2.days.from_now)
        @result = Event.upcoming
      end

      it "sorts the events in ascending order by start_time" do
        @result.should ==  [@future, @other_future]
      end

      it "includes the future event" do
        @result.should include(@future)
      end

      it "doesn't include the past event" do
        @result.should_not include(@past)
      end

      it "checks at midnight"
    end # upcoming scope
    
    describe "previous scope" do
      before(:each) do
        @other_past = Factory(:event, :start_time => 2.days.ago)
        @result = Event.previous
      end
      
      it "includes past event" do
        @result.should include(@past)
      end
      
      it "doesn't include future event" do
        @result.should_not include(@future)
      end
      
      it "orders by start_time descending" do
        @result.should == [@past, @other_past]
      end
      
      it "checks at midnight"
    end
  end
end
