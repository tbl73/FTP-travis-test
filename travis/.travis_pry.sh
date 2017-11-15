#hook to prevent binding.pry getting into production code
echo "Testing for binding.pry"

if [ "$TRAVIS_PULL_REQUEST" == "true" ]; then
  TEST_BRANCH=$TRAVIS_PULL_REQUEST_BRANCH
else
  TEST_BRANCH=$TRAVIS_BRANCH
fi

echo "Testing $TEST_BRANCH"

#DIFF_SEARCH=$(git diff --name-only $TEST_BRANCH HEAD^ $AGAINST -G "binding\.pry")

DIFF_SEARCH=$(git diff --name-only HEAD $(git merge-base HEAD $TEST_BRANCH) $AGAINST -G "binding\.pry")

echo $DIFF_SEARCH

if [ "$DIFF_SEARCH" ]; then
  echo "Found binding.pry in these files:"
  printf "$DIFF_SEARCH"
  echo
fi

exit 1