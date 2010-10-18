# Usage in your model:
#
# include PaperclipStorageDecider
#
# has_attached_file :profile_photo, @paperclip_storage.merge({ :styles => { :tiny   => '30x30#' } })
#
module PaperclipStorageDecider
  def self.included(model)
    model.class_eval do
      if %w(development test cucumber performance).include?(Rails.env)
        @paperclip_storage = {}
      else
        @paperclip_storage = {
          :storage        => :s3,
          :s3_credentials => "#{Rails.root}/config/s3.yml",
          :path           => ":class/:attachment/:id/:style.:extension"
        }
      end
    end
  end
end
