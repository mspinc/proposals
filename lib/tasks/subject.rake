namespace :subject do
  task birs_subjects: :environment do
    subject_codes = [
      { code: 'ACS', title: 'Applied Computer Science' },
      { code: 'TCS', title: 'Theoretical Computer Science' },
      { code: 'COMB', title: 'Combinatorics' },
      { code: 'DM', title: 'Discrete Mathematics' },
      { code: 'DATA', title: 'Data Science' },
      { code: 'OR', title: 'Operation Research' },
      { code: 'ML', title: 'Machine Learning' },
      { code: 'CO', title: 'Control/Optimization' },
      { code: 'ASTA', title: 'Applied Statistics' },
      { code: 'STAMET', title: 'Statistical Methodology' },
      { code: 'PSTO', title: 'Probability and Stochastic Modelling' },
      { code: 'MEFS', title: 'Mathematical Economics/Finance/Social and behavioral sciences' },
      { code: 'MP', title: 'Mathematical Physics' },
      { code: 'AMP', title: 'Applied Mathematical Physics' },
      { code: 'ST', title: 'String Theory' },
      { code: 'AGEO', title: 'Algebraic Geometry' },
      { code: 'ALG', title: 'Algebraic Structures' },
      { code: 'REP', title: 'Representation Theory' },
      { code: 'ATOP', title: 'Algebraic Topology' },
      { code: 'TOP', title: 'Topology' },
      { code: 'ARNT', title: 'Arithmetic Number Theory' },
      { code: 'DS', title: 'Dynamical Systems' },
      { code: 'DGEO', title: 'Differential and Complex Geometry' },
      { code: 'GGT', title: 'Geometric Group Theory' },
      { code: 'GA', title: 'Geometric Analysis' },
      { code: 'PDE', title: 'Partial Differential Equations' },
      { code: 'PPDE', title: 'Physical PDEs' },
      { code: 'GPDE', title: 'Geometric PDEs' },
      { code: 'FA', title: 'Functional/Complex Analysis' },
      { code: 'FD', title: 'Fluid Dynamics' },
      { code: 'IP', title: 'Inverse Problems' },
      { code: 'AM', title: 'Applied Mathematics' },
      { code: 'MPE', title: 'Mathematics of Planet Earth' },
      { code: 'MPE/CC', title: 'Climate Change' },
      { code: 'NA', title: 'Numerical Analysis' },
      { code: 'BIO', title: 'Mathematical Biology' },
      { code: 'ME', title: 'Math Ecology' },
      { code: 'SBIO', title: 'Systems Biology' },
      { code: 'CBIO', title: 'Computational Biology' },
      { code: 'MS', title: 'Material Science' },
      { code: 'EDU', title: 'Education / Outreach / Other' },
      { code: 'WEC', title: 'Women and Early Careers in Math' },
      { code: 'MEP', title: 'Mathematical Epidemiology' },
      { code: 'OA', title: 'Operator Algebras' },
      { code: 'MAA', title: 'Modern Applied Analysis' },
      { code: 'CC', title: 'Computational Chemistry' },
      { code: 'TSTA', title: 'Theoretical Statistics' },
      { code: 'DAM', title: 'Data Mining' },
      { code: 'STAM', title: 'Statistical Mechanics' },
      { code: 'AIM', title: 'Applied Analysis and Industrial Math' },
      { code: 'SS', title: 'Summer Schools' },
    ]

    #TODO find or create SubjectCategory and assign accordingly
    category = SubjectCategory.find_or_create_by!(name: 'Science')
    subject_codes.each do |subject|
      Subject.create(code: subject[:code], title: subject[:title], subject_category: category)
    end
  end
end
