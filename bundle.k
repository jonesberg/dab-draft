schema Bundle:
    cluster_id?: str
    compute_id?: str
    databricks_cli_version?: str
    git: Git
    # deployment: complex
    name: str

schema Git:
    branch?: str
    origin_url?: str

