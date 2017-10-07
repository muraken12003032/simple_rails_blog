module ThumbnailsHelper
  def thumbnail_new_or_edit
    if action_name == 'new'
      thumbnails_path
    elsif action_name == 'edit'
      thumbnail_path
    end
  end
end