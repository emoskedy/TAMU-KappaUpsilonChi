class NotesController < ApplicationController
  before_action :set_note, only: %i[show destroy]
  before_action :set_s3_direct_post, only: %i[new create]

  # GET /notes or /notes.json
  def index
    if params[:check_id]
      @check = Check.find(params[:check_id])
      @notes = @check.notes
    else
      @notes = Note.all
    end
  end

  # GET /notes/1 or /notes/1.json
  def show
    @check = Check.find(params[:check_id])
    @note = Note.find(params[:id])
  end

  # GET /notes/new
  def new
    @check = Check.find(params[:check_id])
    @note = @check.notes.build
  end

  # POST /notes or /notes.json
  def create
    # @note = Note.new(note_params)
    # @note.form_id = params[:note][:form_id]
    @check = Check.find(params[:check_id])
    @note = @check.notes.build(note_params)

    respond_to do |format|
      if @note.save
        format.html { redirect_to check_note_path(@check, @note), notice: 'Note was successfully created.' }
        format.json { render :show, status: :created, location: @note }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1 or /notes/1.json
  def destroy
    Rails.logger.info('Hi, I am at the beginning')
    # Initialize S3 client and delete object, does not delete files from s3 when deleting check, deletes from database
    s3 = Aws::S3::Resource.new(
      region: ENV['AWS_REGION'],
      credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
    )
    bucket = s3.bucket('kappaupsilonchi1-sofcnotes')
    key = @note.avatar_url.split('amazonaws.com/')[1]
    Rails.logger.info("Deleting S3 object with key: #{key}")
    bucket.object(key).delete

    @note.destroy
    Rails.logger.info('Logging after note.destroy')

    respond_to do |format|
      format.html { redirect_to check_notes_path(@check), notice: 'Note was successfully destroyed.' }
      format.json { head :no_content }
    end

    Rails.logger.info('Logging here at the end')
    # obj = bucket.object(@note.avatar_url)
    # obj.delete
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_note
    @note = Note.find(params[:id])
    @check = Check.find(params[:check_id])
  end

  # Only allow a list of trusted parameters through.
  def note_params
    params.require(:note).permit(:picture, :form_id, :name, :avatar_url)
  end

  def set_s3_direct_post
    @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
  end
end
