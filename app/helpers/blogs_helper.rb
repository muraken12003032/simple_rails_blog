module BlogsHelper
  def choose_new_or_edit
    if action_name == 'new'
      blogs_path
    elsif action_name == 'edit'
      blog_path
    elsif action_name == 'confirm'
      confirm_blogs_path
    end
  end
end
