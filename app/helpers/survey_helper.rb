module SurveyHelper
  def citizenship_options()
    citizenships = [['Argentina', 'Argentina'], [' Australia', ' Australia'], ['Austria', 'Austria'],
      ['Belarus', 'Belarus'], ['Belgium', 'Belgium'], ['Benin', 'Benin'], ['Brazil', 'Brazil'],
      ['Canada', 'Canada'], ['Chile', 'Chile'], ['China', 'China'], ['Colombia', 'Colombia'],
      ['Costa Rica', 'Costa Rica'], ['Croatia', 'Croatia'], ['Cyprus', 'Cyprus'],
      ['Czech Republic', 'Czech Republic'], ['Denmark', 'Denmark'], ['Egypt', 'Egypt'],
      ['Finland', 'Finland'], ['France', ' France'], ['Germany', 'Germany'], ['Greece', 'Greece'],
      ['Guanajuato', 'Guanajuato'], ['Hong Kong', 'Hong Kong'], ['Hungary', 'Hungary'],
      ['Iceland', 'Iceland'], ['India', 'India'], ['Indonesia', 'Indonesia'], ['Iran', 'Iran'],
      ['Iraq', 'Iraq'], ['Israel', 'Israel'], ['Italy', 'Italy'], ['Japan', 'Japan'],
      ['London', 'London'], ['Luxembourg', 'Luxembourg'], ['Macau', 'Macau'],
      ['Malaysia', 'Malaysia'], ['Mexico', 'Mexico'], ['Morocco', 'Morocco'],
      ['Netherlands', 'Netherlands'], ['New Zealand', 'New Zealand'], ['Norway', 'Norway'],
      ['Perú', 'Perú'], ['Philippines', 'Philippines'], ['Poland', 'Poland'],
      ['Portugal', 'Portugal'], ['Romania', 'Romania'], ['Russia', 'Russia'],
      ['Saudi Arabia', 'Saudi Arabia'], ['Sierra Leone', 'Sierra Leo'], ['Singapore', 'Singapore'],
      ['Slovakia', 'Slovakia'], ['Slovenia', 'Slovenia'], ['South Korea', 'South Korea'],
      ['Spain', 'Spain'], ['Sweden', 'Sweden'], ['Switzerland', 'Switzerland'], ['Taiwan', 'Taiwan'],
      ['The Bahamas', 'The Bahamas'],['Turkey', 'Turkey'], ['UAE', 'UAE'], ['Ukraine', 'Ukraine'],
      ['United Kingdom', 'United Kingdom'], ['Uruguay', 'Uruguay'], ['USA', 'USA'],
      ['Venezuela', 'Venezuela'],['Vienna', 'Vienna'], ['Vietnam', 'Vietnam'],
      ['Other', 'Other'], ['Prefer not to answer', '']]
      citizenships.map{ |disp, value| disp}
  end
end
