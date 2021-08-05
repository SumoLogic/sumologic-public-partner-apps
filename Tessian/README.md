# Tessian

View metrics and charts based on Tessian data feeds across all modules, Defender, Guardian, Enforcer and Constructor.

## Tessian app for Sumo Logic

- [Introduction](#introduction)
- [Sample Log Message](#sample-log-message)
- [Query Sample](#query-sample)
- [Screenshots](#screenshots)

## Introduction

Tessian is the world’s first Human Layer Security company. We use data science and machine learning to automatically stop data breaches and security threats caused by human error – like data exfiltration, accidental data loss, business email compromise and phishing attacks – with minimal disruption to employees' workflow. We then help employees improve their security behaviour over time through contextual, in-the-moment education.

The Sumo Logic App for Tessian provides visibility into human layer risk drivers and easy access to cybersecurity events prevented based on Tessian data feeds across all modules:

Email security with Tessian Defender: Automatically prevents BEC, Account Takeover and other advanced Phishing Attacks Data Loss Prevention with
Tessian Guardian: Automatically prevents accidental data loss from misdirected emails and attachments
Tessian Enforcer: Automatically prevents data exfiltration to personal or unauthorized email accounts, detects and prevents insider threats
Tessian Constructor: Customized Email Compliance

The Tessian app for Sumo Logic helps security and IT teams quickly investigate where their Human Layer risks are occurring, providing metrics and charts based on Tessian data feeds across all modules.


| Dashboard                                       | Description                                                       |
| ----------------------------------------------- | ----------------------------------------------------------------- |
| [Tessian - Overview](#overview-dashboard)       | View high level stats and metrics related to all Tessian modules. |
| [Tessian - Defender](#defender-dashboard)       | View stats and metrics related to Tessian Defender.               |
| [Tessian - Guardian](#guardian-dashboard)       | View stats and metrics related to Tessian Guardian.               |
| [Tessian - Enforcer](#enforcer-dashboard)       | View stats and metrics related to Tessian Enforcer.               |
| [Tessian - Constructor](#constructor-dashboard) | View stats and metrics related to Tessian Constructor.            |

## Sample Log Message

The Tessian App uses logs retrieved from Tessian API and sent individually into Sumo Logic.

```json
{
    "message_id": "1336a5ff-2f48-4c4b-b634-a4bd77109c18",
    "module": "constructor",
    "number_of_attachments": 0,
    "threat_classification": null,
    "timestamp": "2021-07-14T13:49:07.863770Z",
    "updated_at": "2021-07-14T13:49:07.863770Z",
    "user_interaction": null,
    "user": "john@company.com",
    "alert_type": "block",
    "changes_made": "None: email not sent",
    "check_performed_by": "Tessian Add-in",
    "final_outcome": "Email not sent",
    "subsequent_action": "None",
    "misdirected_email_prevented": null,
    "suggested_recipient": null,
    "filter_name": "Testing 2",
    "threat_types": null,
    "anomalous_recipient": null,
    "impersonation_type": null,
    "impersonated_address": null,
    "impersonated_domain": null,
    "email_is_sensitive": null,
    "unauthorized_email_prevented": null,
    "flag_reason": null,
    "intents": null,
    "email_summary": null,
    "unauthorised_recipients": null,
    "request_for_override": null,
    "attachments_total_size": 0,
    "trigger_id": "74401-47"
}
```

## Query Sample

This is an example of a simple query that returns the number of inbound flags:

```text
_sourceCategory = "Tessian"
| where module = "defender"
| sort by trigger_id, updated_at
| transactionize trigger_id (merge user_interaction takeLast)
| count
```

## Collect Logs for Tessian

Please contact Tessian Support at support@tessian.com for assistance setting up the log collection process.

1. **Retrieve logs periodically using Tessian API.**

    Follow the instructions in your Tessian portal to setup your
    API token and supplied python scripts
1. **Extract and format logs into individual events**

    The default python script downloads the logs in batches,
    you will need to adapt this script to extract each event as
    an individual logline formatted as single line JSON (see Sample Log Message above)
1. **Send each event one-by-one into Sumo Logic**

    - In Sumo Logic, configure a [hosted collector](https://help.sumologic.com/03Send-Data/Hosted-Collectors)
    and associate an [HTTP Logs and Metrics Source](https://help.sumologic.com/03Send-Data/Sources/02Sources-for-Hosted-Collectors/HTTP-Source#configure-an-http%C2%A0logs-and-metrics-source) with the collector. Copy the HTTP source URL.
    - Update the python script to iterate over each individual log line and POST them
    to the new Sumo HTTP source URL
    - Schedule a task to run this script periodically (we recommend at least once
    every 5 minutes so events are available in Sumo Logic near live)

## Install the Sumo Logic App

Use the instruction from this doc (https://help.sumologic.com/05Search/Library/Apps-in-Sumo-Logic/Install-Apps-from-the-Library) to install the Tessian App.

## Screenshots

### Overview Dashboard

View high level stats and metrics related to Tessian.

The Overview Dashboard provides a quick snapshot of the number of events for each module. The far left column shows the events for just today, the second column and timeline chart show the events based on the time period set in the top right of the dashboard.

Use this dashboard to:

- Monitor for key events happening today
- Review general trends over time

![Alt text](resources/screenshots/tessian_overview_dashboard.jpg?raw=true "overview screenshot")

### Defender Dashboard

View stats and metrics related to Tessian Defender.

![Alt text](resources/screenshots/tessian_defender_dashboard.jpg?raw=true "defender screenshot")

### Guardian Dashboard

View stats and metrics related to Tessian Guardian.

![Alt text](resources/screenshots/tessian_guardian_dashboard.jpg?raw=true "guardian screenshot")

### Enforcer Dashboard

View stats and metrics related to Tessian Enforcer.

![Alt text](resources/screenshots/tessian_enforcer_dashboard.jpg?raw=true "enforcer screenshot")

### Constructor Dashboard

View stats and metrics related to Tessian Constructor.

![Alt text](resources/screenshots/tessian_constructor_dashboard.jpg?raw=true "constructor screenshot")

## Support

This application has been developed and is supported by Tessian Limited. In case of technical questions, please contact Tessian support at support@tessian.com.
