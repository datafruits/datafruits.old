require 'spec_helper'

describe Show do
  let(:user){ create :user }

  it "does not allow overlapping shows in the schedule" do
    show1 = Show.create! title: 'my cool show', user_id: user.id, time: Chronic.parse('tomorrow at 5:00pm'), end_time: Chronic.parse('tomorrow at 7:00pm')

    expect do
      show2 = Show.create! title: 'my cool show', user_id: user.id, time: Chronic.parse('tomorrow at 6:00pm'), end_time: Chronic.parse('tomorrow at 7:00pm')
    end.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "allows shows that do not overlap" do
    show1 = Show.create! title: 'my cool show', user_id: user.id, time: Chronic.parse('tomorrow at 5:00pm'), end_time: Chronic.parse('tomorrow at 7:00pm')
    show2 = Show.create! title: 'my cool show', user_id: user.id, time: Chronic.parse('tomorrow at 7:00pm'), end_time: Chronic.parse('tomorrow at 9:00pm')

    expect(show1.valid?).to eq true
    expect(show2.valid?).to eq true
  end
end
