# NetFlow Logic - IT Operations and Security

The NetFlow Logic - IT Operations and Security app (NetFlow App) provides visibility into your network infrastructure on prem or in the cloud. 

This App relies on flow data processed by NetFlow Optimizer (NFO) and provides dashboards to address many use cases such as network bandwidth monitoring, capacity planning, detailed traffic activities, troubleshooting and cyber threat detection.

- [Sending data from NFO to NetFlow app in SumoLogic](#sending-data-from-nfo-to-netflow-app-in-sumologic)
- [Install the NetFlow App](#install-the-netflow-app)
- [Screenshots](#screenshots)
- [Support](#support)

## Sending data from NFO to NetFlow App in SumoLogic

Use the instruction from this [doc](https://docs.netflowlogic.com/integrations-and-apps/integration-with-sumo-logic) to set up the sending 

## Install the NetFlow App

Use the instruction from this [doc](https://help.sumologic.com/docs/get-started/apps-integrations/#install-apps-from-the-library) to install the NetFlow App.

## Screenshots

### NetFlow - Traffic Overview

Dashboard monitoring network traffic by volume and host. It provides details for top senders, receivers, protocols, ports, applications, and users.

![Alt text](resources/screenshots/sumo_traffic_overview.png?raw=true)

### NetFlow - Flows Allowed and Rejected

Dashboard monitoring traffic flows in your data center and clouds. It provides details for inbound/outbound traffic as well as accepted/rejected network conversations.

![Alt text](resources/screenshots/sumo_flows_allowed_and_rejected.png?raw=true)

### NetFlow - Security Monitoring - Communications with Malicious Hosts

Dashboard monitoring threats on your network, categorized by threat feed and reputation. You can view hosts affected by threats and trends over time.

![Alt text](resources/screenshots/sumo_security_malicious_hosts.png?raw=true)

### NetFlow - Security Monitoring - Traffic Using Critical Ports

Dashboard showing analytics for your DNS traffic as well as critical port usage.

![Alt text](resources/screenshots/sumo_flows_allowed_and_rejected.png?raw=true)


## Lookup Files

NetFlow App relies on the following lookup files (you can download them by clicking on links below):

- [critical_ports](https://sumologicnetflow.s3.eu-central-1.amazonaws.com/critical_ports.csv)
- [netflow_protocols](https://sumologicnetflow.s3.eu-central-1.amazonaws.com/netflow_protocols.csv)

You can modify the content of these files to match your needs, and upload them into your Sumo Logic environment by following these steps.

1. Create a new directory in SumoLogic portal, for example named `netflow_lookups`
2. Upload both lookup files to this directory as new lookups
3. Based on this [tutorial](https://help.sumologic.com/docs/search/lookup-tables/create-lookup-table/#create-a-lookup-table-from-a-csv-file) add the two csv lookup files 
    - critical_ports - select `dest_port` as the primary key
    - netflow_protocols - select `protocol` as the primary key
4. Note the [path](https://help.sumologic.com/docs/search/lookup-tables/create-lookup-table/#finda-lookup-table-path) to both lookup files
5. Change the following queries in these dashboards to reference the created lookups
    - Dashboard "NetFlow - Security Monitoring - Traffic Using Critical Port" Query "Top Inboound Traffic Accepted"

        replace `https://sumologicnetflow.s3.eu-central-1.amazonaws.com/critical_ports.csv`
        with the path to the critical_ports lookup

    - Dashboard "NetFlow - Security Monitoring - Traffic Using Critical Port" Query "Top Outboound Traffic Accepted"
        
        replace `https://sumologicnetflow.s3.eu-central-1.amazonaws.com/critical_ports.csv`
        with the path to the critical_ports lookup

    - Dashboard "NetFlow - Security Monitoring - Traffic Using Critical Port" Query "Top Internal Traffic Accepted"
        
        replace `https://sumologicnetflow.s3.eu-central-1.amazonaws.com/critical_ports.csv`
        with the path to the critical_ports lookup

    - Dashboard "NetFlow - Traffic Overview" Query "Top Traffic Protocols"
        
        replace `https://sumologicnetflow.s3.eu-central-1.amazonaws.com/netflow_protocols.csv`
        with the path to the netflow_protocols lookup

## Support

This application has been developed and is supported by [NetFlow Logic](https://www.netflowlogic.com/). Support email: team_sumo_logic@netflowlogic.com
