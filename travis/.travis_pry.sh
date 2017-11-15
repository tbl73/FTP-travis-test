#hook to prevent binding.pry getting into production code

if git rev-parse --verify HEAD >/dev/null 2>&1
then
  against=HEAD
else
  # Initial commit: diff against an empty tree object
  against=4b825dc642cb6eb9a060e54bf8d69288fbee4904
fi

# Redirect output to stderr.
exec 1>&2


DEBUGGERS_REGEX="binding\.pry|debugger"

DIFF_SEARCH=$(git diff --name-only $AGAINST -G $DEBUGGERS_REGEX)

if [ $DIFF_SEARCH ]; then
  echo "Found binding.pry in these files:"
  echo
  printf "$DIFF_SEARCH"
  echo
  exit 1
fi
