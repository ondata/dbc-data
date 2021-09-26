#!/bin/bash

set -x
set -e
set -u
set -o pipefail

folder="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

nomeSheet="DATI SINGOLA CATTURA"
nomeFile="MIPAAF-2021-0401500-Allegato-CopiadiACCESSOCIVICO_CattureBFTPESCASPORTIVA-RICREATIVA.xlsx"

in2csv -K 1 --sheet "$nomeSheet" -I "$folder"/../grezzi/"$nomeFile" | mlr --csv clean-whitespace then remove-empty-columns then skip-trivial-records then sort -f "Data cattura",Region >"$folder"/../pescaTonnoRosso.csv
