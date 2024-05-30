
# Dataminr Pulse for Sumo Logic

This application has been developed and is supported by Dataminr. In case of technical questions, please contact Dataminr support at support@dataminr.com.

## Product Description:

### App Description:
Dataminr Pulse's AI-powered real-time intelligence brings faster detection and response into Sumo Logic Cloud Security Analytics. Learn about threats as they unfold to prioritize and manage risk, and protect your physical and digital assets in real time. Dataminr Pulse for Cyber Risk easily fits into your Sumo Logic Cloud Security Analytics workflows, enabling rapid identification and mitigation of emerging threats so you can deliver faster time to detection and response. The global leader in AI for risk detection since 2009, Dataminr Pulse is relied on by two-thirds of Fortune 100 companies to inform their physical, cyber, and converged security operations.

### Log Types
Dataminr Pulse receives data from the Dataminr webhook platform.

### Sample Log Message
```json title="Sample Log"
{
  "index": "525813854046306381458-1697110156090-1",
  "timestamp": 1697110161929,
  "relatedAlerts": [],
  "volume": 0,
  "_embedded": {
    "labels": [
      {
        "id": "fa98891f-ce7b-46f7-a953-e7075e9ce979",
        "type": "CYBER",
        "data": {
          "@type": "type.googleapis.com/dm_content.cyber.v2.Cyber",
          "vulnerabilities": [],
          "URLs": [
            "FL1-111-169-53-37.aic.mesh.ad.jp"
          ],
          "addresses": [
            {
              "ip": "111.169.53.37",
              "port": 5900,
              "version": ""
            }
          ],
          "asns": [
            "AS2518"
          ],
          "orgs": [
            "BIGLOBE"
          ],
          "hashes": [],
          "products": [
            "VNC"
          ],
          "malwares": [],
          "threats": [],
          "asOrgs": [
            {
              "asn": "AS2518",
              "asOrg": "BIGLOBE"
            }
          ],
          "hashValues": []
        }
      }
    ],
    "targets": []
  },
  "location": {
    "coordinates": [
      35.18147,
      136.90641
    ],
    "latitude": 35.18147,
    "longitude": 136.90641,
    "name": "Nagoya, Japan",
    "places": [
      "fe8bca108711a8e11645a7637d1aa8ed",
      "ccda333b30274c9fb199f42c66ec1103",
      "48893b2e5f7699e6a7cee02e88e50d99",
      "132542e4d8cc46b488224e9c20f40859",
      "b21d39e2f888e5179e45bb91a5b6aebb"
    ],
    "probability": 0,
    "radius": 0.1
  },
  "metadata": {},
  "watchlistsMatchedByType": [
    {
      "id": "3999781",
      "type": "topics",
      "name": "Cyber Alerts",
      "externalTopicIds": [
        "961953"
      ],
      "userProperties": {
        "uiListType": "CYBER",
        "omnilist": "true"
      }
    }
  ],
  "topics": [
    {
      "name": "BIGLOBE Inc.",
      "topicType": "company",
      "id": "ywmgww5ibebrbnxid7kc6kve4a",
      "idStr": "ywmgww5ibebrbnxid7kc6kve4a",
      "retired": false
    }
  ],
  "categories": [
    {
      "name": "Remote Access and Management Systems",
      "topicType": "category",
      "id": "961953",
      "idStr": "961953",
      "path": "/TOPIC/EXT/CS/961953",
      "retired": false,
      "requested": "true"
    },
    {
      "name": "Cybersecurity - Threats & Vulnerabilities",
      "topicType": "category",
      "id": "853086",
      "idStr": "853086",
      "path": "/TOPIC/EXT/CS/853086",
      "retired": false,
      "requested": "false"
    },
    {
      "name": "Cybersecurity",
      "topicType": "category",
      "id": "124022",
      "idStr": "124022",
      "path": "/TOPIC/EXT/CS/124022",
      "retired": false,
      "requested": "false"
    }
  ],
  "sectors": [],
  "publisherCategory": {
    "id": "chatter",
    "name": "Chatter"
  },
  "expandAlertUrl": "https://app.dataminr.com/#alertDetail/5/525813854046306381458-1697110156090-1",
  "headline": "BIGLOBE IP 111.169.53.37 has VNC running on open port 5900: Sensor via Shodan.",
  "availableRelatedAlerts": 0,
  "odsStatus": {
    "type": "Shodan",
    "timestamp": 1697110156090,
    "languages": [],
    "source": {
      "id": "",
      "channels": [
        "sensor"
      ],
      "id_str": ""
    },
    "link": "https://www.shodan.io/host/1873360165",
    "media": [],
    "extraData": {
      "displaySourceName": "Shodan"
    }
  },
  "referenceTerms": [
    {
      "term": "remote access systems"
    },
    {
      "term": "port"
    },
    {
      "term": "ip"
    },
    {
      "term": "vnc"
    },
    {
      "term": "sensor"
    },
    {
      "term": "biglobe"
    }
  ],
  "watchlistsMatched": [
    "3999781"
  ],
  "alertType": {
    "id": "alert",
    "name": "Alert"
  },
  "companies": [
    {
      "name": "BIGLOBE Inc.",
      "topicType": "company",
      "id": "ywmgww5ibebrbnxid7kc6kve4a",
      "idStr": "ywmgww5ibebrbnxid7kc6kve4a",
      "retired": false
    }
  ],
  "image_url": null,
  "source_type": [
    "sensor"
  ],
  "source_link": "https://www.shodan.io/host/1873360165"
}

```

### Query Sample
```sql title = "Alerts by Severity"
_sourceCategory="new_security" 
| json "index","odsStatus.source.channels","location.latitude","location.longitude","topics[*].name","categories[*].name","alertType.name","headline","timestamp","watchlistsMatchedByType[*].name","watchlistsMatchedByType[*].userProperties.uiListType","headlineData.via","publisherCategory.name" as alert_id,channel,latitude,longitude,company_list,category_list,severity,caption,event_time,watchlists_name_list,watchlist_cyber_alerts,headline_source,publisher_category nodrop
// topics array of name (topics[*].name) is the list of companies of alerts.
// categories array of name (categories[*].name) is the list of topics of alerts.
| extract field=watchlists_name_list "\"?(?<watchlist_name>[\w\s\,&*.</>!]*)\"?[,\n\]]" multi
| extract field=channel "\"?(?<channel>[\w\s\-&.,]*)\"?[,\n\]]" multi
| extract field=caption "via (?<source>.*)\.$" multi
| where !isNull(channel)
| where !isNull(source)

// global filters
| 0 as priority 
| count by alert_id,severity,priority
| count as frequency by severity,priority
| if(severity="Flash",4,if(severity="Urgent",3,if(severity="Urgent Update",2,if(severity="Alert",1,0)))) as priority

| sort by priority
| fields - priority
```

## Set up Collection

Dataminr Pulse Alerts will be forwarded to the Sumo Logic using the Dataminr Pulse webhook connection method.

Configure log collection for the Dataminr Pulse App using the below steps:

1. Configure a Sumo Logic HTTP [Source](https://help.sumologic.com/docs/send-data/hosted-collectors/http-source/logs-metrics/#configure-an-httplogs-and-metrics-source). The unique endpoint for receiving log and metric data for that source will be generated.
2. Use Sumo Logic endpoint to push the data to Sumo Logic.
3. Configure Webhook Delivery settings in Dataminr webhook platform:
    1. Work with Dataminr Product Owner to get required credentials to call Integration Settings API and list API.
    2. Call List API which gives the watchlists associated to the user accounts.
    3. Call Integration settings API with watchlist Ids and Webhook (Sumologic Endpoint).

## Installing the Dataminr Pulse App

This section demonstrates how to install the Dataminr Pulse App.

Locate and install the app you need from the App Catalog. If you want to see a preview of the dashboards included with the app before installing, click Preview Dashboards.

1. From the App Catalog, search for and select the app.
2. Select the version of the service you're using and click Add to Library. Version selection is applicable only to a few apps currently. For more information, see the [Install the Apps from the Library](https://help.sumologic.com/docs/get-started/apps-integrations#install-apps-from-the-library).
3. To install the app, complete the following fields.
    1. App Name. You can retain the existing name, or enter a name of your choice for the app.
    2. Data Source. Select either of these options for the data source.
        - Choose a Source Category, and select a source category from the list.
        - Choose Enter a Custom Data Filter, and enter a custom source category beginning with an underscore. Example: (_sourceCategory=MyCategory)
        - Advanced. Select the Location in Library (the default is the Personal folder in the library), or click New Folder to add a new folder.
4. Click Add to Library.

Once an app is installed, it will appear in your Personal folder, or other folder that you specified. From here, you can share it with your organization.

Panels will start to fill automatically. It's important to note that each panel slowly fills with data matching the time range query and received since the panel was created. Results won't immediately be available, but with a bit of time, you'll see full graphs and maps.

## Viewing Dataminr Pulse Dashboards

### Dataminr - Alerts Overview Dashboard
The **Dataminr Alerts Dashboard** gives you an at-a-glance view of recent alerts and alerting trends based on the Dataminr watchlists you have configured in the [Dataminr platform](app.dataminr.com).

Use this dashboard to:
1. See the breakdown of Dataminr Pulse alerts based on severity and companies affected.
2. View trends of Dataminr Pulse alerts by topic and subtopic.
3. Understand the location distribution of Dataminr Pulse physical and cyber alerts by geography, with the ability to zoom in for more detailed views.
4. Analyze the details of the latest Dataminr Pulse alerts.

![Alt text](resources/screenshots/Dataminr-Alerts-Overview.png?raw=true)

### Dataminr - Cyber Threat Landscape Dashboard
The **Cyber Threat Landscape** Dashboard provides a breakdown of Dataminr Pulse cyber threat alerts  into topics and subtopics.

Use this dashboard to:
1. See the overall number of alerts and daily trends for threat actor, cyber attack, data breach, and vulnerability topic areas.
2. Understand the breakdown of each major topic by subtopic, such as Threat Actor subtopics of Hacktivists, Ransomware Gangs, and Advanced Persistent Threats (APTs).
3. View all of the alerts by major topic, and easily see details of those alerts in the Dataminr Pulse platform.

![Alt text](resources/screenshots/Dataminr-Cyber-Threat-Landscape.png?raw=true)

### Dataminr - Alerts Drilldown Dashboard
The **Dataminr Alerts Drilldown** Dashboard gives you convenient tools to analyze threats in more detail, and learn what IOCs are trending.

Use this dashboard to:

1. Filter alerts based on multiple dimensions including individual Dataminr Pulse watchlists, alert source, company name, and more.
2. Understand distribution of alert sources based on your filtered selection.
3. Analyze the details of specific Dataminr Pulse alerts you want to learn more about.
4. See the latest trending malicious IPs, exploited CVEs, and open ports.

![Alt text](resources/screenshots/Dataminr-Alerts-Drilldown.png?raw=true)
