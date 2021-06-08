module SubjectsHelper
  def subjects_area
    Subject.all.map { |sub| [sub.title, sub.id] }
  end

  def ams_subjects_code
    AmsSubject.all.map { |sub| [sub.title, sub.id] }
  end
end
