#!/usr/bin/env python

import os
import sys
import csv
import json
# from subprocess import run

import requests
from sumologic import SumoLogic
from IPython import embed
from typing import Dict, Union
import logging
from http.client import HTTPConnection  # py3

PHYLUM_LTABLE_PATH = "/Library/Users/pete@phylum.com/phylum-threat-data/threat-test"

debug = False

if debug:
    log = logging.getLogger('urllib3')
    log.setLevel(logging.DEBUG)
    ch = logging.StreamHandler()
    ch.setLevel(logging.DEBUG)
    log.addHandler(ch)
    HTTPConnection.debuglevel = 1


class ThreatFeedImporter():
    def __init__(self):
        access_id = os.getenv("SUMOAID")
        access_key = os.getenv("SUMOAKEY")
        phylum_apitoken = os.getenv("PHYLUM_API_TOKEN")
        self.sumo = SumoLogic(access_id, access_key)
        self.phylum_token = phylum_apitoken
        # self.sl_threats = []

    def get_threatfeed_folder(self):
        personal = self.sumo.get_personal_folder().json()
        children = personal.get('children')
        phylum_folder_id = ""
        for elem in children:
            if elem.get('name') == "phylum-threat-data":
                phylum_folder_id = elem.get('id')
                print(f"[*] Found phylum-threat-data folder: {phylum_folder_id}")

        if phylum_folder_id != "":
            self.phylum_folder_id = phylum_folder_id
        else:
            sys.exit(1)

    # Did this manually
    # def create_lookup_table(self, name):

    def get_phylum_lookup_table(self, path):
        lookup_table = self.sumo.get_content_item_by_path(path).json()
        self.lookup_table_id = lookup_table.get('id')
        print(f"[*] Found lookup table ID: {self.lookup_table_id}")
        return

    # def get_phylum_token(self):
    #     get_token_command = ["phylum", "auth", "token", "-b"]
    #     process = run(get_token_command, text=True, capture_output=True)
    #     if process.returncode != 0:
    #         print(f"Get Token Command Failed: {process.returncode}")
    #         sys.exit(1)
    #     else:
    #         print(f"[*] Got Phylum Access Token")
    #         self.phylum_token = process.stdout.strip()
    #     return

    def get_phylum_threat_data(self):
        page = 1
        url = f"https://threats.phylum.io?per_page=50&page={page}"
        token_str = f"Bearer {self.phylum_token}"
        headers = {'Authorization': token_str}
        resp = requests.get(url, headers=headers)
        count = 1

        packages = []

        if resp.status_code != 200:
            print(f"Failed to call threat feed: {resp.status_code}")
            sys.exit(1)

        data = resp.json() 
        packages.extend(data.get('packages'))

        while data.get('has_next') == True:
            page += 1
            url = f"https://threats.phylum.io?per_page=50&page={page}"
            token_str = f"Bearer {self.phylum_token}"
            headers = {'Authorization': token_str}
            resp = requests.get(url, headers=headers)
            data = resp.json() 
            packages.extend(data.get('packages'))

            #has_more = data.get('has_next')
            # while has_more:
            #     count += 1
            #     add_url = f"{url}&page={count}"
            #     add_resp = requests.get(add_url, headers=headers)
            #     if add_resp.status_code != 200:
            #         print(f"Status Code = {add_resp.status_code}")
            #         break
            #     add_data = add_resp.json()
            #     data['packages'].extend(add_data['packages'])
            #     has_more = add_data.get('has_next')
            #     # if count > 100:
            #     #     break
        return packages


    def parse_key(self, element: Dict, key: str) -> Union[Dict, str]:
        temp = element.get(key, 'NA')
        if temp == 'NA':
            print(f"No key present for {key}")
            print(element)
            return ""
        else:
            return temp

    '''
    Take the indicators dict, then create a list of dicts each with a "name" and "value" key to store the data in a predictable format
    '''
    def parse_indicators(self, dictionary):
        ret_list = []

        for k,v in dictionary.items():
            new_dict = {}
            new_dict['name'] = k
            new_dict['val'] = v
            ret_list.append(new_dict)

        return ret_list


    def parse_threat_data(self, pkgs):
        # pkgs = threat_data.get('packages')

        with open('output.csv', 'w', newline='') as csv_file:
            writer = csv.writer(csv_file)

            temp_row = list(pkgs[0].keys())
            temp_row.append("ID")
            # ['created', 'ecosystem', 'hashes', 'indicators', 'name', 'version', 'ID']

            # write header row
            writer.writerow(temp_row)

            for elem in pkgs:
                created = self.parse_key(elem, 'created')
                ecosystem = self.parse_key(elem, 'ecosystem')
                indicators = json.dumps(self.parse_key(elem, 'indicators'))
                indicator_list = self.parse_indicators(self.parse_key(elem,'indicators'))

                name = self.parse_key(elem, 'name')
                version = self.parse_key(elem, 'version')

                hashes = self.parse_key(elem, 'hashes')
                if hashes is None:
                    temp_indicators = self.parse_key(elem, 'indicators')
                    rule = temp_indicators.get('dependency_confusion_rule')
                    if rule == True:
                        print(f"[SKIP] Dependency Confusion hit")
                        continue
                    else:
                        # print(f"[ERR] Shouldn't hit this")
                        indicator_string = ",".join(elem.get('indicators').keys())
                        print(f"[NOHASH] {ecosystem}-{name}-{version} : {indicator_string}")
                        # embed()
                elif len(hashes) == 1:
                    hashes = hashes[0]
                    threat_id = hashes.get('hash')
                else:
                    print(f"Calling multi-hash else clause")
                    for temphash in hashes:
                        finalhash = json.dumps(temphash)
                        finaltid = temphash.get('hash')
                        # self.write_hash(writer, created, ecosystem, finalhash, indicators, name, version, finaltid)
                        self.write_hash(writer, created, ecosystem, finalhash, indicator_list, name, version, finaltid)
                        print(f"Writing ID: {finaltid}")

                    continue

                    # hashes = hashes[0]
                    print(f"[E] Error: len(hashes) = {len(hashes)}")
                    # embed()

                newhashes = json.dumps(hashes)

                row = []
                row.append(created)
                row.append(ecosystem)
                row.append(newhashes)
                # row.append(indicators)
                row.append(indicator_list)
                row.append(name)
                row.append(version)
                row.append(threat_id)

                self.row = row

                writer.writerow(row)
                print(f"Writing ID: {threat_id}")


    def write_hash(self, writer, created, ecosystem, finalhash, indicators, name, version, finaltid):
        row = []
        row.append(created)
        row.append(ecosystem)
        row.append(finalhash)
        row.append(indicators)
        row.append(name)
        row.append(version)
        row.append(finaltid)
        writer.writerow(row)
        return


    def load_csv_file(self, filepath, filename):
        size_bytes = os.path.getsize("output.csv")
        size_mb = size_bytes / (1024 * 1024)
        if size_mb > 99:
            print("[i] SumoLogic only supports lookup tables with a maximum size of 100 MB")
            assert size_mb < 100, "CSV upload greater than 100MB"

        self.sumo.upload_csv_lookup_table(self.lookup_table_id, filepath, filename, True)
        print(f"[*] Loaded Sumologic with updated Phylum Threats")
        return
        

if __name__ == "__main__":
    obj = ThreatFeedImporter()
    obj.get_threatfeed_folder()
    obj.get_phylum_lookup_table(PHYLUM_LTABLE_PATH)
    threat_data = obj.get_phylum_threat_data()
    obj.parse_threat_data(threat_data)
    obj.load_csv_file("./", "output.csv")
    pkgs = threat_data.get('packages')
