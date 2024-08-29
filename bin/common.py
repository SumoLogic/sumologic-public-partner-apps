import requests
from requests.auth import HTTPBasicAuth
import logging
import json

logging.basicConfig(level=logging.INFO)


def get_endpoint(deployment):
    deploy_map = {
        "syd": "au",
        "mum": "in",
        "dub": "eu",
        "fra": "de",
        "fed": "fed",
        "jp": "jp",
        "mon": "ca",
        "us2": "us2",
        "kr": "kr"
    }
    if deployment in ("us1", "prod"):
        return "https://api.sumologic.com/api/v1/content/app"
    if deployment in deploy_map:
        return "https://api.%s.sumologic.com/api/v1/content/app" % deploy_map[deployment]
    else:
        return 'https://%s-api.sumologic.net/api/v1/content/app' % deployment


def make_request(url, access_id, access_key, files=None, method="GET", **kwargsr):
    """
    Utility function to return make app push request
    :param url:
    :param access_id:
    :param access_key:
    :param files:
    :param is_first_submission:
    :param kwargsr:
    :return: status,data where  status = boolean indicating success or failure of the call, data is an object depending on the API call
    """
    status = None
    logging.debug("Calling %s: " % url)

    if method == "POST":
        response = requests.post(url=url, auth=HTTPBasicAuth(
            access_id, access_key), files=files)
    elif method == "DELETE":
        response = requests.delete(url=url, auth=HTTPBasicAuth(
            access_id, access_key))
    else:
        response = requests.get(url=url, auth=HTTPBasicAuth(
            access_id, access_key))
    status = True if response.status_code == 200 else False

    logging.debug("Got response code: %s Content:%s" % (response.status_code, response.content))
    try:
        if len(response.content) > 0:
            try:
                response = response.content.strip("\" '")
            except TypeError:
                # python 3
                response = response.content.strip(b"\" '")
            data = json.loads(response)
        else:
            data = {'error': "true", "message": response.status_code}
    except Exception as e:
        logging.error(e)
        data = {'error': "true", "message": response}
    if 'error' in data:
        # old API call so need to check for error again
        status = (data['error'] == "false")
    return status, data
