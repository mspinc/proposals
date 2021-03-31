category = Category.find_or_create_by!(name: 'Science')

category.birs_subjects.find_or_create_by!(title: 'Applied Computer Science', code: 'ACS')
category.birs_subjects.find_or_create_by!(title: 'Theoretical Computer Science', code: 'TCS')
category.birs_subjects.find_or_create_by!(title: 'Discrete Mathematics', code: 'DM')


BirsSubject.first.ams_subjects.find_or_create_by!(title: '00 General', code: '00')
BirsSubject.first.ams_subjects.find_or_create_by!(title: '01 History and biography', code: '01')
BirsSubject.first.ams_subjects.find_or_create_by!(title: '03 Mathematical logic and foundations', code: '03')

BirsSubject.second.ams_subjects.find_or_create_by!(title: '05 Combinatorics', code: '05')
BirsSubject.second.ams_subjects.find_or_create_by!(title: '06 Order, lattices, ordered algebraic structures', code: '06')
BirsSubject.second.ams_subjects.find_or_create_by!(title: '08 General algebraic systems', code: '08')
