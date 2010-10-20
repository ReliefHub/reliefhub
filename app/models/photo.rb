class Photo < ActiveRecord::Base
  include Mixins::PaperclipStorageDecider
  has_attached_file :file, @paperclip_storage.merge({ :styles => { :tiny   => '35x35#',
                                                                   :thumb  => '75x60#',
                                                                   :small  => '114x114#',
                                                                   :medium => '165x130#',
                                                                   :full   => '250x230#'} })
end
