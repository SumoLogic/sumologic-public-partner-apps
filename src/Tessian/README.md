<h1>
<img width="24px" src="assets/images/icon.png">
Tessian for Sumo Logic
</h1>

_View metrics and charts based on Tessian data feeds across all modules:
Defender, Guardian, and Architect._

<img width="50%" src="assets/images/preview/Tessian-Overview.png?raw=true"><img width="50%" src="assets/images/preview/Tessian-Defender.png?raw=true">
<img width="50%" src="assets/images/preview/Tessian-Guardian.png?raw=true"><img width="50%" src="assets/images/preview/Tessian-Architect.png?raw=true">

Tessian is the world’s first Human Layer Security company. We use data science
and machine learning to automatically stop data breaches and security threats
caused by human error – like data exfiltration, accidental data loss, business
email compromise and phishing attacks – with minimal disruption to employees'
workflow. We then help employees improve their security behaviour over time
through contextual, in-the-moment education.

## Contents

- [Introduction](#introduction)
- [Getting started](#getting-started)
    - [Adding a collector](adding-a-collector)
    - [Sending logs](sending-logs)
    - [Adding the Tessian App](adding-the-tessian-app)
- [Sample Event](#sample-event)
- [Querying the data](#querying-the-data)
- [Support](#support)


## Introduction

Tessian for Sumo Logic provides visibility into Human Layer risk drivers and
easy access to cybersecurity events prevented based on Tessian data feeds:

- _Tessian Defender_: Automatically prevents BEC, Account Takeover and other
    advanced Phishing Attacks
- _Tessian Guardian_: Automatically prevents accidental data loss from
    misdirected emails and attachments
- _Tessian Architect_: Enables the use of custom policies, as well as
    customisation of Tessian's Data Exfiltration Algorithm

Tessian for Sumo Logic helps security and IT teams quickly investigate where
their Human Layer risks are occurring, providing metrics and charts based
on Tessian data feeds across all modules.


## Getting started

> :information_source:  _Please contact Tessian Support at support@tessian.com
> if you need assistance setting up the log collection process._

### Adding a collector

To begin using the Tessian dashboards, you will first need to set up a
HTTP collector within Sumo Logic. Instructions for adding a new collector can
be found on the [Configure HTTP Source for Logs and Metrics][1] Sumo Logic help
page.

[1]: https://help.sumologic.com/docs/send-data/hosted-collectors/http-source/logs-metrics/

Your collector endpoint should look something like:

```plain
https://endpoint1.collection.eu.sumologic.com/receiver/v1/http/...
```

Once you have a collector set up, you are ready to start sending logs to it.

### Sending logs

In order to send your Tessian events to Sumo Logic, you will need to send
events retrieved from the Tessian API to the HTTP collector you have set up.

The flow to send the events to Sumo Logic is as follows:

1. Retrieve events periodically using Tessian API.
1. `POST` the events to the HTTP collector endpoint with the events in the body
    of the request, and each event seperated by a new line.
    ```plain
    POST /receiver/v1/http/... HTTP/1.1

    {"created_at": "1970-01-01T00:00:00.000000Z", "outbound_email_details": …
    {"created_at": "1970-01-01T00:00:00.000000Z", "outbound_email_details": …
    {"created_at": "1970-01-01T00:00:00.000000Z", "outbound_email_details": …
    {"created_at": "1970-01-01T00:00:00.000000Z", "outbound_email_details": …
    ```

#### Example code

As simple example of how to send Tessian data to Sumo Logic using
[Python](https://www.python.org/). This is incomplete, but shows how data is
moved from Tessian to Sumo Logic. For a working script, see
[Sample script](#sample-script).

```python
import json
import requests

response = requests.get(
    "https://you.tessian-platform.com/api/v1/events,
    headers={"Authorization": f"API-Token ..."},
)

requests.post(
    "https://endpoint1.collection.eu.sumologic.com/receiver/v1/http/...",
    data="\n".join(json.dumps(event) for event in response.json())
)
```

#### Sample script

A sample Python script is available via the Tessian API integrations page on
your portal. You can start using this right away.

```shell
export TESSIAN_API_TOKEN=...
export TESSIAN_PORTAL_HOST=...

python tessian_api_script.py \
  --host "$TESSIAN_PORTAL_HOST" \
  --post-url https://endpoint1.collection.eu.sumologic.com/receiver/v1/http/... \
  --checkpoint-file /tmp/tessian-api-checkpoint
```

You can the schedule a task to run this command periodically (we recommend
every 5 minutes so events are available in Sumo Logic near live).


### Adding the Tessian App

Now that the collector is receiving your data, you can install the Tessian app
from the Sumo Logic App Catalog.

Full instructions can be found on the [Apps and Integrations][2] Sumo Logic
help page.

[2]: https://help.sumologic.com/docs/get-started/apps-integrations/#install-apps-from-the-library


## Sample Event

The Tessian App uses events retrieved from Tessian Events API. You can view the
full specification of our events with our [API documentation][3]

[3]: https://developer.tessian.com/documentation/api/index.html#tag/Events


```json
{
  "created_at": "2022-09-29T00:11:24.341353Z",
  "guardian_details": {
    "anomalous_attachments": [],
    "anomalous_recipients": ["sam@example.com"],
    "breach_prevented": false,
    "final_outcome": "NOT_SENT",
    "justifications": [],
    "suggested_recipients": ["sam.smith@example.com"],
    "triggered_filter_ids": ["1"],
    "triggered_filter_names": ["Guardian"],
    "type": "MISDIRECTED_EMAIL",
    "user_responses": ["DO_NOT_SEND"],
    "user_shown_message": true
  },
  "id": "guardian::outbound-3338707",
  "outbound_email_details": {
    "attachments": {
      "bytes": 1234000,
      "count": 1,
      "names": [
        "recipe.pdf"
      ]
    },
    "from": "charlie@example.com",
    "message_id": null,
    "recipients": {
      "all": ["sam@example.com"],
      "bcc": [],
      "cc": [],
      "count": 1,
      "to": ["sam@example.com"]
    },
    "reply_to": [],
    "send_time": "2022-09-29T00:11:24.030936Z",
    "subject": "9aded476-3ed7-4dbd-98f1-ab48dfb098ab",
    "tessian_action": "SILENTLY_TRACK",
    "tessian_id": "709c359a-2695-4c3b-87d9-b630567979c5",
    "transmitter": "charlie@example.com"
  },
  "portal_link": "https://you.tessian-app.com/0/events/...",
  "type": "guardian",
  "updated_at": "2022-09-29T00:52:10.232509Z"
}
```

## Querying the data

Full documentation of how to query Sumo Logic can be found on the
[Getting Started with Search][4] help page.

[4]: https://help.sumologic.com/docs/search/get-started-with-search/

Some sample queries are provided below.

#### All events

```plain
_sourceCategory=Tessian
| json "type", "id", "updated_at"
```

#### Unique suspicious emails detected by Defender

```plain
_sourceCategory=Tessian
| where type = "defender"
| transactionize id (merge inbound_email_details.message_id takeLast)
| count_distinct(inbound_email_details.message_id) as count
```

#### Guardian events final outcome

```plain
_sourceCategory=Tessian
| where type = "guardian"
| transactionize id (
    merge guardian_details.final_outcome takeLast,
          outbound_email_details.message_id takeLast
  )
| count_distinct(outbound_email_details.message_id) as count by guardian_details.final_outcome
```


## Support

This application has been developed and is supported by Tessian Limited. In
case of technical questions, please contact Tessian support at support@tessian.com.
