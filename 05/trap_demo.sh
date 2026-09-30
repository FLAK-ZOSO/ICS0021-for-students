#!/bin/bash

temporary_file=$(mktemp)

cleanup() {
    echo "Removing $temporary_file"
    rm -f "$temporary_file"
}

handle_signal() {
    echo "Received $1"
    exit 130
}

report_error() {
    echo "Command failed on line $1"
}

# Always clean up when the script finishes.
trap cleanup EXIT

# Handle Ctrl+C and termination requests.
trap 'handle_signal SIGINT' INT
trap 'handle_signal SIGTERM' TERM

# Report unsuccessful commands. ERR does not automatically stop the script.
trap 'report_error $LINENO' ERR

echo "Temporary data" > "$temporary_file"
echo "Try: $0 error"
echo "Try: $0 wait   # then press Ctrl+C"

case "${1:-}" in
    error) false ;;
    wait)  sleep 30 ;;
esac

# Display the traps currently installed.
trap -p

# To restore the default handling for a signal:
# trap - INT

# To show all the signals we can catch
# trap -l
