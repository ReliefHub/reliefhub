class Photo < ActiveRecord::Base
  include Mixins::PaperclipStorageDecider
  has_attached_file :file, @paperclip_storage.merge({ :styles => { :thumb  => '100x80#',
                                                                   :small  => '114x114#',
                                                                   :medium  => '212x209#',
                                                                   :full   => '288x255#'} })
end
