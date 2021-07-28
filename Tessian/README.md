# Tessian

## Tessian app for Sumo Logic

- [Introduction](#introduction)
- [Sample Log Message](#sample-log-message)
- [Query Sample](#query-sample)
- [Screenshots](#screenshots)

## Introduction

The Tessian Human Layer Security platform automatically stops data breaches and security threats caused by employees - whether the cause is human error like a mistake or falling for a phishing attack or an insider threat. Tessian  uses machine learning technology and uniquely addresses the risks posed by employees by:

- Providing comprehensive visibility into your human layer risks
- Automatically detecting and preventing threats like accidental data loss, data exfiltration
and advanced phishing attacks (that legacy solutions can’t detect)
- Continuously driving your employees toward secure email behavior through contextual, in-the-moment training in real time

All this is all done with no disruptions to your employees’ productivity. Tessian integrates seamlessly with email environments within minutes, learns within hours, and starts protecting in a day - closing the critical gap in your email security stack.

The Tessian app for Sumo Logic helps customers quickly view where their Human Layer risks are occurring, providing metrics and charts based on Tessian data feeds across all modules.

| Dashboard                                       | Description                                                       |
| ----------------------------------------------- | ----------------------------------------------------------------- |
| [Tessian - Overview](#overview-dashboard)       | View high level stats and metrics related to all Tessian modules. |
| [Tessian - Defender](#defender-dashboard)       | View stats and metrics related to Tessian Defender.               |
| [Tessian - Guardian](#guardian-dashboard)       | View stats and metrics related to Tessian Guardian.               |
| [Tessian - Enforcer](#enforcer-dashboard)       | View stats and metrics related to Tessian Enforcer.               |
| [Tessian - Constructor](#constructor-dashboard) | View stats and metrics related to Tessian Constructor.            |

## Sample Log Message

```json
{
    "message_id": "1336a5ff-2f48-4c4b-b634-a4bd77109c18",
    "module": "constructor",
    "number_of_attachments": 0,
    "threat_classification": null,
    "timestamp": "2021-07-14T13:49:07.863770Z",
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

## Screenshots

### Overview Dashboard

View high level stats and metrics related to Tessian.

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
