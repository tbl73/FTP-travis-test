#hook to prevent binding.pry getting into production code
echo "Testing for binding.pry"

echo "head to travis branch diff"

TEST1=(git diff --name-only HEAD...$TRAVIS_BRANCH)

echo $TEST1

echo "head to travis branch diff with filter"
TEST2=(git diff --name-only --diff-filter=AM HEAD...$TRAVIS_BRANCH)

echo $TEST2
echo "original search"

DIFF_SEARCH=$(git diff --name-only $TRAVIS_COMMIT_RANGE $AGAINST -G "binding\.pry")

echo $DIFF_SEARCH

if [ "$DIFF_SEARCH" ]; then
  echo "Found binding.pry in these files:"
  printf "$DIFF_SEARCH"
  echo
fi

  exit 1
