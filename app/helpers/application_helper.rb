module ApplicationHelper
  def link_to_language name, locale
    uri = URI.parse(request.fullpath)
    uri.path.gsub!(/(^\/en)|(^\/fr)|^/, "/#{locale}")
    link_to name, uri.to_s
  end
end
