class EditFlowService
  attr_reader :proposal

  def initialize(proposal)
    @proposal = proposal
  end

  def query
    @country_code = Country.find_country_by_name(proposal.lead_organizer.country)
    @co_organizers = proposal.invites.where(invited_as: 'Co Organizer')
    @country_code_organizers = Country.find_country_by_name(@co_organizers.first.person.country)
    query = call_query
  end

  private

  def call_query
    <<END_STRING
            mutation {
              article: submitArticle(data: {
                sectionAbbrev: "#{proposal.subject.code}"

                title: "#{proposal.title}"
                abstract: "#{proposal.title}"

                correspAuthorEmail: "#{proposal.lead_organizer.email}"

                # just want to make clear we can do more than two authors -AJ
                authors: [{
                  email: "#{proposal.lead_organizer.email}"
                  givenName: "#{proposal.lead_organizer.firstname}"
                  familyName: "#{proposal.lead_organizer.lastname}"
                  nameInOriginalScript: "#{proposal.lead_organizer.fullname}" # clarify: use nameInOriginalScript only for non-latin names, eg, "日暮 ひぐらし かごめ" -AJ
                  institution: "#{proposal.lead_organizer.affiliation}"
                  countryCode: "#{@country_code.alpha2}"
                }, {
                  email: "#{@co_organizers.first.email}"
                  givenName: "#{@co_organizers.first.firstname}"
                  familyName: "#{@co_organizers.first.lastname}"
                  mrAuthorID: 12345
                  institution: "#{@co_organizers.first.person.affiliation}"
                  countryCode: "#{@country_code_organizers.alpha2}"
                }]

                primarySubjects: {
                  scheme: "MSC2020"
                  codes: ["00-01"]
                }

                secondarySubjects: {
                  scheme: "MSC2020"
                  codes: ["00B05", "00A07"]
                }

                files: [{
                  role: "main"
                  key: "fileMain"
                }]
              }) {
                identifier
              }
            }
END_STRING
  end
end
