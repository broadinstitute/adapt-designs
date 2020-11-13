# adapt-designs
Design outputs from ADAPT.

**For more information on ADAPT and on how to run it, please see the [ADAPT repository](https://github.com/broadinstitute/adapt) on GitHub.**

## Overview

This repository contains several designs we produced with ADAPT, including ones tested experimentally.

The designs are in `designs/`, organized by viral family.
In particular, ADAPT's output are `.tsv` files in the `out/` directories.

`scripts/run-adapt/` contains scripts for running ADAPT.
They require setting up a `scripts/run-adapt/custom-env/load_custom_env.sh` script to load an environment with ADAPT and to set the environment variables used by `run_common.sh`.
