module NotesHelper
  def submit_text_for(note)
    note.blank? or note.id.blank? ? "Create Note" : "Update Note"
  end
end
