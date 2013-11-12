module ApplicationHelper
  def page_title
    @title.present? ? "#{@title} - TexPaste" : "TexPaste: Math Pastebin with LaTeX"
  end
end
