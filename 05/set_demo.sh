#!/bin/bash

# Treat unset variables as errors.
set -u
name="student"
echo "Hello, $name"

# Show commands as the shell executes them.
set -x
total=$((2 + 3))
echo "Total: $total"
set +x

# Stop a subshell when a command fails.
(
    set -e
    false
    echo "This line is not reached"
)
echo "The subshell stopped because a command failed"

# Make a pipeline fail if any of its commands fails.
set -o pipefail
if false | true; then
    echo "Pipeline succeeded"
else
    echo "Pipeline failed"
fi

# Replace the script's positional parameters.
set -- alpha beta gamma
echo "Number of arguments: $#"
echo "First argument: $1"
echo "All arguments: $*"

# Display the current shell options.
set -o
