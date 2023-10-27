#!/usr/bin/env python
# Usage:
# python delete_app.py -a <app uuid> -u <access_id>:<access_key> -d <deployment>

from argparse import ArgumentParser
import logging
from common import make_request, get_endpoint
from requests.auth import HTTPBasicAuth

logging.basicConfig(level=logging.INFO)


def prep_parser():
    parser = ArgumentParser(description='Script to push an app to production.')
    parser.add_argument("-a", dest="app_uuid", help="app uuid ",
                        required=True)
    parser.add_argument("-u", dest="userauth", help="access_id:access_key", required=True)
    parser.add_argument("-d", dest="deployment", help="deployment name", required=True)

    return parser.parse_args()


def delete_app_api(deployment, app_uuid, access_id, access_key):
    endpoint = get_endpoint(deployment)
    api_url = "%s/%s" % (endpoint, app_uuid)
    status, response = make_request(api_url, access_id, access_key, method='DELETE')
    return status, response


def delete_app():
    parsed_args = vars(prep_parser())
    app_uuid = parsed_args['app_uuid']
    access_id, access_key = parsed_args['userauth'].split(":")
    deployment = parsed_args['deployment']
    status, response = delete_app_api(deployment, app_uuid, access_id, access_key)
    if status:
        print("App with uuid: %s was deleted successfully" % app_uuid)
    else:
        print("App  with uuid: %s failed to be pushed response: %s" % (app_uuid, response))


if __name__ == '__main__':
    delete_app()
