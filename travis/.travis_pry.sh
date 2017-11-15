#hook to prevent binding.pry getting into production code
echo "Testing for binding.pry"

if [ "$TRAVIS_PULL_REQUEST" == "true" ]; then
  TEST_BRANCH=$TRAVIS_PULL_REQUEST_BRANCH
else
  TEST_BRANCH=$TRAVIS_BRANCH
fi

echo "Testing $TEST_BRANCH"

#DIFF_SEARCH=$(git diff --name-only $TEST_BRANCH..HEAD $AGAINST -G "binding\.pry")

echo "HEAD"
git diff --name-only HEAD

echo "HEAD^"
git diff --name-only HEAD^

echo "test branch"
echo $TEST_BRANCH
git diff --name-only $TEST_BRANCH

echo "travis commit"
echo $TRAVIS_COMMIT
git diff --name-only $TRAVIS_COMMIT

echo "travis commit range"
echo $TRAVIS_COMMIT_RANGE
git diff --name-only $TRAVIS_COMMIT_RANGE

#DIFF_SEARCH=$(git diff --name-only $TEST_BRANCH)

#echo "diff search is:"
#echo $DIFF_SEARCH

#if [ "$DIFF_SEARCH" ]; then
#  echo "Found binding.pry in these files:"
#  printf "$DIFF_SEARCH"
#  echo
#fi

exit 1