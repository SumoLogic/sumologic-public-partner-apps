# Cybereason App for Sumo Logic

**This application has been developed and is supported by Cybereason. In case of technical questions, please contact Cybereason support at support@cybereason.com.**

## Product Description: 
### App description: 
The Cybereason app for Sumo Logic enables Security Operations teams to leverage the Cybereason Malop™ to detect and end attacks faster. 


| **Dashboard** | **Description** |
| --- | --- |
| Cybereason Defense Platform | The Dashboard provides an Out Of The Box security overview, enabling Security Operation teams to rapidly detect and end Cyber attacks. |

## Cybereason Page

The Cybereason app for Sumo Logic enables Security Operations teams to leverage the Cybereason Malop™ to detect and end attacks faster.

### Log Types 
The Cybereason App receives authentication logs from the Cybereason [Malop API](https://nest.cybereason.com/documentation/api-documentation/all-versions/retrieve-all-malops-all-types#getmalopsmalware).

### Sample Log Message
```
{"@class":".MalopInboxModel","guid":"1292014293022","status":"Active","displayName":"863af7f5ff3e6f35b349ccccb3ddb7fbbc71b30a","rootCauseElementType":"File","rootCauseElementNamesCount":9,"detectionEngines":["AntiVirus"],"detectionTypes":["Known malware detected by Cybereason Anti-Malware"],"malopDetectionType":"KNOWN_MALWARE","machines":[{"@class":".MachineInboxModel","guid":"280830967.1198775089551518743","displayName":"d3test4","osType":"WINDOWS","connected":true,"isolated":false,"lastConnected":1616692770945}],"users":null,"creationTime":1616680972594,"lastUpdateTime":1616692225596,"labels":[],"iconBase64":null,"priority":null,"decisionStatuses":["Detected"],"severity":"High","malopCloseTime":null,"group":null,"edr":false,"escalated":false}
```
### Query sample 
```
 _sourceCategory="Cybereason"
| json auto
| formatDate(toLong(lastUpdateTime), "yyyy-MM-dd:HH-MM") as %"Last Update Date"
| %machines[0].displayname as %"Affected Machine"
| displayname as %"Malop Name"
| malopdetectiontype as %"Detection Type"
| rootcauseelementtype as %"Root Cause Element"
| status as %"Status"
| count by _raw, %"Malop Name" ,%"Last Update Date" , %"Affected Machine", %"Detection Type", %"Root Cause Element",%"Status"
| fields -_count,_raw
```
## Collect Logs for Cybereason
Log collection for Cybereason uses the cloud-to-cloud Cybereason source documented [here](https://help.sumologic.com/Beta/Cloud-to-Cloud_Integration_Framework/Cybereason_Source).

## Install the Cybereason App and View the Dashboards
This page has instructions for installing the Sumo App for Cybereason and descriptions of each of the app dashboards. 

### Cybereason Defense Platform Dashboard
Using the Cybereason integration with Sumo Logic, security operations can combine this context-rich endpoint insight with other security data to extend the attack story, empowering security teams to rapidly understand the scope of threats and respond effectively.
Security teams can now leverage the Cybereason app in order to:

* Automate the import and update of Cybereason MALOP ™  endpoint security data into Sumo Logic
* Deliver intelligent security insights based on triage-driven dashboards
* Identify key targeted assets within the enterprise
* Provide a summarized workflow overview, enabling security analysts to manage enterprise security practices from a single pane of glass

### Screenshot
![Alt text](resources/screenshots/Cybereason_Sumologic_Dashboard.png?raw=true "screenshot")
