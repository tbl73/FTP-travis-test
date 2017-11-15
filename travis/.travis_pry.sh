#hook to prevent binding.pry getting into production code

git diff --name-only HEAD^
echo "Testing"

DIFF_SEARCH=$(git diff --name-only $AGAINST -G "binding\.pry")

echo $DIFF_SEARCH

if [ "$DIFF_SEARCH" ]; then
  echo "Found binding.pry in these files:"
  echo
  printf "$DIFF_SEARCH"
  echo

fi

  exit 1
