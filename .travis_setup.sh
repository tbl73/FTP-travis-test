set -eux

# Install MySQL 5.7 if DB=mysql57
if [[ -n ${DB-} && x$DB =~ ^xmysql57 ]]; then
  sudo bash .travis_mysql57.sh
fi
