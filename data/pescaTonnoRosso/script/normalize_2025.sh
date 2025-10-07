#!/bin/bash

set -x
set -e
set -u
set -o pipefail

folder="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "${folder}"/tmp

# 2025
nomeFile="${folder}/../grezzi/BFT_SPORT_2025.xls"

# estrai dati
qsv excel "$nomeFile" --date-format "%m/%d/%Y" -Q > "${folder}/tmp/BFT_SPORT_2025.csv"

# normalizza
mlr -I -S --csv --from "${folder}/tmp/BFT_SPORT_2025.csv" remove-empty-columns then clean-whitespace then skip-trivial-records
duckdb -c "COPY (SELECT \"Identificativo natante 2025\"::BIGINT AS identificativo_natante, CAST(Data AS VARCHAR) AS data_cattura, \"KG.\"::DOUBLE AS peso_kg, REGIONE AS regione, FAO AS zona_FAO FROM '${folder}/tmp/BFT_SPORT_2025.csv') TO '${folder}/tmp/tmp.csv' (HEADER, DELIMITER ',');"

mv  "${folder}/tmp/tmp.csv" "${folder}"/../pescaTonnoRosso_2025.csv
sed -i 's/CAMPOBASSO/MOLISE/g' "${folder}"/../pescaTonnoRosso_2025.csv

# unisci i file

mlr -S --csv sort -t data_cattura,regione "${folder}"/../pescaTonnoRosso_2*.csv > "${folder}"/../pescaTonnoRosso.csv
