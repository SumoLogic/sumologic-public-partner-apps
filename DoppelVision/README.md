# DoppelVision

- [Introduction](#introduction)
- [Sample Log Message](#sample-log-message)
- [Query Sample](#query-sample)
- [Collect Logs for DoppelVision](#collect-logs-for-Doppel-Vision)
- [Install the App and View the Dashboards](#install-the-app-and-view-the-dashboards)
- [Support](#support)

## Introduction
  Doppel Vision manages external threats at the speed of AI. Doppel technology identifies and takes down deep fakes, malicious impersonations, phishing, and disinformation campaigns targeting clients, and utilises proprietary AI and machine learning tools to automate threat detection and takedowns. These dynamic features enable Doppel Vision to scale with you as your partner in brand protection in an evolving threat landscape.
  | Dashboard | Description    |
  | :---:   | :---: |
  | [Doppel Dashboard] | The Doppel Dashboard provides a comprehensive overview of digital risk protection metrics and alerts, helping users monitor high-severity threats, analyse alerts by various categories, and gain actionable insights. |


## Sample Log Message


```text
{"id":"report_010","submitted_url":"http://unlicensed-medications.com","doppel_url":"http://doppel.unlicensed-medications.com","report_status":"needs_confirmation","classification":"suspicious","product":"ecommerce","source":"analyst_upload","notes":"Selling unlicensed medications.","uploaded_by":"analyst_3@yahoo.com","created_at":"2024-07-22T14:25:54.321Z","matches":[{"domain":{"url":"http://buy.unlicensed-medications.com","screenshot_url":"http://screenshots.example.com/unlicensed_medications.png","classification":"illegal_pharmacy"}}],"root_domain":{"domain":"unlicensed-medications.com","registrar":"Porkbun","ip_address":"192.168.1.10","country_code":"BR","hosting_provider":"Hostinger"},"audit_logs":[{"changed_by":"admin","value":"Review ongoing","timestamp":"2024-07-22T14:30:00.321Z","type":"status_update","metadata":{"enforcement_request":{"platform":"e-commerce","type":"product_ban"},"match":{"domain":{"url":"http://buy.unlicensed-medications.com"}}}}],"tags":[{"name":"illegal_pharmacy"}]}
```

## Query Sample

This is an example of a simple query that returns number alerts.

```text
_sourceCategory=prod/doppel/log
| count
```

## Collect Logs for DoppelVision

Doppel Vision App is going to collect data using [Hosted Collector.](https://help.sumologic.com/docs/send-data/hosted-collectors/configure-hosted-collector/)

Post creation of a host collector, create a source on the collector using follow instructions:
1. Login to Sumo Logic -> Manage Data -> Collection
   The installed host collector shows up.
   Lets add a data source to the collector by selecting "Add" -> "Add Source" 

2. Now you can search for the HTTP Logs & Metrics. 
    1. Provide a name to the source. 
        For e.g., "Doppel Log Source"
    2. Provide "Source Category" as "prod/doppel/log"
    3. Keep everything else as default
    4. Click on Save
    5. Now you will get an url, which will be used for sending logs from Doppel to SumoLogic. Copy the URL and we can use it to send logs to sumologic.

    ![Alt text](resources/screenshots/collectorconfig.png?raw=true "Collector Config")


Your Sumo Logic Admin setting up the Doppel Vision App(only once) should add the following field extraction rules to the tenant using below mentioned steps: Follow below steps to create Field Extraction rules at ingest time.
1. Copy the rules from below:
    ```text
    | parse regex "\"product\":\"(?<product>.*?)\".*\"report_status\":\"(?<report_status>.*?)\""
    ```

2. Login to the Sumo Logic tenant -> Manage Data -> Logs -> Field Extraction Rules -> Click on "+ Add Rule"
    1. Provide the name as - Doppel Log Parsing
    2. Choose "Applied At" as "Ingest Time"
    3. Choose "Scope" as "Specific Data"
    4. Select "Metadata" as "_sourcecategory"
    5. Provide "Value" as "prod/doppel/log"
    6. Paste the copied rules from Step 1. inside "Parse Expression *"
    7. Click on Save

    ![Alt text](resources/screenshots/DoppelVisionFieldExtractionRules.png?raw=true)



## Install the App and View the Dashboards

### Install

Use the instruction from this [doc](https://help.sumologic.com/docs/get-started/apps-integrations/#install-apps-from-the-library) to install the Doppel Vision App.

Note: While choosing the log source, enter a custom source category beginning with an underscore i.e., _sourceCategory=prod/doppel/log

### Dashboards

#### Doppel Vision Dashboard

Use this dashboard to monitor high-severity threats, analyse alerts by product, status, and threat type, and review overall alert volume.

Use this dashboard to:
1. Monitor high-severity threats and scan attacks.
2. Review alerts by status for troubleshooting configuration issues.
3. Understand how to fine-tune Doppel Vision based on alert metrics.                             

![Alt text](resources/screenshots/DoppelVisionDashboard.png?raw=true)

## Support

This application has been developed and is supported by Doppel. In case of technical questions, please contact Doppel support at 
