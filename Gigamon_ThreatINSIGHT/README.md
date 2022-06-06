# Gigamon_ThreatINSIGHT

MetaStream with signals provide raw events, detections, observations, and ATR-defined aggregations  from ThreatINSIGHT in an AWS S3 bucket provisioned by Gigamon. This is critical when data is required for further analysis with other datasets for correlation purposes via other security tools in an ecosystem, most commonly being a Security Information and Event management (SIEM). All data and context can be seen in the SOC’s main platform of choice to make quick decisions with less pivots. If the security analyst is only interested in detections and/or observations, or aggregations, that data may be retrieved  from using MetaStream Signals. MetaStream with Signals provide access to traffic metadata directly from sensors deployed as well as other alert data seen in ThreatINSIGHT. This feature allows access to an AWS S3 bucket that contains all events, detections, and observations, and ATR-defined event aggregations associated with the account.

## Gigamon_ThreatINSIGHT app for Sumo Logic

- [Introduction](#introduction)
- [Sample Log Message](#sample-log-message)
- [Query Sample](#query-sample)
- [Screenshots](#screenshots)

## Introduction

MetaStream with Signals provide access to traffic metadata directly from sensors deployed as well as other alert data seen in ThreatINSIGHT. This feature allows access to an AWS S3 bucket that contains all

| Dashboard                                       | Description                                                       |
| ----------------------------------------------- | ----------------------------------------------------------------- |
| [Gigamon HAWK Deep Observability Pipeline - GTI - Overview]       | Gigamon HAWK Threat Intelligence dashboard provides overview of security posture. |

## Sample Log Message

```json
{
"vendor":"Gigamon",
"product":"GTI",
"signal_version":"1",
"event_type":"detection",
"subject":"none", "timestamp":"2022-04-26T08:53:33.132Z", "device_ip":"192.168.0.100", "name":"Cryptocurrency Mining Client Check-in", "category":"PUA:Unauthorized Resource Use", "severity":"moderate",
"confidence":"moderate",
"sensor_id":"gdm2",
"muted":false,
"muted_rule":false, "rule_uuid":"bfcb4b76-96ef-4b33-9812-58158c871f99", "muted_comment":"", "first_seen":"2022-04-26T08:36:19.792Z", "last_seen":"2022-04-26T08:36:19.792Z", "created":"2022-04-26T08:53:33.132Z", "updated":"2022-04-26T08:53:33.132Z", "uuid":"f58a4517-4dce-40cd-89b5-8dfe7abec2d4", "status":"active",
"indicators"::[
{ "field":"dst.ip",
  "values":["176.9.53.68"]
}
],
"customer_id":"gdm", "primary_pdns_hostnames":[
"enterprise-web.acme.corp"
], "primary_dhcp_machost_pairs":[
"00:0c:29:ef:26:54/enterprise-web"
] }
```

## Query Sample

This is an example of a simple query that returns the number of inbound flags:

```text
_sourceCategory="GTI/Signals"
_sourceCategory="GTI/Signals" | count
_sourceCategory="GTI/Signals"
| json auto keys "event_type" | fields event_type | count event_type | top 20 event_type by _count | compare with timeshift 1d
_sourceCategory="GTI/Signals"
| where event_type = "observation"
| json auto keys "event_type", "subject", "src_ip", "title", "confidence", "observation_uuid"
| fields event_type, subject, src_ip, title, confidence, observation_uuid | count by title | sort by _count
_sourceCategory="GTI/Signals"
| json auto keys "event_type" | fields event_type | count event_type | top 20 event_type by _count
```

## Collect Logs for Gigamon_ThreatINSIGHT

Collection process overview:
1. In Sumo Logic select Manage Data > Collection > Collection.
2. On the Collectors page, click Add Source next to a Hosted Collector, either an existing Hosted
Collector, or one you have created for this purpose.
3. Select Amazon S3.
4. Enter a Name for the new Source (e.g., GTI Signals).
5. Select US West (Oregon) as S3 Region.
6. Select No for Use AWS versioned APIs?
7. For Bucket Name, enter the exact name retrieved from MetaStream Export to AWS S3
configuration (e.g., gigamon-insight-event-metastream).
8. For Path Expression, enter the retrieved MetaStream Prefix followed by signals/* for GTI
Signals (e.g., v1/customer/cust-xxx/signals/*).
9. For Collection should begin, choose, or enter how far back you’d like to begin collecting historical
signals (e.g., 24 hours ago).
10. For Source Category, enter any string to tag the output collected from this Source (e.g.,
GTI/Signals).
![Alt text](resources/screenshots/step_10.png?raw=true)
11. For AWS Access, select Key access as Access Method and enter the Access Key ID and Secret Access Key retrieved from MetaStream Export to AWS S3.
![Alt text](resources/screenshots/step_11.png?raw=true)
12. For Log File Discovery, set Scan Interval as Automatic to scan MetaStream S3 bucket for new data.
![Alt text](resources/screenshots/step_12.png?raw=true)
13. In Advanced Options for Logs, use the defaults (Enable Timestamp Parsing and Enable Multiline Processing).
![Alt text](resources/screenshots/step_13.png?raw=true)
14. When you are finished configuring the Source, click Save.

## Install the Sumo Logic App

Use the instruction from this doc (https://help.sumologic.com/05Search/Library/Apps-in-Sumo-Logic/Install-Apps-from-the-Library) to install the Gigamon_HAWK App.

## Screenshots

### Gigamon HAWK Deep Observability Pipeline - GTI - Overview Dashboard

Gigamon ThreatINSIGHT provides access to observations and signals from security perspective.

Gigamon HAWK Threat Intelligence dashboard provides overview of security posture.

![Alt text](resources/screenshots/Gigamon-GTI-Screenshot.png?raw=true)

## Support

This application has been developed and is supported by Gigamon. In case of technical questions, please contact Gigamon support at https://www.gigamon.com/support/support-and-services/contact-support.html