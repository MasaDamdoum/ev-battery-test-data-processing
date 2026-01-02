# EV Battery Test Data Processing

A MATLAB-based data processing pipeline for automated loading, concatenation, and visualization of electric vehicle (EV) battery test data.

This project processes multi-part battery cycling experiments (e.g., P1/P2 test segments), automatically appends time-series data, and generates continuous current–voltage profiles for individual battery cells. The workflow is designed for scalability across multiple battery sets and test conditions.

---

## Motivation

Battery cycling and aging experiments often generate fragmented CSV files across multiple test stages and datasets. Manual loading and plotting is time-consuming and error-prone.

This project addresses that problem by:
- Automatically locating battery test folders
- Dynamically handling inconsistent naming conventions
- Appending multi-part test data into a single continuous timeline
- Generating publication-ready plots
- Saving processed results in fast-loading `.mat` structures

---

## Project Structure

ev-battery-test-data-processing/
│
├─ _codes/
│ ├─ build_dataTest.m % Main script (run this)
│ ├─ getPFiles.m % Helper function: locate P1/P2 CSV files
│ └─ loadTIV.m % Helper function: load time/current/voltage
│
├─ _data/ % Raw battery test folders (excluded)
├─ _figures/ % Auto-generated plots
└─ README.md


---

## Key Features

- Automatic detection of battery folders based on dataset and battery number
- Robust handling of single-digit and double-digit battery indices
- Supports multiple dataset formats and variable zero-padding
- Appends P1 and P2 test segments into a continuous time axis
- Modular function-based design for extensibility
- Saves processed data into structured `.mat` files for reuse
- Generates current vs. time and voltage vs. time plots

---

## Workflow Overview

1. User specifies a dataset (`batterySet`) and a battery index (`batteryNumber`)
2. The code locates the corresponding battery folder automatically
3. All relevant CSV files (e.g., P1 and P2) are detected and loaded
4. Time vectors are normalized and appended sequentially
5. Current and voltage data are concatenated
6. Results are plotted and saved to disk
7. Processed data is stored in a structured MATLAB variable

---

## Usage Instructions

### Requirements
- MATLAB R2022a or newer (recommended)
- Battery test data stored as CSV files

### Steps
1. Place raw battery test folders inside the `_data/` directory
2. Open MATLAB and set the current folder to `_codes/`
3. Open `build_dataTest.m` and set:
   ```matlab
   batterySet    = 1;   % Dataset identifier
   batteryNumber = 5;   % Battery index
4. Run the Script: build_dataTest

## Outputs

-Figures saved automatically to _figures/
-Processed data saved as dataTest.mat

## Design Notes

-Raw CSV data is intentionally excluded from this repository
-Folder naming conventions are resolved dynamically
-Helper functions isolate file handling from analysis logic
-The code is structured for future expansion (e.g., resistance estimation, SOC-based analysis)

## Author

Masa Damdoum
Bachelor of Applied Science – Electrical Engineering (Co-op)
University of Windsor

## Disclaimer

This repository is intended for academic and research use. Raw experimental data may be subject to confidentiality and is not included.
