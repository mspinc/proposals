class UpdateSubjectTable < ActiveRecord::Migration[6.1]
  def change
    Subject.find_by(code: "ARNT")&.update(code: "ARGEO", title: "Arithmetic Geometry")
    subject_category = SubjectCategory.first
    Subject.create(code: "ANNT", title: "Analytic Number Theory", subject_category_id: subject_category.id)
    Subject.create(code: "ALNT", title: "Algebraic Number Theory", subject_category_id: subject_category.id)
  end
end
