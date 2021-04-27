#!/bin/bash
set -e

echo
echo "Welcome to OS:"
uname -v
cat /etc/issue

echo
echo "Setting system timezone..."
export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true
echo "tzdata tzdata/Areas select America" > /tmp/tz.txt
echo "tzdata tzdata/Zones/America select Edmonton" >> /tmp/tz.txt
debconf-set-selections /tmp/tz.txt
rm /etc/timezone
rm /etc/localtime
dpkg-reconfigure --frontend noninteractive tzdata

if [ ! -e /usr/local/rvm/gems/ruby-2.7.2 ]; then
  echo
  echo "Create gemset..."
  gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
  /usr/bin/curl -sSL https://get.rvm.io | bash -s stable
  bash -lc 'rvm --default use ruby-2.7.2'
  /usr/local/rvm/bin/rvm gemset create ruby-2.7.2
  /usr/local/rvm/bin/rvm gemset use ruby-2.7.2@global
  /usr/local/rvm/bin/rvm cleanup all
  /usr/local/rvm/bin/rvm reload
fi

echo
echo "Ruby version:"
ruby -v

echo
echo "Node version:"
node --version

echo
echo "Yarn version:"
yarn --version

echo
echo "Changing /home/app/proposals file ownership to app user..."
chown app:app -R /home/app/proposals

echo
echo "Installing latest bundler..."
/usr/local/rvm/bin/rvm-exec 2.7.2 gem install bundler


if [ ! -e /usr/local/rvm/gems/rails-6.1.3.1.gem ]; then
  echo
  echo "Installing Rails..."
  su - app -c "cd /home/app/proposals; /usr/local/rvm/bin/rvm-exec 2.7.2 gem install rails -v 6.1.3"
fi

if [ ! -e /home/app/proposals/bin ]; then
  echo
  echo "Starting new rails app..."
  su - app -c "cd /home/app; rails new proposals"

  echo
  echo "Bundle install..."
  su - app -c "cd /home/app/proposals; bundle install"
fi

echo
echo "Bundle update..."
su - app -c "cd /home/app/proposals; bundle update"

root_owned_files=`find /usr/local/rvm/gems -user root -print`
if [ -z "$root_owned_files" ]; then
  echo
  echo "Changing gems to non-root file permissions..."
  chown app:app -R /usr/local/rvm/gems
fi

if [ -e /home/app/proposals/db/migrate ]; then
  echo
  echo "Running migrations..."
  su - app -c "cd /home/app/proposals; SECRET_KEY_BASE=$SECRET_KEY_BASE DB_USER=$DB_USER DB_PASS=$DB_PASS rake db:migrate RAILS_ENV=production"
  su - app -c "cd /home/app/proposals; SECRET_KEY_BASE=$SECRET_KEY_BASE DB_USER=$DB_USER DB_PASS=$DB_PASS rake db:migrate RAILS_ENV=development"
  su - app -c "cd /home/app/proposals; SECRET_KEY_BASE=$SECRET_KEY_BASE DB_USER=$DB_USER DB_PASS=$DB_PASS rake db:migrate RAILS_ENV=test"
else
  echo
  echo "Prepare database..."
  su - app -c "cd /home/app/proposals; RAILS_ENV=development DB_USER=$DB_USER DB_PASS=$DB_PASS rake db:prepare"
  su - app -c "cd /home/app/proposals; RAILS_ENV=test DB_USER=$DB_USER DB_PASS=$DB_PASS rake db:prepare"
fi


if [ ! -e /home/app/proposals/bin/webpack ]; then
  echo "Installing Webpacker..."
  su - app -c "cd /home/app/proposals; RAILS_ENV=development bundle exec rails webpacker:install"
  echo
  echo "Turbo install..."
  su - app -c "cd /home/app/proposals; RAILS_ENV=development bundle exec rails turbo:install"
  echo "Done!"
  echo
fi


echo
echo "Compiling Assets..."
chmod 755 /home/app/proposals/node_modules
# su - app -c "cd /home/app/proposals; yarn add webpack-cli@3.3.11 --dev"
su - app -c "cd /home/app/proposals; yarn install"
# su - app -c "cd /home/app/proposals; yarn upgrade"
su - app -c "cd /home/app/proposals; RAILS_ENV=development SECRET_KEY_BASE=token bundle exec rake assets:precompile --trace"
su - app -c "cd /home/app/proposals; yarn"

echo
echo "Launching webpack-dev-server..."
su - app -c "cd /home/app/proposals; RAILS_ENV=development bundle exec bin/webpack-dev-server &"

echo
echo "Starting web server..."
bundle exec passenger start
