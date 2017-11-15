#hook to prevent binding.pry getting into production code
echo "Testing for binding.pry"

if [ $TRAVIS_PULL_REQUEST ]; then
  echo "Pull request"
  TEST_BRANCH = $TRAVIS_PULL_REQUEST_BRANCH
else
  echo "Push on branch"
  TEST_BRANCH = $TRAVIS_BRANCH
fi

echo TEST_BRANCH

DIFF_SEARCH=$(git diff --name-only  $AGAINST -G "binding\.pry")

echo $DIFF_SEARCH

if [ "$DIFF_SEARCH" ]; then
  echo "Found binding.pry in these files:"
  printf "$DIFF_SEARCH"
  echo
fi

exit 1