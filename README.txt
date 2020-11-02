View the latest version of the data package at https://portal.edirepository.org/nis/mapbrowse?scope=edi&identifier=549

PROCESS

1. In Excel:
- move notes from excel margins to notes column 17-present

2. In R:
- import data
- remove extra rows and columns
- fix date and time data
- change variable names and aggregate tables
- quality assurance:
	- remove white space
	- make sure all missing values are NA
	- check for characters in number columns
		- change T to trace column (or 0)
	- make cloud types consistent and replace with full types
		- check for invalid cloud types and replace with NA
	- add flag column for bounds checking
		- standardize flags across datasets
		- temp: check simple reasonable range
		- flag for potential instrument change
	- check number precision based on metadata
- export as CSV

3. Metadata
- compile metadata sources
	- check that all notes from Adam via email have been factored in 
- generate EML
