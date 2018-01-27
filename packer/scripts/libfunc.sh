
WORKDIR=/home/appuser 

function install_ruby {
  apt update && \
  apt install -y ruby-full ruby-bundler build-essential
}

function show_ruby {
  ruby -v && bundler -v
}

function install_mongo {
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927 && \
  echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list && \
  apt update && apt install -y mongodb-org && \
  systemctl enable mongod  
}

function start_mongo {
  systemctl start mongod
}

function show_mongo {
  systemctl status mongod
}

function install_app {
  
  local _app_home=$WORKDIR/reddit
  
  cd $WORKDIR && git clone 'https://github.com/Otus-DevOps-2017-11/reddit.git' &&\
  cd $_app_home && bundle install
}

function start_app {
  
  local _app_home=$WORKDIR/reddit
  
  cd $_app_home && puma -d && {
    sleep 3
    ps -aux | grep puma || echo "puma seems dead ((("
  }
}


function ruby_tasks {
  
  install_ruby && show_ruby
}

function mongo_tasks {
  
  install_mongo && start_mongo && show_mongo
}

function app_tasks {
  
  install_app && start_app
}

