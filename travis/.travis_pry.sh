#hook to prevent binding.pry getting into production code
echo "Testing for binding.pry"

if [ "$TRAVIS_PULL_REQUEST" == "true" ]; then
  TEST_BRANCH=$TRAVIS_PULL_REQUEST_BRANCH
else
  TEST_BRANCH=$TRAVIS_BRANCH
fi

echo "Testing $TEST_BRANCH"

DIFF_SEARCH=$(git diff --name-only $TRAVIS_COMMIT_RANGE)

REGEX="binding\.pry"

PRY=$(grep -i $REGEX $DIFF_SEARCH)

if [ "$PRY" ]; then
  echo "Exit build; found binding.pry in these files:"
  printf "$PRY"
  echo
fi

exit 1