class NotesController < ApplicationController
  before_action :set_note, only: %i[ show destroy ]
  before_action :set_s3_direct_post, only: [:new, :create]

  # GET /notes or /notes.json
  def index
    @notes = Note.all
  end

  # GET /notes/1 or /notes/1.json
  def show
    @note = Note.find(params[:id])
  end

  # GET /notes/new
  def new
    @note = Note.new
  end

  # POST /notes or /notes.json
  def create
    @note = Note.new(note_params)
    # @note.form_id = params[:note][:form_id]
    
    respond_to do |format|
      if @note.save
        format.html { redirect_to note_url(@note), notice: "Note was successfully created." }
        format.json { render :show, status: :created, location: @note }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1 or /notes/1.json
  def destroy
    @note.destroy

    respond_to do |format|
      format.html { redirect_to notes_url, notice: "Note was successfully destroyed." }
      format.json { head :no_content }
    end

    # # delete picture from bucket
    # bucket = S3.bucket(S3_BUCKET.name)
    # obj = bucket.object(params[:avatar_url])
    # obj.delete
    # Initialize S3 client and delete object
    s3 = Aws::S3::Resource.new(
      region: ENV['AWS_REGION'],
      credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
    )
    bucket = s3.bucket('kappaupsilonchi1-sofcnotes')
    key = @note.avatar_url.split('amazonaws.com/')[1]
    bucket.object(key).delete
    # obj = bucket.object(@note.avatar_url)
    # obj.delete
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def note_params
      params.require(:note).permit(:picture, :form_id, :name, :avatar_url)
    end
    
    def set_s3_direct_post
      @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
    end
end
