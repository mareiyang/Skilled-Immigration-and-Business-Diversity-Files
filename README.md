# Skilled Immigration and Business Diversity: Evidence from the H-1B Lottery

This project evaluates the effect of high-skilled immigration, proxied by H-1B lottery outcomes, on business diversity and firm concentration across U.S. counties. Using a continuous difference-in-differences framework and data from USCIS, the Department of Labor, and the U.S. Census Bureau, the study identifies modest but significant increases in business diversity following H-1B lottery wins.

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
├── Proseminar_Final_Paper.pdf            # Final thesis PDF
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

## Scripts and Workflow:

1. CBP_Data_Cleaning.Rmd:
   Cleans County Business Patterns data from 2012-2022, harmonizes NAICS codes, and creates some maps.
2. H-1B_Data_Cleeaning.Rmd
   Cleans USCIS H-1B lottery approvals and LCA applications, matches by ZIP code to counties, filters for likely-lottery-bound applications, and constructs a county-level win-rate.
3. H-1B_Data.qmd
   Merges CBP and H-1B lottery datasets, calculates Herfindahl-Hirschman and Shannon Diversity indices and estimates regression models using "fixest."

### Input Files

- **`CBP files`**  
  All CBP files from 2012–2022  
  [Download from Google Drive](#)

- **`H-1B Employer Data Hub (2016)`**  
  The 2016 USCIS H-1B Data Hub file  

- **`H-1B_Disclosure_Data_FY16.xlsx`**  
  LCA data for the 2016 H-1B lottery  
  [Download from Google Drive](#)


## Output Files

- **`cbp_2012_2022.csv`**  
  Cleaned County Business Patterns dataset  
  [Download from Google Drive](#)

- **`Lottery_Applications_vs_Approvals.csv`**  
  Merged county-level H-1B lottery data (USCIS + LCA)  

- **`H1bdf.csv`**  
  Final panel dataset used in regression analysis  

- **`ProsemData.csv`**  
  Larger dataset used to analyze heterogeneity  
  [Download from Google Drive](#)


## Author
Spencer Ma
The George Washington University
Email: spencerma@gwmail.gwu.edu

## License
This repository is for academic purposes only. If you want to use any of this project, please cite the thesis or contact the author for permission.
