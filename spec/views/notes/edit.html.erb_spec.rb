require 'rails_helper'

RSpec.describe "notes/edit", type: :view do
  let(:note) {
    Note.create!(
      picture: "MyString",
      form_id: "MyString"
    )
  }

  before(:each) do
    assign(:note, note)
  end

  it "renders the edit note form" do
    render

    assert_select "form[action=?][method=?]", note_path(note), "post" do

      assert_select "input[name=?]", "note[picture]"

      assert_select "input[name=?]", "note[form_id]"
    end
  end
end
