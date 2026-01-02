# MATLAB Pipeline for UL 1974 Evaluation of Repurposed Li-Ion Batteries

This project provides a MATLAB-based data processing pipeline for analyzing charge–discharge test data of repurposed lithium-ion batteries evaluated under the UL 1974 standard. The workflow is designed to handle multi-stage test procedures (e.g., P1 and P2) defined in UL 1974, append fragmented datasets into continuous timelines, and generate current–voltage profiles suitable for safety, performance, and second-life assessment.

The data structure and processing logic are aligned with publicly available UL 1974–based experimental datasets for repurposed LiFePO₄ (LFP) battery cells, enabling consistent analysis of charge/discharge behavior, rest periods, and load conditions used in repurposing qualification.

---

## Motivation

As large numbers of electric vehicle batteries reach end-of-life, **battery repurposing** has emerged as a critical pathway to reduce environmental impact and recover residual value. Although many retired batteries retain a significant portion of their original capacity, their safe and reliable reuse requires standardized evaluation.

**UL 1974** defines industry-recognized procedures for assessing the safety and performance of repurposed battery cells, modules, and packs, including controlled charge–discharge cycling, rest periods, and stress conditions. However, datasets generated under UL 1974 are often fragmented across multiple test stages and stored in complex folder and file naming formats, making analysis inefficient and error-prone.

This project was developed to:
- Support analysis of battery test data generated according to UL 1974 procedures  
- Automatically handle multi-part test segments (e.g., P1 and P2)  
- Enable consistent visualization of charge–discharge behavior for repurposed cells  
- Provide a reusable, scalable tool for second-life battery research and engineering workflows  

The pipeline facilitates faster interpretation of UL 1974 test data and supports model development, valid


---

## Project Structure

```text
ev-battery-test-data-processing/
├─ _codes/
│  ├─ build_dataTest.m      % Main script (run this)
│  ├─ getPFiles.m          % Helper: locate P1/P2 CSV files
│  └─ loadTIV.m            % Helper: load time/current/voltage
├─ _data/                  % Raw battery test folders (excluded)
├─ _figures/               % Auto-generated plots
└─ README.md
```


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
- Figures saved automatically to `_figures/`
- Processed data saved as `dataTest.mat`

## Example Results

### UL 1974 Charge–Discharge Profiles (Repurposed Li-ion Cells)

**Battery #5 — P1 and P2 appended**

Current and Voltage vs. Time  
![Current vs Time](Set1_Batt05_IV)



*Dashed vertical line indicates transition between P1 and P2 test segments.*


## Design Notes

- Raw CSV data is intentionally excluded from this repository
- Folder naming conventions are resolved dynamically
- Helper functions isolate file handling from analysis logic
- The code is structured for future expansion (e.g., resistance estimation, SOC-based analysis)

## Author

Masa Damdoum
Bachelor of Applied Science – Electrical Engineering (Co-op)
University of Windsor

## Disclaimer

This repository is intended for academic and research use. Raw experimental data may be subject to confidentiality and is not included.
