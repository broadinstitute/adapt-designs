#!/bin/bash

# This calls ../../../scripts/run-adapt/run_target_picker.sh
# script with custom values for Enterovirus B.

# This is only needed to start the ADAPT environment
source ../../../scripts/run-adapt/run_common.sh

../../../scripts/run-adapt/run_target_picker.sh enterovirus_b 0.90 0.20
