# Lucidum

 Lucidum is the asset discovery platform that eliminates blind spots across cloud, security, and IT operations. Refer : https://lucidum.io/

# Lucidum App for Sumo Logic

- [Introduction](#introduction)
- [Sample Log Message](#sample-log-message)
- [Query Sample](#query-sample)
- [Collect Logs for Lucidum](#collect-logs-for-lucidum)
- [Install the Lucidum App and View the Dashboards](#install-the-lucidum-app-and-view-the-dashboards)
- [Screenshots](#screenshots)

## Introduction
The Lucidum app for Sumo Logic eliminates blind spots across cloud, security, and IT operations. It gives information about assets, data sources, services, locations, risk factors and ports.

| **Dashboard** | **Description** |
| --- | --- |
| Lucidum Dashboard | The dashboard provides information about assets, data sources, services, locations, risk factors and ports |


## Sample Log Message
```
{"Asset": "I-P5CHHBU6X2MP2R4O4", "Data Sources": ["aws_inventory"], "Department": null, "External Ports": null, "External Services": null, "First Time Seen": 1685641315.0, "IP Address": ["194.163.7.197"], "Last Time Seen": 1723112515.0, "Location": "Virginia", "MAC Address": ["9c:68:30:41:ac:0c"], "Manager": null, "OS and Version": "Ubuntu 16.04.7", "Ports": ["22"], "Risk Factors": ["Potential Unmanaged Asset", "Asset Not Encrypted", "Not Protected by Host IDS", "Not Protected by Network IDS"], "Serial Number": null, "Services": ["ssh"], "User Name": null}
```
##  Query sample 
```
_sourceCategory = Lucidum 
| parse regex field=Services"(?:\[\"|,\"|^\")(?<service>[^\"]+)" multi 
| count_distinct(asset) group by service

```
## Collect Logs for Lucidum

Use the Collection page to manage all of your Collectors and Sources. To access the Collection page, go to Manage Data > Collection > Collection.
- In Sumo Logic, configure a [hosted collector](https://help.sumologic.com/03Send-Data/Hosted-Collectors)
    and associate an [HTTP Logs and Metrics Source](https://help.sumologic.com/03Send-Data/Sources/02Sources-for-Hosted-Collectors/HTTP-Source#configure-an-http%C2%A0logs-and-metrics-source) with the collector. Copy the HTTP source URL.
- For Lucidum Setup,
    - create a new integration and use the HTTP source URL for the webhook_url:
    ![Alt text](resources/docs/Lucidum_Integration.png?raw=true)
    - create new scheduled action using the Sumo Integration:
        - choose schedule, filter, output fields, Sumo configuration name and the Save and Run.
        ![Alt text](resources/docs/SetAction1.png?raw=true)
        ![Alt text](resources/docs/SetAction2.png?raw=true)
        ![Alt text](resources/docs/SetAction3.png?raw=true)
        ![Alt text](resources/docs/SetAction4.png?raw=true)


## Install the Lucidum App and View the Dashboards
Use the instruction from this doc (https://help.sumologic.com/05Search/Library/Apps-in-Sumo-Logic/Install-Apps-from-the-Library) to install the Lucidum App.

### Lucidum Dashboard
The dashboard provides information about assets, data sources, services, locations, risk factors and ports.

### Screenshots
![Alt text](resources/screenshots/Lucidum_Dashboard.png?raw=true)

### Support

This application has been developed and is supported by Lucidum. In case of technical questions, please contact Lucidum support at info@lucidum.io
