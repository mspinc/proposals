namespace :birs do
  task :default => 'birs:birs_subjects'

  desc "Add BIRS Subjects to database"
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

    # TODO: find or create SubjectCategory and assign accordingly
    category = SubjectCategory.find_or_create_by!(name: 'none')
    subject_codes.each do |subject|
      puts "Adding BIRS Subject: #{subject[:code]}: #{subject[:title]}"
      Subject.create(code: subject[:code], title: subject[:title], subject_category: category)
    end
    puts "Done!"
  end

  desc "Add AMS Subjects to database"
  task ams_subjects: :environment do

    ams_subject_codes = [
      { code: "00", title: "00 General" },
      { code: "01", title: "01 History and biography" },
      { code: "03", title: "03 Mathematical logic and foundations" },
      { code: "05", title: "05 Combinatorics" },
      { code: "06", title: "06 Order, lattices, ordered algebraic structures" },
      { code: "08", title: "08 General algebraic systems" },
      { code: "11", title: "11 Number theory" },
      { code: "12", title: "12 Field theory and polynomials" },
      { code: "13", title: "13 Commutative rings and algebras" },
      { code: "14", title: "14 Algebraic geometry" },
      { code: "15", title: "15 Linear and multilinear algebra; matrix theory" },
      { code: "16", title: "16 Associative rings and algebras" },
      { code: "17", title: "17 Nonassociative rings and algebras" },
      { code: "18", title: "18 Category theory; homological algebra" },
      { code: "19", title: "19 $K$-theory" },
      { code: "20", title: "20 Group theory and generalizations" },
      { code: "22", title: "22 Topological groups, Lie groups" },
      { code: "26", title: "26 Real functions" },
      { code: "28", title: "28 Measure and integration" },
      { code: "30", title: "30 Functions of a complex variable" },
      { code: "31", title: "31 Potential theory" },
      { code: "32", title: "32 Several complex variables and analytic spaces" },
      { code: "33", title: "33 Special functions " },
      { code: "34", title: "34 Ordinary differential equations" },
      { code: "35", title: "35 Partial differential equations" },
      { code: "37", title: "37 Dynamical systems and ergodic theory" },
      { code: "39", title: "39 Difference and functional equations" },
      { code: "40", title: "40 Sequences, series, summability" },
      { code: "41", title: "41 Approximations and expansions" },
      { code: "42", title: "42 Fourier analysis" },
      { code: "43", title: "43 Abstract harmonic analysis" },
      { code: "44", title: "44 Integral transforms, operational calculus" },
      { code: "45", title: "45 Integral equations" },
      { code: "46", title: "46 Functional analysis" },
      { code: "47", title: "47 Operator theory" },
      { code: "49", title: "49 Calculus of variations and optimal control; optimization" },
      { code: "51", title: "51 Geometry" },
      { code: "52", title: "52 Convex and discrete geometry" },
      { code: "53", title: "53 Differential geometry" },
      { code: "54", title: "54 General topology" },
      { code: "55", title: "55 Algebraic topology" },
      { code: "57", title: "57 Manifolds and cell complexes" },
      { code: "58", title: "58 Global analysis, analysis on manifolds" },
      { code: "60", title: "60 Probability theory and stochastic processes" },
      { code: "62", title: "62 Statistics" },
      { code: "65", title: "65 Numerical analysis" },
      { code: "68", title: "68 Computer science" },
      { code: "70", title: "70 Mechanics of particles and systems" },
      { code: "74", title: "74 Mechanics of deformable solids" },
      { code: "76", title: "76 Fluid mechanics" },
      { code: "78", title: "78 Optics, electromagnetic theory" },
      { code: "80", title: "80 Classical thermodynamics, heat transfer" },
      { code: "81", title: "81 Quantum theory" },
      { code: "82", title: "82 Statistical mechanics, structure of matter" },
      { code: "83", title: "83 Relativity and gravitational theory" },
      { code: "85", title: "85 Astronomy and astrophysics" },
      { code: "86", title: "86 Geophysics" },
      { code: "90", title: "90 Operations research, mathematical programming" },
      { code: "91", title: "91 Game theory, economics, social and behavioral sciences" },
      { code: "92", title: "92 Biology and other natural sciences" },
      { code: "93", title: "93 Systems theory; control" },
      { code: "94", title: "94 Information and communication, circuits" },
      { code: "97", title: "97 Mathematics education" },
      { code: "99", title: "99 Other" },
    ]

    ams_subject_codes.each do |ams_subject|
      puts "Adding AMS Subject: #{ams_subject[:title]}"
      AmsSubject.create!(code: ams_subject[:code], title: ams_subject[:title])
    end
    puts "Done!"
  end
end
