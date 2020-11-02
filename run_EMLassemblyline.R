# This script executes an EMLassemblyline workflow.

# Initialize workspace --------------------------------------------------------

# Update EMLassemblyline and load

# remotes::install_github("EDIorg/EMLassemblyline")
library(EMLassemblyline)

# Define paths for your metadata templates, data, and EML

path_templates <- "~/Documents/Research/EDI/UMBS_Weather_Data/metadata/templates"
path_data <- "~/Documents/Research/EDI/UMBS_Weather_Data"
path_eml <- "~/Documents/Research/EDI/UMBS_Weather_Data/metadata/eml"

# Create metadata templates ---------------------------------------------------

# Below is a list of boiler plate function calls for creating metadata templates.
# They are meant to be a reminder and save you a little time. Remove the 
# functions and arguments you don't need AND ... don't forget to read the docs! 
# E.g. ?template_core_metadata

# Create core templates (required for all data packages)

EMLassemblyline::template_core_metadata(
  path = path_templates,
  license = "CCBY",
  write.file = TRUE)

# Create table attributes template (required when data tables are present)

EMLassemblyline::template_table_attributes(
  path = path_templates,
  data.path = path_data,
  data.table = c("weather.csv"))

# Create categorical variables template (required when attributes templates
# contains variables with a "categorical" class)

EMLassemblyline::template_categorical_variables(
  path = path_templates, 
  data.path = path_data)

# Create geographic coverage (required when more than one geographic location
# is to be reported in the metadata).

EMLassemblyline::template_geographic_coverage(
  path = path_templates, 
  data.path = path_data, 
  data.table = "", 
  lat.col = "",
  lon.col = "",
  site.col = "")

# Create taxonomic coverage template (Not-required. Use this to report 
# taxonomic entities in the metadata)

remotes::install_github("EDIorg/taxonomyCleanr")
library(taxonomyCleanr)

taxonomyCleanr::view_taxa_authorities()

EMLassemblyline::template_taxonomic_coverage(
  path = path_templates, 
  data.path = path_data,
  taxa.table = "",
  taxa.col = "",
  taxa.name.type = "",
  taxa.authority = 3)

# Make EML from metadata templates --------------------------------------------

# Once all your metadata templates are complete call this function to create 
# the EML.

E <- "-84.669381"
N <- "45.561608"
S <- "45.558932"
W <- "-84.679608"

Pid <- "edi.549.4"
Sid <- "edi.65.1"

EMLassemblyline::make_eml(
  path = path_templates,
  data.path = path_data,
  eml.path = path_eml, 
  dataset.title = "University of Michigan Biological Station Weather Observations 1980 to Present", 
  temporal.coverage = c("1980-01-01", "2020-04-30"), 
  geographic.description = "University of Michigan Biological Station, Douglas Lake, MI", 
  geographic.coordinates = c(N, E, S, W), 
  maintenance.description = "ongoing", 
  data.table = "weather.csv", 
  data.table.name = "UMBS Weather 1980 to Present",
  data.table.description = "Daily temperature, precipitation, and cloud cover data",
  other.entity = c("UMBS_Weather_Cleaning.Rmd", "src.zip"),
  other.entity.name = c("R script for data formatting and cleaning", "Source data for R script"),
  other.entity.description = c("R script for data formatting and cleaning", "Source data for R script"),
  user.id = "umbiologicalstat",
  user.domain = "EDI", 
  package.id = Pid)
