location = Location.find_or_create_by!(name: 'Canada')

location.proposal_types.find_or_create_by!(name: '2D workshop')
location.proposal_types.find_or_create_by!(name: '3D workshop')
location.proposal_types.find_or_create_by!(name: '5D workshop')
location.proposal_types.find_or_create_by!(name: 'Research in teams')
location.proposal_types.find_or_create_by!(name: 'Focussed Research Group')

location = Location.find_or_create_by!(name: 'New york')

location.proposal_types.find_or_create_by!(name: '2D workshop')
location.proposal_types.find_or_create_by!(name: '3D workshop')
location.proposal_types.find_or_create_by!(name: '5D workshop')
