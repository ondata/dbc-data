#!/bin/bash

set -x
set -e
set -u
set -o pipefail

folder="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 2021

nomeSheet="DATI SINGOLA CATTURA"
nomeFile="MIPAAF-2021-0401500-Allegato-CopiadiACCESSOCIVICO_CattureBFTPESCASPORTIVA-RICREATIVA.xlsx"

in2csv -K 1 --sheet "$nomeSheet" -I "$folder"/../grezzi/"$nomeFile" | mlr --csv clean-whitespace then remove-empty-columns then skip-trivial-records then sort -f "Data cattura",Regione >"$folder"/../pescaTonnoRosso_2021.csv

# 2022
nomeFile="Catture Tonno rosso sportive_ricreative 2022.xls"

qsv excel --dates-whitelist 'Data' "$folder"/../grezzi/"$nomeFile" -Q | mlr --csv clean-whitespace then remove-empty-columns then skip-trivial-records then sort -f Data,REGIONE >"$folder"/../pescaTonnoRosso_2022.csv

mlr -I --csv label identificativo_natante,data_cattura,peso_kg,regione,zona_FAO "$folder"/../pescaTonnoRosso_2022.csv "$folder"/../pescaTonnoRosso_2021.csv

mlr --csv sort -f data_cattura,regione "$folder"/../pescaTonnoRosso_20*.csv >"$folder"/../pescaTonnoRosso.csv
