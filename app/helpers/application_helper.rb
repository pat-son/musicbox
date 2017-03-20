module ApplicationHelper

  # Include vertical bar in title only if there is a specific page title
  def full_title(page_title = '')
    base_title = "Music Box"
    if page_title.empty?
      base_title
    else
      page_title + ' | ' + base_title
    end
  end
end
