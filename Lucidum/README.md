# Lucidum App for Sumo Logic

**This application has been developed and is supported by Lucidum. In case of technical questions, please contact Lucidum support at info@lucidum.io.**

## Product Description: 
### App description: 
The Lucidum app for Sumo Logic eliminates blind spots across cloud, security, and IT operations. It gives information about assets, data sources, services, locations, risk factors and ports. 


| **Dashboard** | **Description** |
| --- | --- |
| Lucidum Dashboard | The dashboard provides information about assets, data sources, services, locations, risk factors and ports |

## Lucidum Page

The Lucidum app for Sumo Logic eliminates blind spots across cloud, security, and IT operations. Refer : https://lucidum.io/

### Log Types 

### Sample Log Message
```
{"Asset": "I-P5CHHBU6X2MP2R4O4", "Data Sources": ["aws_inventory"], "Department": null, "External Ports": null, "External Services": null, "First Time Seen": 1685641315.0, "IP Address": ["194.163.7.197"], "Last Time Seen": 1723112515.0, "Location": "Virginia", "MAC Address": ["9c:68:30:41:ac:0c"], "Manager": null, "OS and Version": "Ubuntu 16.04.7", "Ports": ["22"], "Risk Factors": ["Potential Unmanaged Asset", "Asset Not Encrypted", "Not Protected by Host IDS", "Not Protected by Network IDS"], "Serial Number": null, "Services": ["ssh"], "User Name": null}
```
### Query sample 
```
_sourceCategory = Lucidum 
| parse regex field=Services"(?:\[\"|,\"|^\")(?<service>[^\"]+)" multi 
| count_distinct(asset) group by service

```
## Collect Logs for Lucidum

## Install the Lucidum App and View the Dashboards
This page has instructions for installing the Sumo App for Lucidum and descriptions of each of the app dashboards. 

### Lucidum Dashboard
The dashboard provides information about assets, data sources, services, locations, risk factors and ports

### Screenshot
![Alt text](resources/screenshots/Lucidum_Dashboard.png?raw=true "screenshot")
