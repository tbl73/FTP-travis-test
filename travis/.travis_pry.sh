#hook to prevent binding.pry getting into production code

DEBUGGERS_REGEX="binding\.pry|debugger"

echo $DEBUGGERS_REGEX

DIFF_SEARCH=$(git diff --name-only $AGAINST -G $DEBUGGERS_REGEX)

echo $DIFF_SEARCH

if [ "$DIFF_SEARCH" ]; then
  echo "Found binding.pry in these files:"
  echo
  printf "$DIFF_SEARCH"
  echo
fi

exit 1
