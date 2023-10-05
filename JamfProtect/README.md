
# Jamf Protect App for Sumo Logic

**This application has been developed and is supported by Jamf. In case of technical questions, please contact support@jamf.com.**

## Product Description: 

The Jamf Protect App empowers security teams with in-depth visibility into Mac security events, providing integrated visualization for enriched investigation into macOS threat alerting with tuned endpoint telemetry data streams. This app supports data streams from the macOS Security & Jamf Security Cloud portals, resulting in a single collection point for all endpoint and network based events occurring across your Apple device fleet. With the Jamf Protect App, Sumo Logic users can easily integrate their Apple security data, gain valuable insights into their Apple security posture, and quickly respond to security incidents.

| Dashboard                                    | Description                                   |
| -------------------------------------------- | --------------------------------------------- |
| Jamf Protect - Alerts Overview| Overview of events from Alerts & Unified Logs|
| Jamf Protect - Telemetry Overview| Overview of events from Jamf Protect Telemetry|
| Jamf Security Cloud - Threat Stream Overview| Overview of events from Network Threat Stream|

### Log Types

The Jamf Protect App supports the following products:

- Jamf Protect (Alerts and Telemetry)
- Jamf Protect Offline (Telemetry Only)
- Jamf Security Cloud (Threat Stream)

### Sample Log Message

#### Jamf Protect - Alerts
```
{"input":{"match":{"tags":[],"uuid":"9A041872-9C41-4374-BCC1-4E13DA907E33","facts":[{"severity":1,"human":"A process has been denied execution.","tags":["ThreatMatchExecEvent"],"actions":[{"name":"DisplayMessage","parameters":{"message":"This software has been identified as a malicious or potentially unwanted program. It has been blocked, moved to quarantine, and reported to your IT Administrator or Security Team.","title":"eicar Has Been Blocked."}},{"name":"Prevented"},{"name":"Report"}],"version":20328,"uuid":"F7B1F185-4B43-4F4B-85C2-8115DDAAEF5E","name":"ThreatMatchExecEvent","context":[]}],"custom":false,"actions":[{"parameters":{"title":"eicar Has Been Blocked.","message":"This software has been identified as a malicious or potentially unwanted program. It has been blocked, moved to quarantine, and reported to your IT Administrator or Security Team."},"name":"DisplayMessage"},{"name":"Prevented"},{"name":"Report"}],"context":[],"severity":1,"event":{"matchValue":"eicar_a","process":{"uuid":"1A2824E6-E148-4158-8A52-37938E49A5FC","ruid":501,"args":["sh","./eicar"],"uid":501,"pgid":77921,"gid":20,"tty":"/dev/ttys000","processFlags":[],"name":"sh","path":"/bin/sh","pid":77921,"responsiblePID":2090,"processType":"GPSystemObject","rgid":20,"signingInfo":{"statusMessage":"No error.","cdhash":"hRhDiVfW68LMCYeacFnpIICZh58=","entitlements":[],"teamid":"","informationStage":"extended","signerType":0,"appid":"com.apple.sh","authorities":["Software Signing","Apple Code Signing Certification Authority","Apple Root CA"],"status":0},"ppid":77733,"originalParentPID":77733,"startTimestamp":1695907818},"uuid":"2CCF4D00-4D0F-43E4-90BE-73D56F820F3E","scriptPath":"/Users/first.last/Desktop/eicar","timestamp":1695907818.2199202,"blocked":true,"matchType":"Threat Signature"}},"host":{"serial":"","os":"Version 14.0 (Build 23A5337a)","ips":["192.168.4.59"],"hostname":"hostname","provisioningUDID":"00008103-000C38E93488801E","protectVersion":"5.0.2.2"},"eventType":"GPThreatMatchExecEvent","related":{"processes":[{"originalParentPID":77733,"startTimestamp":1695907818,"args":["sh","./eicar"],"pgid":77921,"pid":77921,"name":"sh","ruid":501,"gid":20,"rgid":20,"processType":"GPSystemObject","processFlags":[],"ppid":77733,"signingInfo":{"teamid":"","authorities":["Software Signing","Apple Code Signing Certification Authority","Apple Root CA"],"signerType":0,"cdhash":"hRhDiVfW68LMCYeacFnpIICZh58=","appid":"com.apple.sh","entitlements":[],"informationStage":"extended","statusMessage":"No error.","status":0},"uuid":"1A2824E6-E148-4158-8A52-37938E49A5FC","path":"/bin/sh","tty":"/dev/ttys000","responsiblePID":2090,"uid":501},{"pgid":77733,"uuid":"58062289-5E9A-4C58-AB20-29716EAB566D","path":"/bin/zsh","processType":"GPSystemObject","pid":77733,"uid":501,"args":["/bin/zsh","-zsh"],"responsiblePID":2090,"ruid":501,"gid":20,"name":"zsh","startTimestamp":1695907101,"signingInfo":{"authorities":["Software Signing","Apple Code Signing Certification Authority","Apple Root CA"],"statusMessage":"No error.","informationStage":"extended","cdhash":"f8w59TUpUrUhesGyuRBvXldP3Q0=","status":0,"appid":"com.apple.zsh","signerType":0,"teamid":"","entitlements":[]},"rgid":20,"processFlags":[]},{"pid":2090,"uid":501,"args":["/System/Applications/Utilities/Terminal.app/Contents/MacOS/Terminal"],"ruid":501,"processType":"GPSystemObject","responsiblePID":2090,"signingInfo":{"signerType":0,"informationStage":"extended","status":0,"appid":"com.apple.Terminal","teamid":"","cdhash":"jJIKbr3z+HjzOXEco2b2NoJtcRM=","authorities":["Software Signing","Apple Code Signing Certification Authority","Apple Root CA"],"statusMessage":"No error.","entitlements":[]},"gid":20,"rgid":20,"name":"Terminal","appPath":"/System/Applications/Utilities/Terminal.app","pgid":2090,"processFlags":[],"uuid":"D2DEFF02-E3C9-4481-A52E-B3D5A1898BD7","path":"/System/Applications/Utilities/Terminal.app/Contents/MacOS/Terminal","startTimestamp":1695399648}],"binaries":[{"signingInfo":{"signerType":0,"cdhash":"hRhDiVfW68LMCYeacFnpIICZh58=","status":0,"statusMessage":"No error.","teamid":"","informationStage":"extended","entitlements":[],"appid":"com.apple.sh","authorities":["Software Signing","Apple Code Signing Certification Authority","Apple Root CA"]},"path":"/bin/sh","size":134000,"uid":0,"inode":1152921500312492000,"fsid":16777229,"sha1hex":"cd10d9e4f1a2f87a53e4ff57f5e7dabd09a007ac","xattrs":[],"isDirectory":false,"isAppBundle":false,"modified":1693208270,"sha256hex":"fb437272791dd04a4e41a5dde931b31937e2fb959f0d02759d631addea0fcae3","gid":0,"accessed":1693208270,"changed":1693208270,"created":1693208270,"isDownload":false,"mode":33261,"isScreenShot":false,"objectType":"GPSystemObject"},{"created":1693208270,"gid":0,"isAppBundle":false,"signingInfo":{"signerType":0,"cdhash":"f8w59TUpUrUhesGyuRBvXldP3Q0=","appid":"com.apple.zsh","statusMessage":"No error.","status":0,"authorities":["Software Signing","Apple Code Signing Certification Authority","Apple Root CA"],"entitlements":[],"informationStage":"extended","teamid":""},"xattrs":[],"inode":1152921500312492000,"path":"/bin/zsh","modified":1693208270,"sha256hex":"1ff9d31ee0fc4f9a107145c3baf01a344c08af256b2fb6b8799d0eb3f2ab5e62","isDownload":false,"isDirectory":false,"size":1377584,"isScreenShot":false,"mode":33261,"changed":1693208270,"sha1hex":"37b4cae25e4c03dbe749ea20a2013bdbcf4894f2","uid":0,"objectType":"GPSystemObject","fsid":16777229,"accessed":1693208270},{"objectType":"GPSystemObject","fsid":16777229,"inode":1152921500311913100,"modified":1693208270,"mode":33261,"isScreenShot":false,"accessed":1693208270,"sha1hex":"d6952ac55751a627e0beca8ad176b29bd843eed6","isDownload":false,"changed":1693208270,"uid":0,"size":2222656,"sha256hex":"6ca20ffc43d281432dc3aade2c68e4ab174fbe10fa07ae35919a5e01e28bba86","path":"/System/Applications/Utilities/Terminal.app/Contents/MacOS/Terminal","isAppBundle":false,"created":1693208270,"xattrs":[],"gid":0,"isDirectory":false,"signingInfo":{"entitlements":[],"status":0,"cdhash":"jJIKbr3z+HjzOXEco2b2NoJtcRM=","informationStage":"extended","authorities":["Software Signing","Apple Code Signing Certification Authority","Apple Root CA"],"teamid":"","signerType":0,"statusMessage":"No error.","appid":"com.apple.Terminal"}}],"users":[{"uid":0,"name":"root","uuid":"0"},{"name":"first.last","uuid":"1f5","uid":501}],"groups":[{"gid":0,"name":"wheel","uuid":"0"},{"name":"staff","uuid":"14","gid":20}],"files":[]}},"caid":"","certid":""}
```

#### Jamf Protect - Telemetry

See [Jamf Protect Documentation](https://learn.jamf.com/bundle/jamf-protect-documentation/page/Telemetry.html)

#### Jamf Security Cloud - Threat Stream
```
{"event":{"metadata":{"product":"Threat Events Stream","schemaVersion":"1.0","vendor":"Jamf"},"timestamp":"2023-09-28T15:00:45.276Z","alertId":"","account":{"customerId":"","parentId":"","name":"Jamf Test - Jamf"},"device":{"deviceId":"","os":"MAC_OS 14.0.0","deviceName":"Mac (14.0.0)","userDeviceName":"hostnamw","externalId":""},"eventType":{"id":"303","description":"Risky Host/Domain - Malware","name":"ACCESS_BAD_HOST"},"app":{},"destination":{"ip":"89.238.73.97","name":"www.eicar.org"},"source":{},"location":"GB","severity":8,"user":{"email":"example@jamf.com","name":"First Last"},"eventUrl":"https://radar.wandera.com/security/events/detail/uuid.ACCESS_BAD_HOST?createdUtcMs=1695913245276","action":"Blocked"}}
```

### Query Sample 

#### Jamf Protect - Alerts
```
_sourceCategory=protect caid
| json field=_raw "input.host.hostname","input.match.facts[0].name","input.match.facts[0].human", "input.match.severity" as hostname, detection_name, description, severity
| where severity > 0
| fields hostname, detection_name, description, severity
```

#### Jamf Protect - Telemetry
```
_sourceCategory=protect !caid
| json "header.event_name", "return.description", "host_info.host_name", "subject.terminal_id.ip_address", "subject.effective_user_name", "exec_args.args_compiled" as event_name, return, hostname, ipaddress, user, args
| fields event_name, return, hostname, ipaddress, user, args
```

#### Jamf Security Cloud - Threat Stream
```
_sourceCategory=jsc "Threat Events Stream"
| dedup event.timestamp
| json field=_raw "event.metadata.product", "event.eventType.description", "event.device.userDeviceName", "event.destination.name", "event.destination.ip" as product, eventType, hostname, domain, ipaddress
| where eventType contains "Risky Host"
| fields hostname, eventType, domain, ipaddress
```

## Collect Logs for Jamf Protect

### Collection Step One: Create Sumo Logic HTTP Logs & Metrics Source

Follow these steps to set up an HTTP Logs & Metrics Source to collect event logs from Jamf Protect and Jamf Security Cloud.

**Jamf Protect & Jamf Protect Offline Mode**

1. In Sumo Logic select **Manage Data -> Collection**
2. Click **Add Collector**
3. Click **Hosted Collector**
    - **Name:** Jamf Protect
    - Click **Save**
4. Under the added collector, click **Add Source**
5. Search and click on **HTTP Logs & Metrics**
    - **Name:** jamf_protect 
    - **Source Category:** prod/jamf/protect
    - Click **Save**
6. Click *Copy* and set aside the HTTP Source Address

**Jamf Security Cloud - Network Traffic/Threat Feeds**

1. In Sumo Logic select **Manage Data -> Collection**
2. Click **Add Collector**
3. Click **Hosted Collector**
    - **Name:** Jamf Security Cloud
    - Click **Save**
4. Under the added collector, click **Add Source**
5. Search and click on **HTTP Logs & Metrics**
    - **Name:** jamf_security_cloud
    - **Source Category:** prod/jamf/jsc
    - Click **Save**

### Collection Step Two: Configure Jamf Protect to send alerts and event logs to Sumo Logic

**Jamf Protect**

[Creating an Action Configuration](https://learn.jamf.com/bundle/jamf-protect-documentation/page/Creating_an_Action_Configuration.html#ID-00003cc5)


1. In Jamf Protect, Click **Actions**
2. Click **Create Actions**
3. **Name:** Sumo Logic
4. Click **+ Remote Alert Collection Endpoints**
    - **URL:** Generated HTTP Source Address
    - **Min Severity & Max Severity:** Set by you
5. Click **+ Unified Logs Collection Endpoints**
    - **URL:** Generated HTTP Source Address
6. Click **+ Telemetry Collection Endpoints **
    - **URL:** Generated HTTP Source Address
7. Click **Plans**
    - Existing Plan
        - Click **Edit**
        - Select **Sumo Logic** from the Action Configuration pop-up menu
        - Click **Save**
    - New Plan, see [Creating a Plan](https://learn.jamf.com/bundle/jamf-protect-documentation/page/Creating_a_Plan.html)
        - Select **Sumo Logic** from the Action Configuration pop-up menu


> Note:
> The same HTTP Source Address can be used for Alerts, Unified Logs, and Telemetry.

**Jamf Security Cloud**

[Configuring the Data Stream to send HTTP Events](https://learn.jamf.com/bundle/jamf-security-documentation/page/Configuring_the_Network_Threat_Events_Stream_to_send_HTTP_Events.html)


1. Click **Integrations**
2. Click **Data Streams**
3. Click **New Configuration**
4. Select **Threat Events** or **Network Traffic**
    - Select **Generic HTTP**
    - Click **Continue**
    - **Protocol:** HTTPS
    - **Server Hostname/IP:** endpoint4.collection.sumologic.com
    - **Port:** 443
    - **Endpoint:** receiver/v1/http/<generated_url>

## Install the Jamf Protect App and View the Dashboards

Use the instruction from this [doc](https://help.sumologic.com/05Search/Library/Apps-in-Sumo-Logic/Install-Apps-from-the-Library) to install the Jamf Protect App.


## Screenshots

### Jamf Protect - Alerts Overview

This dashboard provides an overview of Alerts and Unified Logs from Jamf Protect.

> Note:
> In order to use the XProtect Remediator Scan Activity panel you must add the [XProtect Remediator Scan Activity](https://github.com/jamf/jamfprotect/blob/main/unified_log_filters/xprotect_remediator_scan_activity.yaml) unified log filter to Jamf Protect.

![Alt text](resources/screenshots/alerts_overview.png?raw=true "screenshot")

### Jamf Protect - Telemetry Overview

This dashboard provides an overview of Telemetry data from Jamf Protect.

![Alt text](resources/screenshots/telemetry_overview.png?raw=true "screenshot")

### Jamf Security Cloud - Threat Stream 

This dashboard provides an overview of network events from Jamf Security Cloud.

![Alt text](resources/screenshots/jsc_overview.png?raw=true "screenshot")