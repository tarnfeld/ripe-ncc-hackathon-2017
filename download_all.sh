#!/bin/bash

set -x
set -e

./download_data.sh 1492560000 1492646400 outputs_raw_latest/
./download_data.sh 1492473600 1492560000 outputs_raw_latest/
./download_data.sh 1492387200 1492473600 outputs_raw_latest/
./download_data.sh 1492300800 1492387200 outputs_raw_latest/
./download_data.sh 1492214400 1492300800 outputs_raw_latest/
./download_data.sh 1492128000 1492214400 outputs_raw_latest/
./download_data.sh 1492041600 1492128000 outputs_raw_latest/
./download_data.sh 1491955200 1492041600 outputs_raw_latest/
./download_data.sh 1491868800 1491955200 outputs_raw_latest/
./download_data.sh 1491782400 1491868800 outputs_raw_latest/
./download_data.sh 1491696000 1491782400 outputs_raw_latest/
./download_data.sh 1491609600 1491696000 outputs_raw_latest/
./download_data.sh 1491523200 1491609600 outputs_raw_latest/
./download_data.sh 1491436800 1491523200 outputs_raw_latest/
