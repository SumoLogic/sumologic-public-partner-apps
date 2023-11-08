# \<App Name\>

- [Introduction](#introduction)
- [Log Types](#log-types)
- [Sample Log Message](#sample-log-message)
- [Query Sample](#query-sample)
- [Collect \<Logs,Metrics And Traces\> for \<App Name\>](#collect-logs,metrics-and-traces-for-app-name)
- [Install the App and View the Dashboards](#install-the-app-and-view-the-dashboards)
- [Support](#support)

## Introduction
Phylum analyzes open-source packages the moment they are released into package registries such as NPM, PyPI, and more. Phylum analyzes the risk of using untrusted open-source packages and identifies malicious code, author risk, software vulnerabilities, engineering risk, and license issues. Phylum publishes a threat feed of curated malicious packages and software supply chain threats identified by the platform.

The app provides an integration of Phylum’s threat feed into Sumologic to identify malicious open-source packages. 


## Log Types

The Phylum App uses logs containing SHA-256 file hashes, or open-source package names to join with the Phylum threat feed.

## Sample Log Message

```csv
file: /large/must.jpg, date: 1986-06-23, hash: 5c0be48ae6d89ef47a9a7349d2b1df04c60e1ad2eabce430b12dcac90d4e7b56
file: /right/item.gif, date: 2005-03-26, hash: 6eec8b39598ad5836d9db2967ad2fd92dbda7eba207402df79510ea3c227d4de
file: /thus/season.jpeg, date: 2013-03-03, hash: cf0969377cb57444fb2fa7227073811316f4ebf9bd3e7c21911085b99e035dc9
file: /exist/scene.pdf, date: 2022-06-10, hash: 25775aee0fb9cbe798fb2d60275925a6c0a2c1dc99e5bc4e43e4056cf5368c61
file: /axios-0.19.0.tar.gz, date: 2019-07-11, hash: 230980a9d002808d07b07d03c0707e07af2638462998762a830f8730ab07c0d1 
```

## Query Sample

This is an example of a simple query that joins `files_found` with Phylum Threat Data:
```text
_sourceCategory=files_found |
parse "hash: *" as candidate_hash | 
lookup * from path://"/Library/Users/pete@phylum.com/phylum-threat-data/threat-data" on id=candidate_hash 
```

## Collect File Hash and/or File name information for Phylum Integration

### Prerequisites

The only prerequisite is availability of data that contains one of the following:
- SHA256 hashes of files
- file names of open-source packages

### Configuring Collection
  - Collection step 1. Send logs with file hash information or file name information to SumoLogic

## Install the App and View the Dashboards

### Install the Phylum app from SumoLogic App Library
After configuring collection you can [install](https://help.sumologic.com/05Search/Library/Apps-in-Sumo-Logic/Install-Apps-from-the-Library) the SumoLogic App for Phylum from App Catalog.

### Install the Phylum Threat Feed Python Script
Phylum provides a Python script to load threat feed data into Sumologic. This script should be run on a schedule to get regular updates from Phylum’s threat feed. 

1. Clone the repository locally: `git clone https://github.com/SumoLogic/sumologic-public-partner-apps`
1. Navigate to the Phylum subdirectory of the cloned repository, then to “script”: `cd Phylum/script`
1. Install the required Python dependencies for the script: `pip install -r requirements.txt`
1. Create a new lookup table in Sumologic under the User’s Personal folder: https://help.sumologic.com/docs/search/lookup-tables/create-lookup-table/
    1. Note the path to the lookup table: An example path for a lookup table named “threat-table” in a folder named “phylum-threat-data” under the personal folder is: “/Library/Users/pete@phylum.com/phylum-threat-data/threat-table”
1. Edit the Python script named `load_threat_data.py` and change the path in the global variable `PHYLUM_LTABLE_PATH` to match the path from Step 4i.
1. Export environment variables for Sumologic API access. These are required for the script to load Phylum’s threat data into the User’s new lookup table created in Step 4.
    1. `SUMOAID` = Sumologic Access ID: `export SUMOAID=XXXXX`
    1. `SUMOAKEY` = Sumologic Access Key: `export SUMOAKEY=YYYYY`
1. Export environment variable for Phylum API access. This is required to authenticate to Phylum’s API and access the threat feed.
    1. `PHYLUM_API_TOKEN` = Phylum Token (this can be created with: https://docs.phylum.io/docs/phylum_auth_token): `export PHYLUM_API_TOKEN=ZZZZZZ`
1. Run the Python script `load_threat_data.py` ensuring environment variables from Steps 6 and 7 are correctly provided: `python load_threat_data.py`
1. Consider automating execution of the Python script “load_threat_data.py” through a scheduling tool such as Cron: 
    1. To run the script hourly, using the following addition to a crontab ensuring paths to the python program and load_threat_data.py script are updated: `0 * * * * /usr/bin/python /home/user/load_threat_data.py`


### Dashboards
#### Dashboard 1

Example dashboard showing total software supply chain threats and how many have been detected through log analysis with Sumologic.

Use this dashboard to:
- Monitor logs for file hashes that indicate a software supply chain attack has occured.
- Observe the number of software supply chain attacks Phylum has identified.

![Alt text](resources/screenshots/phylum_dashboard.jpg?raw=true "overview screenshot")


## Support
This application has been developed and is supported by Phylum. In case of technical questions, please contact support@phylum.io
