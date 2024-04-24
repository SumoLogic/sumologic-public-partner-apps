## Endace App for Sumo Logic

- [Introduction](#introduction)
- [How to use the App](#How-to-use-the-App)
- [Query Sample](#query-sample)
- [Install the Sumo Logic App](#install-the-sumo-logic-app)
- [Screenshots](#screenshots)

## Introduction 

Bring clarity to every incident, alert, or issue with Endace packet capture evidence integrated directly into the Sumo Logic platform. Endace delivers scalable, always-on packet capture in on-premise and hybrid cloud environments for definitive network visibility.  Packets are the ultimate tamperproof source of truth that accelerates incident response for security threats, outages, and performance issues. This integration provides your operations team with fast access to the network packets (pcap) related to any incident or threat for rapid and precise incident response. 

## How to use the App

The Endace App includes premade dashboards for logs such as Zeek, Suricata, Cisco ASA, Cisco Firepower and Palo Alto Networks, which include a Pivot-to-Vision link to connect you to your EndaceProbe for further investigation. You will need to download and run the python script from our Support Portal, which will create the Field Extraction Rules to automatically extract the needed fields and create the Pivot-to-Vision link.

Python script: https://support.endace.com/s/eda-contentitem/a0MIS000000hfyE2AQ/endace-sumo-logic-python-script


## Query Sample

Example of a simple query for Suricata and Zeek traffic.

```text
_sourceCategory="suricata"
``` 

```text
_sourceCategory="zeek"
``` 

## Install the Sumo Logic App

Use the instruction from this [doc](https://help.sumologic.com/docs/get-started/apps-integrations/#install-apps-from-the-library) to install the Endace App.

## Screenshots


![Alt text](screenshots/Cisco_firepower.PNG?raw=true)
<br>
<br>

<br>

![Alt text](screenshots/CiscoASA.PNG?raw=true)
<br>
<br>

<br>

![Alt text](screenshots/Palo_Alto_Networks.PNG?raw=true)
<br>
<br>

<br>

![Alt text](screenshots/Suricata.PNG?raw=true)
<br>
<br>

<br>

![Alt text](screenshots/Zeek.PNG?raw=true)
<br>
<br>

<br>

![Alt text](screenshots/EndaceProbe_sumologic.PNG?raw=true)
