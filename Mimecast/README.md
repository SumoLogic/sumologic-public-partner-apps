# Mimecast app for Sumo Logic

**This application has been developed and is supported by Mimecast. In case of technical questions, please contact Mimecast support at https://community.mimecast.com/s/contactsupport. For issues is with content or the Hosted Collector please contact Sumo Logic support at support@sumologic.com.**

## Product Description:

### App description:

The Sumo Logic app for Mimecast enables customers to visualize Mimecast event log data ingested by Sumo Logic’s Hosted Collector using the Mimecast Source, and gain insight into activity on your Mimecast tenant.

| **Dashboard** | **Description** |
| --- | --- |
| Mimecast - Email Activity | Overview of email receipt, rejections, spam and quarantine events |
| Mimecast - Spam Detection | Overview of spam detection events |
| Mimecast - TLS | Overview of Transport Layer security |
| Mimecast - TTP URL Protect | Overview of URL Protect events |
| Mimecast - Virus Detection | Overview of virus detection events |

## Mimecast Page

The Sumo Logic app for Mimecast enables customers to visualize Mimecast event log data ingested by Sumo Logic’s Hosted Collector using the Mimecast Source, and gain insight into activity on your Mimecast tenant.

### Log Types

The Mimecast app parses event log data ingested from the Mimecast API (https://integrations.mimecast.com/documentation/tutorials/understanding-siem-logs), using Sumo Logic's Hosted Collector and a Mimecast Source(https://help.sumologic.com/03Send-Data/Sources/02Sources-for-Hosted-Collectors/Cloud-to-Cloud_Integration_Framework/Mimecast_Source#create-a-mimecast%C2%A0source)

### Sample Log Message

```
{
acc:"C46A75",
Sender:"mail.suspect@subdomain.domain.tld",
Hld:"Spm",
datetime:"2021-08-09T12:38:04+0100",
AttSize:0,
Act:"Hld",
aCode:"ro6CSCD4NwGngfpJAo7esA",
AttCnt:0,
AttNames:null,
MsgSize:125179,
MsgId:"<rvJQ1-7SQoOI3WM-nkbc-1uPdUIIQUvKxOIHsRL@subdomain.domain.tld>",
Subject:"The most dangerous (and interesting) Microsoft 365 attacks"
}
```

### Query sample

```
_sourceCategory="Mimecast"
| json auto 
| where hld != null 
| count by hld 
| sort by _count
```

## Collect Logs for Mimecast

This page has instructions for installing the Sumo App for Mimecast and descriptions of each of the app dashboards.

### Mimecast Email Activity Dashboard

Using the Mimecast integration with Sumo Logic, security operations can combine this context-rich endpoint insight with other security data to provide additional intelligence, empowering security teams to rapidly understand the scope of threats and respond effectively. Security teams can leverage the Mimecast app in order to:

* Get an overview of email receipt, rejections, spam and quarantine events
* Monitor inbound, outbound, internal and external mail volumes, delivery failures, rejections and held messages.
* Identify targeted users within the enterprise

### Screenshot

![Alt text](resources/screenshots/Mimecast_Email_Activity.png?raw=true "Mimecast Email Activity")

### Mimecast Spam Detection Dashboard
Security teams can leverage the Mimecast app in order to:

* Get an overview of spam detection events 
* Monitor spam detection volumes, top 10 spam signature detections and targeted users, spam detections by source IP address and sender.
* Identify targeted users within the enterprise.

### Screenshot

![Alt text](resources/screenshots/Mimecast_Spam_Detection.png?raw=true "Mimecast Spam Detection")

### Mimecast TLS Dashboard
Security teams can leverage the Mimecast app in order to:

* Overview of Transport Layer security
* Monitor volume of messages received and delivered using TLS, volume of messages received/delivered without TLS, TLS versions used, Top Ciphers used with TLS, inbound and outbound sending domains that do not use TLS.
### Screenshot

![Alt text](resources/screenshots/Mimecast_TLS.png?raw=true "Mimecast TLS")

### Mimecast TTP URL Protect Dashboard
Security teams can leverage the Mimecast app in order to:

* Overview of URL Protect events
* Monitor TTP URL event volumes, URL source route, URL categories, top 10  blocked URLs, Browser Isolation URLs.

### Screenshot

![Alt text](resources/screenshots/Mimecast_TTP_URL_Protect.png?raw=true "Mimecast TTP URL Protect")

### Mimecast Virus Detection Dashboard
Security teams can leverage the Mimecast app in order to:

* Overview of virus detection events
* Monitor email virus detection volumes, top 10 virus signature detections and targeted users, virus detections by file extension, virus detection by source IP address.

### Screenshot
![Alt text](resources/screenshots/Mimecast_Virus_Detection.png?raw=true "Mimecast Virus Detection")

# Documentation

https://community.mimecast.com/s/article/SumoLogic?_ga=2.168788196.458085106.1630414737-848348302.1622818853
