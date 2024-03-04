require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/notes", type: :request do
  
  # This should return the minimal set of attributes required to create a valid
  # Note. As you add validations to Note, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      Note.create! valid_attributes
      get notes_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      note = Note.create! valid_attributes
      get note_url(note)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_note_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      note = Note.create! valid_attributes
      get edit_note_url(note)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Note" do
        expect {
          post notes_url, params: { note: valid_attributes }
        }.to change(Note, :count).by(1)
      end

      it "redirects to the created note" do
        post notes_url, params: { note: valid_attributes }
        expect(response).to redirect_to(note_url(Note.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Note" do
        expect {
          post notes_url, params: { note: invalid_attributes }
        }.to change(Note, :count).by(0)
      end

    
      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post notes_url, params: { note: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested note" do
        note = Note.create! valid_attributes
        patch note_url(note), params: { note: new_attributes }
        note.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the note" do
        note = Note.create! valid_attributes
        patch note_url(note), params: { note: new_attributes }
        note.reload
        expect(response).to redirect_to(note_url(note))
      end
    end

    context "with invalid parameters" do
    
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        note = Note.create! valid_attributes
        patch note_url(note), params: { note: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested note" do
      note = Note.create! valid_attributes
      expect {
        delete note_url(note)
      }.to change(Note, :count).by(-1)
    end

    it "redirects to the notes list" do
      note = Note.create! valid_attributes
      delete note_url(note)
      expect(response).to redirect_to(notes_url)
    end
  end
end
