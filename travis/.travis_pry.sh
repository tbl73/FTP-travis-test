#hook to prevent binding.pry getting into production code
echo "Testing for binding.pry"

DIFF_SEARCH=$(git diff --name-only HEAD^ $AGAINST -G "binding\.pry")

if [ "$DIFF_SEARCH" ]; then
  echo "Found binding.pry in these files:"
  printf "$DIFF_SEARCH"
  echo
  exit 1
fi

