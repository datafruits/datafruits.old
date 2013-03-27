require 'spec_helper'

describe "shows/edit" do
  before(:each) do
    @show = assign(:show, stub_model(Show,
      :title => "MyString",
      :user_id => ""
    ))
  end

  it "renders the edit show form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", show_path(@show), "post" do
      assert_select "input#show_title[name=?]", "show[title]"
      assert_select "input#show_user_id[name=?]", "show[user_id]"
    end
  end
end
