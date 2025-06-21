#!/usr/bin/env bash
set -e
xvlog -sv ../rtl/rr_arbiter.v ../sim/tb_rr_arbiter.v
xelab tb_rr_arbiter -R
chmod +x scripts/run_sim.sh
