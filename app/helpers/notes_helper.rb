module NotesHelper
  def submit_text_for(note)
    note.blank? ? "Create Note" : "Update Note"
  end
end
