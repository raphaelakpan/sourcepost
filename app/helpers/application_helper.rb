module ApplicationHelper
  def set_title(page_title)
    content_for(:title) { page_title }
  end

  def format_pagination_info(info)
    word = info.split
    word.delete_at 1
    word.join(' ')
  end
end
