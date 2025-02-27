#!/usr/bin/env python3

import json

VAR_PATTERN = {
    "type": "string",
    "pattern": "\\$\\{(var(\\.[a-zA-Z]+([-_]?[a-zA-Z0-9]+)*(\\[[0-9]+\\])*)+)\\}",
}

DONE_REFERENCES = set()
DUMMY_REFERENCES = {
    "#/$defs/string",
    "#/$defs/bool",
    "#/$defs/int",
    "#/$defs/map/string",
    "#/$defs/slice/string",
}

schema = json.load(open("./schema-20250129.json"))


test_ref = "#/$defs/map/github.com/databricks/cli/bundle/config.Artifact"


def extract_ref(doc, ref):
    if not isinstance(ref, str):
        ref = ref.get("$ref")

    if ref in DONE_REFERENCES and ref not in DUMMY_REFERENCES:
        print(f"{ref} already KCL-ed!")
    DONE_REFERENCES.add(ref)

    if ref in DUMMY_REFERENCES:
        return ref

    drill_down = ref.split("/")[1:]
    answer = doc
    for i in drill_down:
        answer = answer.get(i)
    return clean_anyOf(answer)


def clean_anyOf(doc):
    answer = doc
    if "anyOf" in doc.keys():
        answer = [t for t in doc["anyOf"] if t != VAR_PATTERN]
        assert len(answer) == 1
        answer = answer[0]
    if "oneOf" in doc.keys():
        answer = [t for t in doc["oneOf"] if t != VAR_PATTERN]
        assert len(answer) == 1
        answer = answer[0]
    return answer


def extract_schema(ref):
    return extract_ref(schema, ref)


# Top level
schema_properties = schema.get("properties").keys()

# Artifacts/done
artifact = extract_ref(schema, schema.get("properties").get("artifacts"))
artifact_add_properties = extract_ref(schema, artifact.get("additionalProperties"))

artifact_properties = {
    k: extract_schema(v) for k, v in artifact_add_properties.get("properties").items()
}

artifact_properties_items = extract_schema(
    artifact_properties.get("files").get("items")
)

# Bundle/done
bundle = extract_schema(schema.get("properties").get("bundle"))
bundle_properties = {k: extract_schema(v) for k, v in bundle.get("properties").items()}

bundle_deployment = {
    k: extract_schema(v)
    for k, v in bundle_properties.get("deployment").get("properties").items()
}

# Experimental/done
experimental = extract_schema(schema.get("properties").get("experimental"))
experimental_pydabs = extract_schema(experimental.get("properties").get("pydabs"))
experiment_scripts = extract_schema(
    extract_schema(experimental.get("properties").get("scripts")).get(
        "additionalProperties"
    )
)

# Permissions/done
permissions = extract_schema(schema.get("properties").get("permissions"))
permissions_items = extract_schema(permissions.get("items"))

# Presets/done
presets = extract_schema(schema.get("properties").get("presets"))

# Run as/done
run_as = extract_schema(schema.get("properties").get("run_as"))


# Sync/Done
sync = extract_schema(schema.get("properties").get("sync"))

# Targets
targets = extract_schema(schema.get("properties").get("targets"))
targets_add_properties = extract_schema(targets.get("additionalProperties"))

# Workspace/Done
workspace = extract_schema(schema.get("properties").get("workspace"))

# Resources/Done
resources = extract_schema(schema.get("properties").get("resources"))

r_clusters = extract_schema(resources.get("properties").get("clusters"))
r_clusters_add_properties = extract_schema(r_clusters.get("additionalProperties"))

r_dashboards = extract_schema(resources.get("properties").get("dashboards"))
r_dashboards_add_properties = extract_schema(r_dashboards.get("additionalProperties"))

r_experiments = extract_schema(resources.get("properties").get("experiments"))
r_experiments_add_properties = extract_schema(r_experiments.get("additionalProperties"))
r_experiments_tags = extract_schema(
    r_experiments_add_properties.get("properties").get("tags")
)
r_experiments_tag = extract_schema(r_experiments_tags.get("items"))

r_models = extract_schema(resources.get("properties").get("models"))
r_models_add_properties = extract_schema(r_models.get("additionalProperties"))
r_models_tags = extract_schema(r_models_add_properties.get("properties").get("tags"))
r_models_tag = extract_schema(r_models_tags.get("items"))

r_models_latest_versions = extract_schema(
    r_models_add_properties.get("properties").get("latest_versions")
)
r_models_latest_version = extract_schema(r_models_latest_versions.get("items"))
r_models_status = extract_schema(
    r_models_latest_version.get("properties").get("status")
)
r_models_lv_tags = extract_schema(r_models_latest_version.get("properties").get("tags"))
r_models_lv_tag = extract_schema(r_models_lv_tags.get("items"))


r_schemas = extract_schema(resources.get("properties").get("schemas"))
r_schemas_add_properties = extract_schema(r_schemas.get("additionalProperties"))
r_schemas_grants = extract_schema(
    r_schemas_add_properties.get("properties").get("grants")
)
r_schemas_grant = extract_schema(r_schemas_grants.get("items"))

# Resources/Not done

r_model_serving_endpoints = extract_schema(
    resources.get("properties").get("model_serving_endpoints")
)
r_model_serving_endpoints_add_properties = extract_schema(
    r_model_serving_endpoints.get("additionalProperties")
)
r_model_serving_endpoints_properties = {
    k: extract_schema(v)
    for k, v in r_model_serving_endpoints_add_properties.get("properties").items()
}

r_mse_ai_gateway = {
    k: extract_schema(v)
    for k, v in r_model_serving_endpoints_properties.get("ai_gateway")
    .get("properties")
    .items()
}

r_mse_ai_gateway_guardrails = {
    k: extract_schema(v)
    for k, v in r_mse_ai_gateway.get("guardrails").get("properties").items()
}

r_mse_ai_gateway_guardrails_pii = extract_schema(
    r_mse_ai_gateway_guardrails.get("input").get("properties").get("pii")
)

r_mse_ai_gateway_rate_limits = extract_schema(
    r_mse_ai_gateway.get("rate_limits").get("items")
)

r_mse_ai_gateway_usage_tracking_config = r_mse_ai_gateway.get("usage_tracking_config")

r_mse_config = {
    k: extract_schema(v)
    for k, v in r_model_serving_endpoints_properties.get("config")
    .get("properties")
    .items()
}

r_mse_config_served_entities = extract_schema(
    r_mse_config.get("served_entities").get("items")
)


r_mse_config_served_models = extract_schema(
    r_mse_config.get("served_models").get("items")
)

r_mse_config_external_model = extract_schema(
    "#/$defs/github.com/databricks/databricks-sdk-go/service/serving.ExternalModel"
)

r_mse_workload_size = extract_schema(
    "#/$defs/github.com/databricks/databricks-sdk-go/service/serving.ServedModelInputWorkloadSize"
)
r_mse_workload_type = extract_schema(
    "#/$defs/github.com/databricks/databricks-sdk-go/service/serving.ServedModelInputWorkloadType"
)

r_mse_config_traffic_routes = extract_schema(
    extract_schema(
        r_mse_config.get("traffic_config").get("properties").get("routes")
    ).get("items")
)

# Resources/notDone

r_pipelines = extract_schema(resources.get("properties").get("pipelines"))
r_pipelines_add_properties = extract_schema(r_pipelines.get("additionalProperties"))

r_quality_monitors = extract_schema(resources.get("properties").get("quality_monitors"))
r_registered_models = extract_schema(
    resources.get("properties").get("registered_models")
)
r_jobs = extract_schema(resources.get("properties").get("jobs"))
