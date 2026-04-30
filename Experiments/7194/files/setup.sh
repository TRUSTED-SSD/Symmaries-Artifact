#!/bin/bash

thisdir="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")";

echo "Appending \`$HOME/.local/bin' to PATH variable.";
export PATH="${PATH}:$HOME/.local/bin";

echo "Appending \`${thisdir}' to PATH variable.";
export PATH="${PATH}:${thisdir}";

echo "Appending \`${thisdir}' to LD_LIBRARY_PATH variable.";
export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${thisdir}";
