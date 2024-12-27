schema Dependent:
    """An optional array of objects specifying the dependency graph of the task. All tasks specified in this field must complete before executing this task. The task will run only if the `run_if` condition is true.\nThe key is `task_key`, and the value is the name assigned to the dependent task.'},

    Attributes
    ----------
        outcome: str
            Can only be specified on condition task dependencies. The outcome of the dependent task that must be met for this task to run.
        task_key: str
            The name of the task this task depends on.
    """
    outcome?: str
    task_key: str



schema CRAN:
    """Specification of a CRAN library to be installed as part of the library.

    Attributes
    ----------
        package: str
            The name of the CRAN package to install.
        repo: str
            The repository where the package can be found. If not specified, the default CRAN repo is used.
    """
    package: str
    repo?: str

schema Maven:
    """Specification of a maven library to be installed. For example:\n`{ "coordinates": "org.jsoup:jsoup:1.7.2" }`'},

    Attributes
    ----------
        coordinates: str
            Gradle-style maven coordinates. For example: "org.jsoup:jsoup:1.7.2".'},
        exclusion: [str]
            List of dependences to exclude. For example: `["slf4j:slf4j", "*:hadoop-client"]`.\n\nMaven dependency exclusions:\nhttps://maven.apache.org/guides/introduction/introduction-to-optional-and-excludes-dependencies.html.'},
        repo: str
            Maven repo to install the Maven package from. If omitted, both Maven Central Repository\nand Spark Packages are searched.'}},
    """
    coordinates: str
    exclusion?: [str]
    repo?: str

schema PyPI:
    """Specification of a PyPi library to be installed. For example:\n`{ "package": "simplejson" }`'},

    Attributes
    ----------
        package: str
            The name of the pypi package to install. An optional exact version specification is also\nsupported. Examples: "simplejson" and "simplejson==3.8.0".'},
        repo: str
            The repository where the package can be found. If not specified, the default pip index is\nused.'}},
    """
    package: str
    repo?: str


schema Library:
    cran?: CRAN
    egg?: str
    jar?: str
    maven?: Maven
    pypi?: PyPI
    requirements?: str
    whl?: str

schema BaseTask:
    depends_on?: [Dependent]
    description?: str
    disable_auto_optimization?: bool
    # email_notifications TODO <-- Link to EmailNotifications
    environment_key?: str
    existing_cluster_id?: str
    # health TODO <-- Link to Health
    job_cluster_key?: str
    libraries?: [Library]
    max_retries?: int
    min_retry_interval_millis?: int
    # new_cluster TODO Cluster?
    # notification_settings TODO NotificationSettings?
    retry_on_timeout?: bool
    run_if?: "ALL_SUCCESS" | "ALL_DONE" | "NONE_FAILED" | "AT_LEAST_ONE_SUCCESS" | "ALL_FAILED" | "AT_LEAST_ONE_FAILED"
    task_key: str
    timeout_seconds?: int
    # webhook_notifications TODO <-- Webhook notifications
