# LambdaTest

LambdaTest dashboards will help you in analysing your testing behavior and error trends.

## LambdaTest app for Sumo Logic

- [Introduction](#introduction)
- [Sample Log Message](#sample-log-message)
- [Query Sample](#query-sample)
- [Collect Logs for LambdaTest](#collect-logs-for-lambdatest)
- [Install the Sumo Logic App](#install-the-sumo-logic-app)
- [Screenshots](#screenshots)

## Introduction

LambdaTest is a continuous quality testing cloud platform that helps developers and testers ship code faster. LambdaTest platform provides secure, scalable, and insightful test orchestration for customers at different points in their DevOps (CI/CD) lifecycle.


| Dashboard                                       | Description                                                       |
| ----------------------------------------------- | ----------------------------------------------------------------- |
| [LambdaTest - Test Error Overview]       | This dashboard shows overview of test error execution details. |
| [LambdaTest - Test Overview]       | This dashboard shows overview of test execution details. |


## Sample Log Message

```json
{
   "id":"155313100",
   "test_id":"31n7w-j75m1-xlu2n-q6r83",
   "test_name":"",
   "build_name":"",
   "selenium_session_id":"",
   "user_id":"783061",
   "organization_id":"757034",
   "user_status":"Internal",
   "current_subscription_type":"Trial",
   "client":"Webapp",
   "product":"Manual Browser Testing Real Device",
   "status":"Failed",
   "test_env_resolution":"",
   "test_env_browser":"safari",
   "test_env_device":"iPhone 12 Mini",
   "test_env_os":"ios 14",
   "test_selenium_version":"",
   "test_driver_version":"",
   "test_created_at":"2022-09-07 12:03:56",
   "test_started_at":"",
   "test_ended_at":"2022-09-07 12:03:57",
   "duration_in_secs":"",
   "duration_formatted":"",
   "test_url":"",
   "remarks":"no_device_found",
   "tunnel_identifier":"",
   "tunnel_used":"1",
   "template_id":"real-iphone-12-mini",
   "stream_type":"",
   "browser_launch_time":"",
   "error_type":"",
   "error_message":"",
   "screenshots_requested":"0",
   "screenshots_obtained":"0",
   "sync_attempts":"0",
   "is_computed":"3",
   "test_score":"",
   "score_calculated":"0",
   "computed_at":"",
   "is_mobile_automation":"1",
   "created_at":"2022-09-07T12:04:08.000000Z",
   "updated_at":"2022-09-07T12:06:24.000000Z",
   "test_updated_at":"2022-09-07 12:06:24",
   "live_interaction_clicked":"0",
   "visual":"",
   "device_orientation":"",
   "headless":"",
   "geo_location":"",
   "timezone":"",
   "video":"",
   "network":"",
   "console":"",
   "performance":"",
   "user_agent":"",
   "w3c":"",
   "enable_network_throttling":"",
   "appium_version":"",
   "is_real_mobile":"",
   "browser_specifics_capabilities":"",
   "browser_options_passed":"",
   "tags":"",
   "build_tags":"",
   "custom_data":"",
   "plugin":"",
   "enable_custom_translation":"",
   "concurrency_queued":"",
   "vm_queued":"",
   "provider":"",
   "region":"",
   "vm_ip_address":"",
   "org_domain":"lambdatest.com",
   "organization_name":"N\/A",
   "udid":null,
   "username":"qadevops",
   "aws_account":"new"
}
```

## Query Sample

This is an example of a simple query that returns the number of test runs:

```text
sourceCategory="LambdaTest"
| where !isNull(test_id) and test_name matches "*" and build_name matches "*" | timeslice 10m | count by _timeslice | sort _timeslice asc
```

## Collect Logs for LambdaTest

Collection process overview:

Use the Collection page to manage all of your Collectors and Sources. To access the Collection page, go to Manage Data > Collection > Collection.
- In Sumo Logic, configure a [hosted collector](https://help.sumologic.com/03Send-Data/Hosted-Collectors)
  and associate an [HTTP Logs and Metrics Source](https://help.sumologic.com/03Send-Data/Sources/02Sources-for-Hosted-Collectors/HTTP-Source#configure-an-http%C2%A0logs-and-metrics-source) with the collector. Copy the HTTP source URL.
- Login to your LambdaTest account and visit Integrations from the left sidebar.
- From the PROJECT MANAGEMENT category, select SUMO LOGIC.
  ![Alt text](resources/docs/lambdatest_col_step1.png?raw=true)
- In the Collector endpoint URL field, paste the copied HTTP Source URL and press Install.
  ![Alt text](resources/docs/lambdatest_col_step2.png?raw=true)
Sumo Logic will be integrated with your LambdaTest account.
Once you run automation tests on LambdaTest, you will be able to view the test results of your executed tests on custom Sumo Logic Dashboards.

## Install the Sumo Logic App

Use the instruction from this doc (https://help.sumologic.com/05Search/Library/Apps-in-Sumo-Logic/Install-Apps-from-the-Library) to install the LambdaTest App.

## Screenshots

### LambdaTest - Test Error Overview Dashboard

This dashboard shows overview of test error execution details.

![Alt text](resources/screenshots/LambdaTest_Test_Error_Overview.png?raw=true)

### LambdaTest - Test Overview

This dashboard shows overview of test execution details.

![Alt text](resources/screenshots/LambdaTest_Test_Overview.png?raw=true)

## Support

This application has been developed and is supported by [LambdaTest](https://www.lambdatest.com/support/docs/sumo-logic-integration/). In case of technical questions, please contact LambdaTest support at https://www.lambdatest.com/contact-us