module ApplicationHelper

  # ディスク内の曲順を並び替えた配列を作成
  def songs_order
  end

  def sidebar_link_item(name, path)
    class_name = 'channel'
    class_name << ' active' if current_page?(path)

    content_tag :li, class:class_name do
      link_to name, path, class: 'channel_name'
    end
  end

end
