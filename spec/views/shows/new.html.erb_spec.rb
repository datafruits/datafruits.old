require 'spec_helper'

describe "shows/new" do
  before(:each) do
    assign(:show, stub_model(Show,
      :title => "MyString",
      :user_id => ""
    ).as_new_record)
  end

  it "renders new show form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", shows_path, "post" do
      assert_select "input#show_title[name=?]", "show[title]"
      assert_select "input#show_user_id[name=?]", "show[user_id]"
    end
  end
end
