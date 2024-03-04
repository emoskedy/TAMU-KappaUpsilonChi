require 'rails_helper'

RSpec.describe "notes/index", type: :view do
  before(:each) do
    assign(:notes, [
      Note.create!(
        picture: "Picture",
        form_id: "Form"
      ),
      Note.create!(
        picture: "Picture",
        form_id: "Form"
      )
    ])
  end

  it "renders a list of notes" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Picture".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Form".to_s), count: 2
  end
end
