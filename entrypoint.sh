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

  echo
  echo "Installing latest bundler..."
  /usr/local/rvm/bin/rvm-exec 2.7.2 gem install bundler

  echo
  echo "Installing Rails..."
  /usr/local/rvm/bin/rvm-exec 2.7.2 gem install rails
fi


echo
echo "Node version:"
node --version

echo
echo "Yarn version:"
yarn --version


if [ ! -e /home/app/proposals/bin ]; then
  echo
  echo "Starting new rails app..."
  su - app -c "cd /home/app; rails new proposals"

  echo
  echo "Bundle install..."
  su - app -c "cd /home/app/proposals; bundle install"

  echo
  echo "Prepare database..."
  su - app -c "cd /home/app/proposals; RAILS_ENV=development bundle exec rake db:prepare"
  su - app -c "cd /home/app/proposals; RAILS_ENV=test bundle exec rake db:prepare"
fi


# when updating Rails
# echo
# echo "Bundle update rails..."
# su - app -c "cd /home/app/proposals; bundle update rails"


echo
echo "Bundle update..."
su - app -c "cd /home/app/proposals; RAILS_ENV=development bundle update"

echo
echo "Running migrations..."
su - app -c "cd /home/app/proposals; rake db:migrate RAILS_ENV=development"
su - app -c "cd /home/app/proposals; rake db:migrate RAILS_ENV=test"

echo
echo "Checking for WebPacker..."
if [ ! -e /home/app/proposals/bin/webpack ]; then
  echo "Installing webpacker..."
  su - app -c "cd /home/app/proposals; RAILS_ENV=development bundle exec rails webpacker:install"
  su - app -c "cd /home/app/proposals; RAILS_ENV=development bundle exec yarn add --dev webpack-dev-server"
  echo
  echo "Installing Stimulus..."
  su - app -c "cd /home/app/proposals; RAILS_ENV=development bundle exec yarn add stimulus"
  echo "Done!"
  echo
fi

if [ $(ls -l /usr/local/rvm/gems | tail -1 | awk '{ print $3 }') != 'app']
then
  echo
  echo "Changing to non-root file permissions..."
  chown app:app -R /usr/local/rvm/gems
fi

if [ ! -e /home/app/proposals/tmp ]; then
 mkdir /home/app/proposals/tmp
fi
if [ ! -e /home/app/proposals/vendor/cache ]; then
  mkdir -p /home/app/proposals/vendor/cache
fi
chown app:app -R /home/app/proposals

echo
echo "Compiling Assets..."
su - app -c "cd /home/app/proposals; yarn install" # --latest"
su - app -c "cd /home/app/proposals; yarn upgrade"
su - app -c "cd /home/app/proposals; RAILS_ENV=development SECRET_KEY_BASE=token bundle exec rake assets:precompile --trace"
su - app -c "cd /home/app/proposals; yarn"

echo
echo "Launching webpack-dev-server..."
su - app -c "ruby /home/app/proposals/bin/webpack-dev-server &"
echo
echo "Starting web server..."
bundle exec passenger start
