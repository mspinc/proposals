module SurveyHelper
  def citizenship_options
    citizenships = [%w[Argentina Argentina], [' Australia', ' Australia'], %w[Austria Austria],
                    %w[Belarus Belarus], %w[Belgium Belgium], %w[Benin Benin], %w[Brazil Brazil],
                    %w[Canada Canada], %w[Chile Chile], %w[China China], %w[Colombia Colombia],
                    ['Costa Rica', 'Costa Rica'], %w[Croatia Croatia], %w[Cyprus Cyprus],
                    ['Czech Republic', 'Czech Republic'], %w[Denmark Denmark], %w[Egypt Egypt],
                    %w[Finland Finland], ['France', ' France'], %w[Germany Germany], %w[Greece Greece],
                    %w[Guanajuato Guanajuato], ['Hong Kong', 'Hong Kong'], %w[Hungary Hungary],
                    %w[Iceland Iceland], %w[India India], %w[Indonesia Indonesia], %w[Iran Iran],
                    %w[Iraq Iraq], %w[Israel Israel], %w[Italy Italy], %w[Japan Japan],
                    %w[London London], %w[Luxembourg Luxembourg], %w[Macau Macau],
                    %w[Malaysia Malaysia], %w[Mexico Mexico], %w[Morocco Morocco],
                    %w[Netherlands Netherlands], ['New Zealand', 'New Zealand'], %w[Norway Norway],
                    %w[Perú Perú], %w[Philippines Philippines], %w[Poland Poland],
                    %w[Portugal Portugal], %w[Romania Romania], %w[Russia Russia],
                    ['Saudi Arabia', 'Saudi Arabia'], ['Sierra Leone', 'Sierra Leo'], %w[Singapore Singapore],
                    %w[Slovakia Slovakia], %w[Slovenia Slovenia], ['South Korea', 'South Korea'],
                    %w[Spain Spain], %w[Sweden Sweden], %w[Switzerland Switzerland], %w[Taiwan Taiwan],
                    ['The Bahamas', 'The Bahamas'], %w[Turkey Turkey], %w[UAE UAE], %w[Ukraine Ukraine],
                    ['United Kingdom', 'United Kingdom'], %w[Uruguay Uruguay], %w[USA USA],
                    %w[Venezuela Venezuela], %w[Vienna Vienna], %w[Vietnam Vietnam],
                    %w[Other Other], ['Prefer not to answer', '']]
    citizenships.map { |disp, _value| disp }
  end

  def ethnicity_options
    ethnicity = [['African/Black (including African-American, African-Canadian, AfroCaribbean, etc.)', 'African/Black'],
                 %w[Arab Arab], ['East Asian', 'East Asian'], ['European/non-white', 'European/non-white'],
                 ['European/white', 'European/white'], ['Filipina/Filipino', 'Filipina/Filipino'],
                 ['Indigenous from within North America', 'Indigenous from within North America'],
                 ['Indigenous from outside North America', 'Indigenous from outside North America'],
                 ['Latin, South, or Central American', 'Latin, South, or Central American'],
                 ['South Asian (including Indian sub-continent, Indo-Caribbean, Indo-African, Indo-Fijian, West-Indian)',
                  'South Asian'], ['Southeast Asian (including Brunei, Burma (Myanmar), Cambodia, Timor-Leste, Indonesia,
                  Laos, Malaysia, the Philippines, Singapore, Thailand and Vietnam)', 'Southeast Asian (including Brunei,
                  Burma (Myanm<ar), Cambodia, Timor-Leste, Indonesia, Laos, Malaysia, the Philippines, Singapore, Thailand
                  and Vietnam)'], ['West Asian (including Afghanistan, Armenia, Azerbaijan, Bahrain, Cyprus, Gaza Strip,
                  Georgia, Iran (Islamic Republic of), Iraq, Israel, Jordan, Kuwait, Lebanon, Oman, Qatar, Saudi Arabia,
                  Syrian Arab Republic, Turkey, United Arab Emirates, West Bank and Yemen)', 'West Asian (including
                  Afghanistan, Armenia, Azerbaijan, Bahrain, Cyprus, Gaza Strip, Georgia, Iran (Islamic Republic of),
                  Iraq, Israel, Jordan, Kuwait, Lebanon, Oman, Qatar, Saudi Arabia, Syrian Arab Republic, Turkey, United
                  Arab Emirates, West Bank and Yemen)'],['Prefer Other', 'Prefer Other'], ['Prefer not to answer', '']]
    ethnicity.map { |disp, _value| disp }
  end

  def gender_options
    gender = [%w[Female Female], %w[Male Male], ['Gender Fluid and/or non-Binary Person',
                                                 'Gender Fluid and/or non-Binary Person'], %w[Other Other], ['Prefer not to answer', '']]
    gender.map { |disp, _value| disp }
  end

  def indigenous_person_options
    indigenous = [['Yes', 'Yes'], %w[No No], ['Prefer not to answer', '']]
    indigenous.map { |disp, _value| disp }
  end

  def indigenouse_person_yes_options
    indigenous_yes = [['First Nation', 'First Nation'], %w[Métis Métis], %w[Inuit Inuit],
                      ['Native American', 'Native American'], ['Indigenous from outside of what is now known as Canada and the United States',
                                                               'Indigenous from outside of what is now known as Canada and the United States'], ['Prefer not to answer', '']]
    indigenous_yes.map { |disp, _value| disp }
  end
end
