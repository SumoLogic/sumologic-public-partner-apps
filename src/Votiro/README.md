# Votiro

- [Introduction](#introduction)
- [Sample Log Message](#sample-log-message)
- [Query Sample](#query-sample)
- [Collect Logs for Votiro](#collect-logs-for-votiro)
- [Install the App and View the Dashboards](#install-the-app-and-view-the-dashboards)
- [Support](#support)

## Introduction
  Threat related information sent from Votiro Sanitization engine to Sumo logic customers will allow them better mitigate cyber attacks, do effective threat hunting and enrich cyber security alerts.
  | Dashboard | Description    |
  | :---:   | :---: |
  | [Votiro Monitoring Dashboard] | The Votiro Monitoring Dashboard provides a high-level view of the state of the Sanitization results of traffic getting sanitized via Votiro software. The Votiro CEF syslog is ingested to Sumo Logic and the data is visually represented on a dashboard. The panels of the dashboard show the Incoming Traffic (Data Source) in terms of the number of files and emails getting sanitized via respective connectors, Scanned Files (Threats) results, total Threats Disarmed per day, and Incoming Files types trends. |


## Sample Log Message


```text
May 27 13:28:07 CEF:0|Votiro|Votiro cloud|9.6.348|10000010|Sanitization summary|5|companyName=Votiro Cloud correlationId=19e4bfac-1d79-487a-82eb-5d195b93c35f itemId=19e4bfac-1d79-487a-82eb-5d195b93c35f fileName=seek.jpg fileType=jpg fileHash=b4231eb68c33a5998a9653cac468cba2471038994d39fce01f6e546b9075f700 fileSize=3 passwordProtected=false AVResult=Clean threatCount=5 blockedCount=0 threats=Suspicious Unknown File fileModification=Types breach link, Malware cleaned office, Empty link breach exploit, Types removed relation macro, Relation office suspicious empty removed breach sanitizationResult=Sanitized sanitizationTime=18 connectorType=Email connector connectorName=Default email connector connectorId=da1bd91e-201f-4b62-a221-6b6ffaa35a87 policyName=Default policy exceptionId=null incidentURL=https://votiro.simulator/app/fileDetails/19e4bfac-1d79-487a-82eb-5d195b93c35f/19e4bfac-1d79-487a-82eb-5d195b93c35f messageId=5P0HT3K35K5AV5Y3J7N6O2SG3B6GQHI5@orgk.local subject=Minute prevent than indicate also particular from=zleon@jackson.com recipients=smithwilliam@votiro.com, ryan25@votiro.com, mannelizabeth@votiro.com, liualyssa@harris-young.com
```

## Query Sample

This is an example of a simple query that returns number events grouped by file types.

```text
_sourceCategory=prod/votiro/syslog
| count by file_type
```

## Collect Logs for Votiro

Votiro App is going to collect data using [Installed Collector.](https://help.sumologic.com/docs/send-data/installed-collectors/)

Post installation, create a source on the collector using follow instructions:
1. Login to Sumo Logic -> Manage Data -> Collection
   As the installation was successful the Installed Collector shows up in the Collection console, with Healthy status.
   Lets add a data source to the collector by selecting "Add" -> "Add Source" 

2. Under "Platform Sources" -> "Syslog"	
    1. Provide a name to the source. 
        For e.g., "Votiro Syslog Source"
    2. Choose "Protocol" as "TCP"
    3. Input the on which the syslog is configured "Port", by default its "1514"
    4. Provide "Source Category" as "prod/votiro/syslog"
    5. Keep everything else as default
    6. Click on "Save”

    ![Alt text](resources/screenshots/Votiro_Syslog_Collector_Config.png?raw=true "Syslog Collector Config")


Your Sumo Logic Admin setting up the Votiro App(only once) should add the following field extraction rules to the tenant using below mentioned steps:
Follow below steps to create Field Extraction rules at ingest time.
1. Copy the rules from below:
    ```text
    | parse regex "companyName=(?<company_name>.*?)\s\w*[=]|$" nodrop
    | parse regex "correlationId=(?<correlation_id>.*?)\s\w*[=]|$" nodrop
    | parse regex "itemId=(?<item_id>.*?)\s\w*[=]|$" nodrop
    | parse regex "fileName=(?<file_name>.*?)\s\w*[=]|$" nodrop
    | parse regex "fileType=(?<file_type>.*?)\s\w*[=]|$" nodrop
    | parse regex "fileHash=(?<file_hash>.*?)\s\w*[=]|$" nodrop
    | parse regex "fileSize=(?<file_size>.*?)\s\w*[=]|$" nodrop
    | parse regex "passwordProtected=(?<password_protected>.*?)\s\w*[=]|$" nodrop
    | parse regex "AVResult=(?<av_result>.*?)\s\w*[=]|$" nodrop
    | parse regex "threatCount=(?<threat_count>.*?)\s\w*[=]|$" nodrop
    | parse regex "blockedCount=(?<blocked_count>.*?)\s\w*[=]|$" nodrop
    | parse regex "threats=(?<threats>.*?)\s\w*[=]|$" nodrop
    | parse regex "fileModification=(?<file_modification>.*?)\s\w*[=]|$" nodrop
    | parse regex "sanitizationResult=(?<sanitization_result>.*?)\s\w*[=]|$" nodrop
    | parse regex "sanitizationTime=(?<sanitization_time>.*?)\s\w*[=]|$" nodrop
    | parse regex "connectorType=(?<connector_type>.*?)\s\w*[=]|$" nodrop
    | parse regex "connectorName=(?<connector_name>.*?)\s\w*[=]|$" nodrop
    | parse regex "connectorId=(?<connector_id>.*?)\s\w*[=]|$" nodrop
    | parse regex "policyName=(?<policy_name>.*?)\s\w*[=]|$" nodrop
    | parse regex "exceptionId=(?<exception_id>.*?)\s\w*[=]|$" nodrop
    | parse regex "incidentURL=(?<incident_url>.*?)\s\w*[=]|$" nodrop
    | parse regex "messageId=(?<message_id>.*?)\s\w*[=]|$" nodrop
    | parse regex "subject=(?<subject>.*?)\s\w*[=]|$" nodrop
    | parse regex "from=(?<from>.*?)\s\w*[=]|$" nodrop
    | parse regex "recipients=(?<recipients>.*?)\s\w*[=]|$" nodrop
    | parse "* CEF:*|*|*|*|*|*|*|*" as syslog_timestamp, cef_version, device_vendor, device_product, device_version, signature_id,  message_name, message_severity, message_extension nodrop
    | fields - message_extension, cef_version
    ```

2. Login to the Sumo Logic tenant -> Manage Data -> Logs -> Field Extraction Rules -> Click on "+ Add Rule"
    1. Provide the name as - Votiro CEF Syslog Parsing
    2. Choose "Applied At" as "Ingest Time"
    3. Choose "Scope" as "Specific Data"
    4. Select "Metadata" as "_sourcecategory"
    5. Provide "Value" as "prod/votiro/syslog"
    6. Paste the copied rules from Step 1. inside "Parse Expression *"
    7. Click on Save

    ![Alt text](resources/screenshots/Votiro_Field_Extraction_Rules.png?raw=true)



## Install the App and View the Dashboards

### Install

Use the instruction from this [doc](https://help.sumologic.com/docs/get-started/apps-integrations/#install-apps-from-the-library) to install the Votiro App.

Note: While choosing the log source, enter a custom source category beginning with an underscore i.e., _sourceCategory=prod/votiro/syslog

### Dashboards

#### Votiro Monitoring Dashboard

The Votiro Monitoring Dashboard provides a high-level view of the state of the Sanitization results of traffic getting sanitized via Votiro software. The Votiro CEF syslog is ingested to Sumo Logic and the data is visually represented on a dashboard. 

The panels of the dashboard show the Incoming Traffic (Data Source) in terms of the number of files and emails getting sanitized via respective connectors, Scanned Files (Threats) results, total Threats Disarmed per day, and Incoming Files types trends.

Use this dashboard to:
1. Monitor incoming traffic from different sources, like File or Email collectors
2. Review the Sanitization results for all the scanned files(threats) from the data sources
3. Understand how many threats are being Sanitized over a period of time.                               
4. Investigate which files are being received by the Sanitization process

![Alt text](resources/screenshots/Votiro_Overview_Dashboard.png?raw=true)

## Support

This application has been developed and is supported by Votiro. In case of technical questions, please contact Votiro support at support@votiro.com or +1 646 906 9669.
