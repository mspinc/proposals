# Proposals

"Proposals" will be a web application for accepting proposals for scientific meetings, such as workshops or conferences, and facilitating the peer-review and selection process at [BIRS](https://www.birs.ca).

See [the wiki](https://github.com/birs-math/proposals/wiki) for the developing specifications.


## Setup Instructions

1. Copy the `docker-compose.yml.example` file to `docker-compose.yml`.

2. Create the data containers, for persistent storage, as described at the top of the file.

3. Fill in the environment variables for usernames & passwords, and various seed keys, in the file.

4. ```docker-compose up``` to build & run the containers.

5. ```docker exec -it proposals bash``` to get a shell.


