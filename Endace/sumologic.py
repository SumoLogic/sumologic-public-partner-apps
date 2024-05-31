# MIT

# Copyright 2024 Endace Technology Limited

# LEGAL NOTICE: This source code:

# a) is copyright (C) to Endace Technology Limited or any of its related or
# affiliated companies, a New Zealand company, and its suppliers and licensors
# ("Endace"), 2024. All rights reserved (except as provided in the license terms
# referred to in clause (b) below); and

# b) is licensed to you on the terms of the MIT license, detailed below.

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import requests
import json

# Version
version = '1.0'

# Variables for the Endace Probe URL
hostname = '<probe hostname>'
timezone = "etc/utc" # See link for list of time zones: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
title = "Pivot%20from%20SumoLogic"
datasources = 'tag:rotation-file'
tools = 'trafficOverTime_by_app,conversations_by_ipaddress'
url = f"https://{hostname}/vision2/pivotintovision/?title={title}&datasources={datasources}&incidenttime=TIME&reltime=5m&tools={tools}&ip_conv=SOURCEIP%26DESTIP"

# This should be updated to your access id / key. 
access_id = '<access id>'
access_key = '<access key>'

# The API endpoint will depend on where your instance is located.  You can see more info at https://help.sumologic.com/docs/api/
api_endpoint_post_extraction_rules = '<API extraction rules>' # Example: https://api.sumologic.com/api/v1/extractionRules

headers = {'Content-Type': 'application/json'}
session = requests.Session()
session.auth = (access_id, access_key)

#Payload to create a log search in sumologic
def create_fer(name, parseExpression, scope="All Data"):
    payload = {
    "parseExpression": parseExpression,
    "name": name,
    "scope": scope,
    "enabled": 'true',
    }

    #Send an HTTP POST request with the payload and headers - Creates customized search
    response = session.post(api_endpoint_post_extraction_rules, data=json.dumps(payload), headers=headers)

    # Check the response
    if response.status_code == 200:
        print("Request was successful")
        print("Response content:", response.text)
    else:
        print("Request failed with status code:", response.status_code)
        print("Response content:", response.text)

# FER for Zeek
create_fer(
    name = "Endace_Zeek",
    scope = "_sourceCategory=zeek",
    parseExpression = "parse regex \"(?<endace_date>\d{10})\" | toString(tolong(endace_date * 1000)) as endace_date |" + f"\"{url}\" as Endace_Pivot_to_Vision" + " | replace(Endace_Pivot_to_Vision, \"TIME\", endace_date) as Endace_Pivot_to_Vision | parse regex \"(?<source_ip>\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3})\" | parse regex \"\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\\\\t.{1,20}\\\\t(?<dest_ip>\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})\"  | replace(Endace_Pivot_to_Vision, \"SOURCEIP\", source_ip) as Endace_Pivot_to_Vision | replace(Endace_Pivot_to_Vision, \"DESTIP\", dest_ip) as Endace_Pivot_to_Vision | tourl(endace_pivot_to_vision, \"Endace_Pivot_to_Vision\") as endace_pivot_to_vision",
)

# Create Suricata search
create_fer(
    name = "Endace_Suricata",
    scope = "_sourceCategory=suricata",
    parseExpression = "formatDate(_messageTime, \"yyyy-MM-dd'T'HH:mm:ssZ\"" + f",\"{timezone}\" )  as endace_date | replace(endace_date, \"+0000\", \"\") as endace_date |" + f"\"{url}\" as Endace_Pivot_to_Vision" + " | replace(Endace_Pivot_to_Vision, \"TIME\", endace_date) as Endace_Pivot_to_Vision |parse regex \"src_ip.....(?<src_ip>\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})\" |parse regex \"dest_ip.....(?<dest_ip>\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})\"| replace(Endace_Pivot_to_Vision, \"SOURCEIP\", src_ip) as Endace_Pivot_to_Vision | replace(Endace_Pivot_to_Vision, \"DESTIP\", dest_ip) as Endace_Pivot_to_Vision | tourl(endace_pivot_to_vision, \"Endace_Pivot_to_Vision\") as endace_pivot_to_vision",
)

# Create Palo search
create_fer(
    name = "Endace_Palo",
    scope = "_sourceCategory=messages",
    parseExpression = "parse regex \"(?<source>Palo\sAlto\sNetworks)\" | formatDate(_messageTime, \"yyyy-MM-dd'T'HH:mm:ss\"" + f",\"{timezone}\" ) as endace_date | replace(endace_date, \"+0000\", \"\") as endace_date |" + f"\"{url}\" as Endace_Pivot_to_Vision" + " | replace(Endace_Pivot_to_Vision, \"TIME\", endace_date) as Endace_Pivot_to_Vision |parse regex \"src_ip=(?<src_ip>\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})\" |parse regex \"dst_ip=(?<dest_ip>\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})\" | replace(Endace_Pivot_to_Vision, \"SOURCEIP\", src_ip) as Endace_Pivot_to_Vision | replace(Endace_Pivot_to_Vision, \"DESTIP\", dest_ip) as Endace_Pivot_to_Vision | tourl(endace_pivot_to_vision, \"Endace_Pivot_to_Vision\") as endace_pivot_to_vision",
)

# Create ciscoasa search
create_fer(
    name = "Endace_ciscoasa",
    scope = "_sourceCategory=messages",
    parseExpression = "parse regex \"(?<source>ciscoasa)\" | formatDate(_messageTime, \"yyyy-MM-dd'T'HH:mm:ssZ\"" + f",\"{timezone}\" ) as endace_date | replace(endace_date, \"+0000\", \"\") as endace_date |" + f"\"{url}\" as Endace_Pivot_to_Vision" + " | replace(Endace_Pivot_to_Vision, \"TIME\", endace_date) as Endace_Pivot_to_Vision | parse regex \"(?<src_ip>\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3})\" | parse regex \"\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\, DstIP:\s(?<dest_ip>\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})\" | replace(Endace_Pivot_to_Vision, \"SOURCEIP\", src_ip) as Endace_Pivot_to_Vision | replace(Endace_Pivot_to_Vision, \"DESTIP\", dest_ip) as Endace_Pivot_to_Vision | tourl(endace_pivot_to_vision, \"Endace_Pivot_to_Vision\") as endace_pivot_to_vision",
)

# Create cisco firepower search
create_fer(
    name = "Endace_cisco_firepower",
    scope = "_sourceCategory=messages",
    parseExpression = "parse regex \"(?<source>FTD\-\d\-\d\d\d\d\d\d)\" | formatDate(_messageTime, \"yyyy-MM-dd'T'HH:mm:ssZ\"" + f",\"{timezone}\" ) as endace_date | replace(endace_date, \"+0000\", \"\") as endace_date |" + f"\"{url}\" as Endace_Pivot_to_Vision" + " | replace(Endace_Pivot_to_Vision, \"TIME\", endace_date) as Endace_Pivot_to_Vision | parse regex \"(?<src_ip>\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3})\" | parse regex \"\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\, DstIP:\s(?<dest_ip>\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})\" | replace(Endace_Pivot_to_Vision, \"SOURCEIP\", src_ip) as Endace_Pivot_to_Vision | replace(Endace_Pivot_to_Vision, \"DESTIP\", dest_ip) as Endace_Pivot_to_Vision | tourl(endace_pivot_to_vision, \"Endace_Pivot_to_Vision\") as endace_pivot_to_vision",
)