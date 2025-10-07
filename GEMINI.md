# Project Overview

This project is a data repository focused on the "Campagna di pesca del tonno rosso" (Bluefin Tuna Fishing Campaign) for the years 2021, 2022, 2023, and 2024. The primary goal is to collect, normalize, and manage data related to the sport/recreational fishing contingent, obtained through civic access requests.

The project structure follows a standard ETL (Extract, Transform, Load) pattern, with raw data, interim data, and processed data clearly separated.

## Directory Overview

*   `data/`: Contains all project data.
    *   `raw/`: Original and immutable raw data files (e.g., Excel spreadsheets).
    *   `interim/`: Intermediate, transformed, and temporary data files (e.g., yearly CSVs).
    *   `processed/`: Final processed data, ready for analysis or loading (`pescaTonnoRosso.csv`).
*   `docs/`: Project documentation (currently not present, but intended for plans, data dictionaries, reports).
*   `scripts/`: Contains the main scripts for the ETL process.
*   `.gitignore`: Specifies intentionally untracked files to ignore.
*   `LOG.md`: Project decision and progress log.
*   `README.md`: Project description, installation, and usage instructions.
*   `catalogo.yml`: A catalog file describing the datasets within the project.

## Key Files

*   `/home/aborruso/git/dbc-data/README.md`: The main project README, providing an introduction and links to dataset-specific documentation.
*   `/home/aborruso/git/dbc-data/catalogo.yml`: Defines the metadata for the datasets included in this repository, such as title, description, and associated files.
*   `/home/aborruso/git/dbc-data/data/pescaTonnoRosso/README.md`: Provides specific details about the "Dati Campagna Pesca Tonno rosso" dataset, including its description, file list, notes on data origin, and schema definition.
*   `/home/aborruso/git/dbc-data/data/pescaTonnoRosso/pescaTonnoRosso.yml`: A Data Package resource descriptor for the `pescaTonnoRosso.csv` file, defining its encoding, format, hashing, path, profile, and detailed schema (field names and types).
*   `/home/aborruso/git/dbc-data/data/pescaTonnoRosso/script/normalize.sh`: This Bash script orchestrates the ETL process for the tuna fishing data. It uses `in2csv` and `qsv excel` to convert raw Excel files into CSV format, and `mlr` (Miller) for data cleaning (whitespace removal, empty column removal, trivial record skipping), sorting, and merging of yearly data into a single `pescaTonnoRosso.csv` file.

## Usage

The project is designed to process raw data from various sources (e.g., Excel files) into a standardized CSV format. The `normalize.sh` script is the core component for this transformation.

To process the data, execute the `normalize.sh` script from the `data/pescaTonnoRosso/script/` directory. This script will:
1.  Convert the raw Excel files from the `grezzi/` directory into yearly CSV files (e.g., `pescaTonnoRosso_2021.csv`, `pescaTonnoRosso_2022.csv`).
2.  Clean and normalize the data within these yearly CSVs using `mlr`.
3.  Merge the yearly CSVs into a single, comprehensive `pescaTonnoRosso.csv` file in the `data/pescaTonnoRosso/` directory.

**Example Command:**
```bash
/home/aborruso/git/dbc-data/data/pescaTonnoRosso/script/normalize.sh
```

The processed `pescaTonnoRosso.csv` file, along with its schema defined in `pescaTonnoRosso.yml`, can then be used for further analysis or integration into other systems.
