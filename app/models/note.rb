class Note < ApplicationRecord
    belongs_to :check, foreign_key: 'form_id', primary_key: 'id'

    def destroying_notes
        Rails.logger.info("Hello I am in the notes model about to destroy")

        # Initialize S3 client and delete object, does not delete files from s3 when deleting check, deletes from database
        s3 = Aws::S3::Resource.new(
        region: ENV['AWS_REGION'],
        credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
        )
        bucket = s3.bucket('kappaupsilonchi1-sofcnotes')
        key = self.avatar_url.split('amazonaws.com/')[1]
        Rails.logger.info("INSIDE NOTES MODEL Deleting S3 object with key: #{key}")
        bucket.object(key).delete

        destroy
    end
end
