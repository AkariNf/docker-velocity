import requests

def get_version(stable=0):
    response = requests.get("https://api.papermc.io/v2/projects/velocity")
    return response.json()["versions"][-1+stable]

def get_build(version, x=0):
    response = requests.get("https://api.papermc.io/v2/projects/velocity/versions/{}/builds".format(version))
    countVersion = len(response.json()["builds"]) - 1
    while countVersion >= 0:
        if response.json()["builds"][countVersion]["channel"] == "default":
            return version,  response.json()["builds"][countVersion]["build"]
        else:
            countVersion -= 1
    return get_build(version=get_version(stable=x-1), x=x-1)

def get_filename(version, build):
    response = requests.get("https://api.papermc.io/v2/projects/velocity/versions/{}/builds/{}".format(version, build))
    return response.json()["downloads"]["application"]["name"]
    
version , build = get_build(get_version())
filename = get_filename(version=version, build=build)

print("https://api.papermc.io/v2/projects/velocity/versions/{}/builds/{}/downloads/{}".format(version, build, filename))