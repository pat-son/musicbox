module ApplicationHelper

  # Include vertical bar in title only if there is a specific page title
  def full_title(page_title = '')
    base_title = "MusicBox"
    if page_title.empty?
      base_title
    else
      page_title + ' | ' + base_title
    end
  end

  def can_edit?(obj)
    u = current_user

    return false if u.nil?
    return true if u.admin == true

    case obj
    when Creation
      return obj.user_id == u.id
    when Comment
      return obj.user_id == u.id
    when User
      return obj.id == u.id
    else
      return false
    end
  end
end
