import json
from pathlib import Path

from jsonref import replace_refs


jsonfile = "schema-20241127.json"

USELESS_TYPES = [
    {
        "type": "string",
        "pattern": "\\$\\{(resources(\\.[a-zA-Z]+([-_]?[a-zA-Z0-9]+)*(\\[[0-9]+\\])*)+)\\}",
    },
    {
        "type": "string",
        "pattern": "\\$\\{(bundle(\\.[a-zA-Z]+([-_]?[a-zA-Z0-9]+)*(\\[[0-9]+\\])*)+)\\}",
    },
    {
        "type": "string",
        "pattern": "\\$\\{(workspace(\\.[a-zA-Z]+([-_]?[a-zA-Z0-9]+)*(\\[[0-9]+\\])*)+)\\}",
    },
    {
        "type": "string",
        "pattern": "\\$\\{(artifacts(\\.[a-zA-Z]+([-_]?[a-zA-Z0-9]+)*(\\[[0-9]+\\])*)+)\\}",
    },
    {
        "type": "string",
        "pattern": "\\$\\{(var(\\.[a-zA-Z]+([-_]?[a-zA-Z0-9]+)*(\\[[0-9]+\\])*)+)\\}",
    },
]


def process_type(t):
    if t == "boolean":
        return "bool"
    if t == "integer":
        return "int"
    if t == "string":
        return "str"
    return t


def clean_object(obj, i=0):
    if i > 10:
        return obj

    obj = obj.copy()
    # Remove the layer of `AnyOf`
    if "anyOf" in obj.keys():
        # we filter the object
        res = [x for x in obj["anyOf"] if x not in USELESS_TYPES and x]
        if len(res) == 1:
            obj = res[0]
        else:
            raise ValueError(f"Multiple types for property {res}")

    # Scalar types are easy to process, we just take care of the enums
    SCALAR_TYPES = ("string", "integer", "boolean")
    if (t := obj.get("type")) in SCALAR_TYPES:

        if obj.get("enum"):
            t = " | ".join(f'"{w}"' for w in obj["enum"])
            obj["type"] = t
            del obj["enum"]

    # Process array
    if obj.get("type") == "array":
        obj["items"] = clean_object(obj["items"], i + 1)

    # Process properties
    if obj.get("type") == "object" and obj.get("properties"):
        obj["properties"] = {
            k: clean_object(v, i + 1) for k, v in obj["properties"].items()
        }

    # Process properties
    if obj.get("type") == "object" and obj.get("additionalProperties"):
        obj["additionalProperties"] = clean_object(obj["additionalProperties"], i + 1)

    return obj


def pretty_print(clean_obj):
    if description := clean_obj.get("description"):
        print(description)
    required = clean_obj.get("required")
    if not required:
        required = []
    if clean_obj.get("properties"):
        for k, v in clean_obj["properties"].items():
            print(
                "{}{}: {}".format(
                    k, "?" if k not in required else "", process_type(v.get("type"))
                )
            )
            if d := v.get("description"):
                print("    {}".format(d))
    if clean_obj.get("additionalProperties"):
        print("Additional Properties!")
        pretty_print(clean_obj["additionalProperties"])


def load_json(file):
    with open(file, "r") as f:
        data = json.load(f)
    return data


doc: dict = replace_refs(
    load_json(jsonfile),
    merge_props=True,
    base_uri=Path(jsonfile).absolute().as_uri(),
)

print("Top-level objects")
print("==================")
for x in doc.get("properties").keys():
    print(x)
print()

resources = doc["properties"]["resources"]["anyOf"][0]

print("Resources")
print("=========")
for x in resources.get("properties").keys():
    print(x)

task = resources["properties"]["jobs"]["anyOf"][0]["additionalProperties"]["anyOf"][0][
    "properties"
]["tasks"]["anyOf"][0]["items"]
# Note: does not work with `lookup`

cluster = resources["properties"]["jobs"]["anyOf"][0]["additionalProperties"]["anyOf"][
    0
]["properties"]["job_clusters"]
