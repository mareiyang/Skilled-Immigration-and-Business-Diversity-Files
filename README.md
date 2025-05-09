# Replication Code for Ma, Spencer. 2025. Skilled Immigration and Business Diversity: Evidence From the H-1B Lottery

This project provides the replication code and most of the datasets for **Ma, Spencer. 2025. Skilled Immigration and Business Diversity: Evidence from the H-1B Lottery.

```
.
├── Datasets/
│   ├── CBP Data/
│   │   ├── Tables/                        # Raw CBP CSV files (2012–2022)
│   │   └── NAICS 2012-2017/              # Crosswalk from NAICS 2012 to 2017
│   ├── H-1B Data/
│   │   ├── H-1B Employer Data Hub (2017).xlsx
│   │   ├── H-1B_Disclosure_Data_FY16.xlsx
│   └── ZIP_COUNTY_122016.xlsx            # HUD Zip-County crosswalk
├── CBP_Data_Cleaning.Rmd                 # Cleans County Business Patterns data
├── H-1B_Data_Cleaning.Rmd                # Cleans USCIS + LCA data and constructs win rates
├── H-1B_Data.qmd                         # Merges datasets, computes HHI/Shannon, runs regressions
├── README.md
```

All scripts assume the following relative folder layout (enabled by `here::here()`):

## Required R Packages

This project uses the following R packages. Install them before running any `.Rmd` or `.qmd` files:

```r
install.packages(c(
  "tidyverse", "data.table", "readxl", "janitor", "lubridate",
  "here", "stringr", "sf", "ggplot2", "viridis", "tidycensus", "tigris",
  "tidyr", "lmtest", "sandwich", "fixest"
))
```

## Scripts and Workflows, Please run the scripts in the given order:

1. CBP_Data_Cleaning.Rmd:  
   Cleans County Business Patterns data from 2012-2022, harmonizes NAICS codes, and creates some maps.
2. H-1B_Data_Cleeaning.Rmd:  
   Cleans USCIS H-1B lottery approvals and LCA applications, matches by ZIP code to counties, filters for likely-lottery-bound applications, and constructs a county-level win-rate.
3. H-1B_Data.Qmd:  
   Merges CBP and H-1B lottery datasets, calculates Herfindahl-Hirschman and Shannon Diversity indices and estimates regression models using "fixest."

### Input Files

- **`CBP files`**  
  All CBP files from 2012–2022. Make sure to place it under Datasets\Tables  
  [Download from Google Drive](https://drive.google.com/drive/folders/18FqGTgWY_HrpHcq-7cpehWTBj9khGm6x?usp=sharing)

- **`H-1B Employer Data Hub (2016)`**  
  The 2016 USCIS H-1B Data Hub file  

- **`H-1B_Disclosure_Data_FY16.xlsx`**  
  LCA data for the 2016 H-1B lottery. Make sure to place it under Datasets\H-1B Data  
  [Download from Google Drive](https://drive.google.com/drive/folders/18FqGTgWY_HrpHcq-7cpehWTBj9khGm6x?usp=sharing)


## Output Files

- **`cbp_2012_2022.csv`**  
  Cleaned County Business Patterns dataset. This goes in the main folder.  
  [Download from Google Drive](https://drive.google.com/drive/folders/18FqGTgWY_HrpHcq-7cpehWTBj9khGm6x?usp=sharing)

- **`Lottery_Applications_vs_Approvals.csv`**  
  Merged county-level H-1B lottery data (USCIS + LCA)  

- **`H1bdf.csv`**  
  Final panel dataset used in regression analysis  

- **`ProsemData.csv`**  
  Larger dataset used to analyze heterogeneity. This goes in the main folder.  
  [Download from Google Drive](https://drive.google.com/drive/folders/18FqGTgWY_HrpHcq-7cpehWTBj9khGm6x?usp=sharing)


## Author
Spencer Ma
The George Washington University
Email: spencerma@gwmail.gwu.edu

## License
This repository is for academic purposes only. If you want to use any of this project, please cite the thesis or contact the author for permission.
