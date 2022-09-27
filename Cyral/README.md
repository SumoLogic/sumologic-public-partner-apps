# Cyral

- [Introduction](#introduction)
- [Log Types](#log-types)
- [Sample Log Message](#sample-log-message)
- [Query Sample](#query-sample)
- [Collect Logs for Cyral](#collect-logs-for-cyral)
- [Install the App and View the Dashboards](#install-the-app-and-view-the-dashboards)
- [Support](#support)

## Introduction

  The Cyral App for Sumo Logic provides dashboards and visualizations for Cyral customers that have chosen to send their logs to the Sumo Logic platform.


## Log Types

   All types of events collected are described [here](https://cyral.com/docs/repo-configure-log-volume#log-settings).

## Sample Log Message


```json
{"activityId": "190.43.176.53:52521:1627656515928:1", "activityTime": "2021-07-30 14:48:35.928000000 +0000 UTC", "activityTimeNanos": 1627656515928000000, "activityTypes": ["query", "fullTableScan"], "identity": {"endUser": "hellfire@outlook.com", "group": "HoneyPot", "repoUser": "medorders", "dbRole": "medorders"}, "repo": {"id": "6pJLkBa9yFe9Db6tnATlwtZJo5i", "name": "DEV-MYSQL", "type": "mysql", "host": "mysql.dev.svc.cluster.local", "port": 5432}, "client": {"connectionId": "190.43.176.53:52521:1627656515928", "connectionTime": "2021-07-30T13:17:43.928Z", "connectionTimeNanos": 1627656515928000000, "host": "190.43.176.53", "port": 52521, "applicationName": "Python"}, "sidecar": {"id": "3pX95MaTEy6cZHX1cUcJS9dlNcT", "name": "k8-dev", "autoScalingGroupInstance": "cyral-7dlngt-cyral-sidecar-66db759b74-hvbng"}, "request": {"statement": "UPDATE * FROM orders", "rewrittenStatement": "SELECT * FROM securedata", "statementType": "UPDATE", "isSensitive": true, "datasetsAccessed": [{"dataset": "public.securedata", "accessType": "read"}], "fieldsAccessed": [{"field": "public.securedata.legal", "label": "legal", "accessType": "read"}], "searchPath": ["medorders", "public"]}, "response": {"message": "Ok", "isError": false, "records": 10, "bytes": 3614, "executionTime": "2123.307602ms", "executionTimeNanos": 2123307602}, "policyViolated": true, "policyViolations": [{"label": "legal", "policyName": "Access Control For Partners", "policyId": "3pceCJcPMVwyR63R3tWcBR81wCE", "accessType": "read", "selectedIdentity": "user:hellfire@outlook.com", "reasons": ["5 records accessed exceeding limit of 2"], "severity": "low"}], "connectionTime": "2021-07-30 14:48:35.928000000 +0000 UTC"}
```

## Query Sample

This is an example of a simple query that returns average execution time.

```text
(_sourceCategory = cyral/logs )
| json "identity.group","response.message","client.applicationName","response.executionTimeNanos" nodrop
| where !isNull(%"identity.group") and !isNull(%"response.message") and %"client.applicationName" matches "{{applicationName}}"
| %"response.executionTimeNanos" / 1000000 as executionTimeInMS
| avg(executionTimeInMS)

```

## Collect Logs for Cyral


### Configuring Collection

   First, you will need to [Send Cyral logs to Sumo Logic](https://cyral.com/docs/integrations/siem/sumo-logic).


## Install the App and View the Dashboards

### Install

After configuring the collection you can [install](https://help.sumologic.com/05Search/Library/Apps-in-Sumo-Logic/Install-Apps-from-the-Library) the SumoLogic App from Cyral from App Catalog and use the same source category configured while creating the source.

#### Post Install Configuration

Some panels in the dashboard make use of a lookup file called `CategoryLookupTable.csv` located in the resources directory of this repo that must also be installed.

1. Login to your Sumo Logic instance as an Admin
2. Switch to the `Library View`
3. Within the `Library View`, set the View As to `Content Administrator`
4. Within the `Admin Recommended` Folder, click on the `Add New` button
5. From the `Add New` button, select `New Lookup`
6. In the resulting Lookup Configuration screen, use the following settings
  - Name: CategoryLookup
  - Set a TTL: No
  - Choose a size limit handling option: Delete Old Data
  - Create Lookup Table: Upload File
7. Under the `Upload File` heading, click the Upload button.
8. Locate the [CategoryLookupTable.csv](resources/lookups/CategoryLookupTable.csv) file and upload it
9. Set the following fields as Primary Keys:
   - StatementType
   - RepoType
10. Click the Create button
11. Once the lookup is created, edit the sharing settings so that it is shared with all users that will need access
12. Now you can install the Cyral Dashboards


## Support

This application has been developed and is supported by Cyral. In case of technical questions, please contact Cyral support.
