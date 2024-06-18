## Endace App for Sumo Logic

- [Introduction](#introduction)
- [How to use the App](#How-to-use-the-App)
- [Query Sample](#query-sample)
- [Install the Sumo Logic App](#install-the-sumo-logic-app)
- [How to collect logs](#how-to-collect-logs)
- [Screenshots](#screenshots)

## Introduction 

Bring clarity to every incident, alert, or issue with Endace packet capture evidence integrated directly into the Sumo Logic platform. Endace delivers scalable, always-on packet capture in on-premise and hybrid cloud environments for definitive network visibility.  Packets are the ultimate tamperproof source of truth that accelerates incident response for security threats, outages, and performance issues. This integration provides your operations team with fast access to the network packets (pcap) related to any incident or threat for rapid and precise incident response. 

## How to use the App

The Endace App includes premade dashboards for logs such as Zeek, Suricata, Cisco ASA, Cisco Firepower and Palo Alto Networks, which include a Pivot-to-Vision link to connect you to your EndaceProbe for further investigation. You will need to download and run the python script from github, which will create the Field Extraction Rules to automatically extract the needed fields and create the Pivot-to-Vision link.

The Python script will create 5 different FERs: 

- Endace_cisco_firepower
- Endace_ciscoasa
- Endace_Palo
- Endace_Suricata
- Endace_Zeek

Python script: [Python script](./sumologic.py)

## Query Sample

Example of a simple query for Suricata and Zeek traffic.

```text
_sourceCategory="suricata"
``` 

```text
_sourceCategory="zeek"
``` 

## How to collect logs

Install a collector by going to "Manage Data" -> "Collection" -> "OpenTelementry Collection" -> "Add Collector" -> "Linux" and follow the steps there. For more information, refer the [Install OpenTelemetry Collector
](https://help.sumologic.com/docs/send-data/opentelemetry-collector/install-collector/) docs.

**Zeek setup**:

Add `/etc/otelcol-sumo/conf.d/zeek.yaml` file with the following contents

```yaml
receivers:
  filelog/custom_files:
    include:
      - /opt/zeek/logs/current/smb_files.log
    include_file_name: true
    include_file_path_resolved: true
    storage: file_storage

processors:
  groupbyattrs/custom_files:
    keys:
      - log.file.path_resolved
  resource/custom_files:
    attributes:
      - key: _sourceCategory
        value: zeek
        action: insert
      - key: sumo.datasource
        value: linux
        action: insert

service:
  pipelines:
    logs/custom_files:
      receivers:
        - filelog/custom_files
      processors:
        - memory_limiter
        - groupbyattrs/custom_files
        - resource/custom_files
        - resourcedetection/system
        - batch
      exporters:
        - sumologic
```

**Suricata setup**:

Add `/etc/otelcol-sumo/conf.d/suricata.yaml` file with the following contents

```yaml
receivers:
  filelog/custom_files:
    include:
      - /var/log/suricata/eve.json
    include_file_name: true
    include_file_path_resolved: true
    storage: file_storage

processors:
  groupbyattrs/custom_files:
    keys:
      - log.file.path_resolved
  resource/custom_files:
    attributes:
      - key: _sourceCategory
        value: suricata
        action: insert
      - key: sumo.datasource
        value: linux
        action: insert

service:
  pipelines:
    logs/custom_files:
      receivers:
        - filelog/custom_files
      processors:
        - memory_limiter
        - groupbyattrs/custom_files
        - resource/custom_files
        - resourcedetection/system
        - batch
      exporters:
        - sumologic
```

**Cisco ASA / Cisco Firepower / Palo Alto Networks**:

Add `/etc/otelcol-sumo/conf.d/syslog.yaml` file with the following contents. Keep in mind that these logs are being forwarded to `/var/log/messages` via syslog.

```yaml
receivers:
  filelog/custom_files:
    include:
      - /var/log/messages
    include_file_name: true
    include_file_path_resolved: true
    storage: file_storage

processors:
  groupbyattrs/custom_files:
    keys:
      - log.file.path_resolved
  resource/custom_files:
    attributes:
      - key: _sourceCategory
        value: messages
        action: insert
      - key: sumo.datasource
        value: linux
        action: insert

service:
  pipelines:
    logs/custom_files:
      receivers:
        - filelog/custom_files
      processors:
        - memory_limiter
        - groupbyattrs/custom_files
        - resource/custom_files
        - resourcedetection/system
        - batch
      exporters:
        - sumologic
```

## Install the Sumo Logic App

Use the instruction from this [doc](https://help.sumologic.com/docs/get-started/apps-integrations/#install-apps-from-the-library) to install the Endace App.


## Screenshots


![Alt text](resources/screenshots/Cisco_firepower.PNG?raw=true)
<br>
<br>

<br>

![Alt text](resources/screenshots/CiscoASA.PNG?raw=true)
<br>
<br>

<br>

![Alt text](resources/screenshots/Palo_Alto_Networks.PNG?raw=true)
<br>
<br>

<br>

![Alt text](resources/screenshots/Suricata.PNG?raw=true)
<br>
<br>

<br>

![Alt text](resources/screenshots/Zeek.PNG?raw=true)
<br>
<br>

<br>

![Alt text](resources/screenshots/EndaceProbe_sumologic.PNG?raw=true)
