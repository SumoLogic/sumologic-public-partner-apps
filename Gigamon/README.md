# Gigamon

The Gigamon Deep Observability Pipeline efficiently delivers network-derived intelligence to amplify the power of your cloud, security, and observability tools. The solution eliminates network blind spots as you move workloads to the cloud, reducing security, and compliance risks while improving performance across your hybrid cloud infrastructure.

## Gigamon app for Sumo Logic

- [Introduction](#introduction)
- [Sample Log Message](#sample-log-message)
- [Query Sample](#query-sample)
- [Collect Logs for Gigamon](#collect-logs-for-gigamon_hawk)
- [Install the Sumo Logic App](#install-the-sumo-logic-app)
- [Screenshots](#screenshots)

## Introduction

The Gigamon Deep Observability Pipeline efficiently delivers network-derived intelligence to amplify the power of your cloud, security, and observability tools. The solution eliminates network blind spots as you move workloads to the cloud, reducing security, and compliance risks while improving performance across your hybrid cloud infrastructure.

| Dashboard                                       | Description                                                       |
| ----------------------------------------------- | ----------------------------------------------------------------- |
| [Gigamon Deep Observability Pipeline - AMI - Overview]       | Gigamon AMI dashboard covers Application Overview, Shadow IT Apps, Top DNS queries, Ciphers and SMB File movement on network. |

## Sample Log Message

```json
{
   "timestamp":"2025-02-15T10:23:24.217Z",
   "src_port":48302,
   "ssl_nb_compression_methods":"1",
   "ssl_validity_not_before":"170802000957Z",
   "ssl_certificate_issuer_cn":"ui.analyticsengine.cloudpostnetworks.com",
   "ssl_certif_md5":"10000000e475f8027130a4c6c082c9eed00d3fa7",
   "ssl_ext_sig_algorithms_len":"20",
   "ssl_client_hello_extension_type":"23",
   "ssl_certif_sha1":"14000000e25e7bcb89ae3f8b4896f21625dc5780a6fe60d6",
   "dst_ip":"38.99.119.52",
   "ssl_cert_extension_oid":"2.5.29.15",
   "ssl_ext_sig_algorithm_scheme":"1025",
   "eventType":"Gigamon",
   "ssl_ext_sig_algorithm_hash":"3",
   "ssl_client_hello_extension_len":"0",
   "ssl_ext_ec_supported_groups_nb":"5",
   "ssl_protocol_version":"771",
   "app_name":"https",
   "dst_port":443,
   "ssl_issuer":"ui.analyticsengine.cloudpostnetworks.com",
   "ssl_cipher_suite_list":"c02cc087cca9c0adc00ac02bc086c0acc009c008c030c08bcca8c014c02fc08ac013c012009dc07bc09d00350084009cc07ac09c002f0041000a009fc07dccaac09f00390088009ec07cc09e003300450016",
   "ssl_serial_number":"00862171195bda0452",
   "ssl_server_hello_extension_len":"1",
   "ssl_ext_ec_supported_groups_type":"23",
   "ssl_cipher_suite_id_string":"TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256",
   "id":"2309470620422412292",
   "ssl_certificate_subject_key_size":"270",
   "ssl_certificate_dn_issuer":"CN=ui.analyticsengine.cloudpostnetworks.com",
   "ssl_declassify_override":"0",
   "protocol":6,
   "ssl_certificate_subject_cn":"ui.analyticsengine.cloudpostnetworks.com",
   "ssl_content_type":"22",
   "ssl_cipher_suite_id":"49199",
   "ssl_server_hello_extension_type":"65281",
   "hostname":"10.0.10.164/gs_apps_FmAuto-App_Intel5-appmetadata-238dac04-5f29-4005-ae71-a0c02b7e3ada_EC2EB82A-59FB-DBF1-747B-4D0B65332F22",
   "ssl_certificate_dn_subject":"CN=ui.analyticsengine.cloudpostnetworks.com",
   "ssl_ext_ec_point_formats_nb":"1",
   "ssl_ext_ec_point_formats_type":"0",
   "ssl_common_name":"ui.analyticsengine.cloudpostnetworks.com",
   "src_ip":"10.0.0.81",
   "ssl_ext_sig_algorithm_sig":"1"
}
```

## Query Sample

This is an example of a simple query that returns the number of inbound flags:

```text
_sourceCategory="Gigamon" and _collector="HTTP"
| parse regex "(?<element>\{\"timestamp\"[^\}]+\})" multi 
| json auto field=element
| where !isNull(ssl_cipher_suite_id_string)
```

## Collect Logs for Gigamon

Collection process overview:
Step 1. Deploy Gigamon CloudSuite solution. For more, refer this [link] (https://docs.gigamon.com/doclib60/Content/GV-Cloud-Any/virtual-config-AnyCloud.html?tocpath=GigaVUE%20Cloud%20Suite%7CAnyCloud%7CDeploy%20GigaVUE%20Cloud%20Suite%20for%20AnyCloud%7C_____0)
![Alt text](resources/docs/col_step_1.png?raw=true)
Step 2. Deploy Gigamon Application Intelligence. For more, refer this [link](https://docs.gigamon.com/pdfs/Content/Resources/PDF%20Library/GV-6100-Doc/GigaVUE-VSeries2-Applications-Guide-v61.pdf)
![Alt text](resources/docs/col_step_2.png?raw=true)
Step 3. Select desired application and attributes 
![Alt text](resources/docs/col_step_3.png?raw=true)
Step 4. For Gigamon Setup,
    - create a new integration and select "SumoLogic" under "Cloud Tools" and provide Sumologic's API Key :
    ![Alt text](resources/docs/Gigamon_Integration.png?raw=true)
    - create new scheduled action using the Sumo Integration:
        - choose schedule, filter, output fields, Sumo configuration name and the Save and Run.
        ![Alt text](resources/docs/SetAction1.png?raw=true)
        ![Alt text](resources/docs/SetAction2.png?raw=true)
        ![Alt text](resources/docs/SetAction3.png?raw=true)
        ![Alt text](resources/docs/SetAction4.png?raw=true)
Step 5. Visualize as desired or use default dashboards.
![Alt text](resources/docs/col_step_4.png?raw=true)


## Install the Sumo Logic App

Use the instruction from this doc (https://help.sumologic.com/05Search/Library/Apps-in-Sumo-Logic/Install-Apps-from-the-Library) to install the Gigamon App.

## Screenshots

### Gigamon Deep Observability Pipeline - AMI - Overview Dashboard

Gigamon AMI provides rich network application intelligence and attributes to visualize and see network data

Gigamon AMI dashboard covers Application Overview, Shadow IT Apps, Top DNS queries, Ciphers and SMB File movement on network.

![Alt text](resources/screenshots/Screenshot_1.png?raw=true)
![Alt text](resources/screenshots/Screenshot_2.pngraw=true)
![Alt text](resources/screenshots/Screenshot_3.png?raw=true)
![Alt text](resources/screenshots/Screenshot_4.png?raw=true)
![Alt text](resources/screenshots/Screenshot_5.pngraw=true)
![Alt text](resources/screenshots/Screenshot_6.png?raw=true)
![Alt text](resources/screenshots/Screenshot_7.png?raw=true)

## Support

This application has been developed and is supported by Gigamon. In case of technical questions, please contact Gigamon support at https://www.gigamon.com/support/support-and-services/contact-support.html
