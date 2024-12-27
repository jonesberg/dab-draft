import ..permissions
import ..run_as
import .tasks.tasks

schema Environment:
    """ A list of task execution environment specifications that
    can be referenced by serverless tasks of this job.\nAn environment is
    required to be present for serverless tasks.\nFor serverless notebook tasks,
    the environment is accessible in the notebook environment panel.\nFor other
    serverless tasks, the task environment is required to be specified using
    environment_key in the task settings.'}

    Attributes
    ----------
        environment_key: str
            The key of an environment. It has to be unique within a job.
        spec: EnvironmentSpec
    """
    environment_key: str
    spec?: EnvironmentSpec

schema EnvironmentSpec:
    """The environment entity used to preserve serverless environment side panel
    and jobs' environment for non-notebook task. In this minimal environment spec,
    only pip dependencies are supported.

    Attributes
    ----------
        client: str
            Client version used by the environment\nThe client is the user-facing environment of the runtime.\nEach client comes with a specific set of pre-installed libraries.\nThe version is a string, consisting of the major client version.'},
        dependencies: [str]
            List of pip dependencies, as supported by the version of pip in this environment.\nEach dependency is a pip requirement file line https://pip.pypa.io/en/stable/reference/requirements-file-format/\nAllowed dependency could be <requirement specifier>, <archive url/path>, <local project path>(WSFS or Volumes in Databricks), <vcs project url>\nE.g. dependencies: ["foo==0.0.1", "-r /Workspace/test/requirements.txt"]'}},
    """
    client: str
    dependencies?: [str]

schema GitSource:
    """An optional specification for a remote Git repository containing the source code used by tasks. Version-controlled source code is supported by notebook, dbt, Python script, and SQL File tasks.\n\nIf `git_source` is set, these tasks retrieve the file from the remote repository by default. However, this behavior can be overridden by setting `source` to `WORKSPACE` on the task.\n\nNote: dbt and SQL File tasks support only version-controlled sources. If dbt or SQL File tasks are used, `git_source` must be defined on the job.',

    Attributes
    ----------
       git_branch: str
            Name of the branch to be checked out and used by this job. This field cannot be specified in conjunction with git_tag or git_commit.
       git_commit: str
            Commit to be checked out and used by this job. This field cannot be specified in conjunction with git_branch or git_tag.
       git_provider: "gitHub" | "bitbucketCloud" | "azureDevOpsServices" | "gitHubEnterprise" | "bitbucketServer" | "gitLab" | "gitLabEnterpriseEdition"| "awsCodeCommit"
            Unique identifier of the service used to host the Git repository. The value is case insensitive.
       git_tag: str
           Name of the tag to be checked out and used by this job. This field cannot be specified in conjunction with git_branch or git_commit.
       git_url: str
           URL of the repository to be cloned by this job.
    """
    git_branch?: str
    git_commit?: str
    # This below shows horribly in the doc. Check if sum types are done proper in KCL.
    git_provider: "gitHub" | "bitbucketCloud" | "azureDevOpsServices" | "gitHubEnterprise" | "bitbucketServer" | "gitLab" | "gitLabEnterpriseEdition" | "awsCodeCommit"
    git_tag?: str
    git_url: str

schema Health:
    rules: [HealthRule]

schema HealthRule:
    """An optional set of health rules that can be defined for this job.

    Attributes
    ----------
        metric: str
            Specifies the health metric that is being evaluated for a particular health rule.\n\n* `RUN_DURATION_SECONDS`: Expected total time for a run in seconds.\n* `STREAMING_BACKLOG_BYTES`: An estimate of the maximum bytes of data waiting to be consumed across all streams. This metric is in Private Preview.\n* `STREAMING_BACKLOG_RECORDS`: An estimate of the maximum offset lag across all streams. This metric is in Private Preview.\n* `STREAMING_BACKLOG_SECONDS`: An estimate of the maximum consumer delay across all streams. This metric is in Private Preview.\n* `STREAMING_BACKLOG_FILES`: An estimate of the maximum number of outstanding files across all streams. This metric is in Private Preview.',
        op: str
            Specifies the operator used to compare the health metric value with the specified threshold.',
        value: int
            Specifies the threshold value that the health metric should obey to satisfy the health rule.'}},
    """
    metric: "RUN_DURATION_SECONDS" | "STREAMING_BACKLOG_BYTES" | "STREAMING_BACKLOG_RECORDS" | "STREAMING_BACKLOG_SECONDS" | "STREAMING_BACKLOG_FILES"
    op: "GREATER_THAN"
    value: int

schema Continuous:
    """Indicate whether the continuous execution of the job is paused or not. Defaults to UNPAUSED.'}}, 'additionalProperties': False}, {'type': 'string', 'pattern': '\\$\\{(var(\\.[a-zA-Z]+([-_]?[a-zA-Z0-9]+)*(\\[[0-9]+\\])*)+)\\}'}], 'description': 'An optional continuous property for this job. The continuous property will ensure that there is always one run executing. Only one of `schedule` and `continuous` can be used.'},
    """
    pause_status: "UNPAUSED" | "PAUSED"

schema NotificationSettings:
    """Optional notification settings that are used when sending notifications to each of the `email_notifications` and `webhook_notifications` for this job.
    Attributes
    ----------
    no_alert_for_canceled_runs: bool
        If true, do not send notifications to recipients specified in `on_failure` if the run is canceled.'},
    no_alert_for_skipped_run: bool
        If true, do not send notifications to recipients specified in `on_failure` if the run is skipped.'}},
    """
    no_alert_for_canceled_runs: bool
    no_alert_for_skipped_run: bool

schema Parameter:
    """Job-level parameter definitions

    Attributes
    ----------
        default: str
            Default value of the parameter.'},
        name: str
            The name of the defined parameter. May only contain alphanumeric characters, `_`, `-`, and `.`'}},
    """
    default: str
    name: str

schema Queue:
    """The queue settings of the job.'},

    Attributes
    ----------
        enabled: bool
            If true, enable queueing for the job. This is a required field.'}},
    """
    enabled: bool

schema Schedule:
    """An optional periodic schedule for this job. The default behavior is that the job only runs when triggered by clicking “Run Now” in the Jobs UI or sending an API request to `runNow`.'},

    Attributes
    ----------
    pause_status?: "UNPAUSED" | "PAUSED"
        'Indicate whether this schedule is paused or not.'},
    quartz_cron_expression: str
        A Cron expression using Quartz syntax that describes the schedule for a job. See [Cron Trigger](http://www.quartz-scheduler.org/documentation/quartz-2.3.0/tutorials/crontrigger.html) for details. This field is required.'},
    timezone_id: str
        A Java timezone ID. The schedule for a job is resolved with respect to this timezone. See [Java TimeZone](https://docs.oracle.com/javase/7/docs/api/java/util/TimeZone.html) for details. This field is required.'}},
    """
    pause_status?: "UNPAUSED" | "PAUSED"
    quartz_cron_expression: str
    timezone_id: str

schema Job:
    budget_policy_id?: str
    continuous?: Continuous
    description?: str
    environments?: [Environment]
    email_notifications?: EmailNotifications
    git_source?: GitSource
    health?: Health
    # job_clusters?: [JobCluster] TODO CHECK IF IT'S THE SAME AT THE `CLUSTER DEFINITION`
    max_concurrent_runs?: int
    name?: str
    notification_settings?: NotificationSettings
    parameters?: [Parameter]
    permissions?: [permissions.Permission]
    queue?: Queue
    run_as?: run_as.RunAs
    schedule?: Schedule
    tags?: {str:str}
    tasks?: [tasks.Task]
    timeout_seconds?: int

# trigger TODO
# webhook_notifications TODO
schema EmailNotifications:
    """An optional set of email addresses that is notified when runs of this job begin or complete as well as when this job is deleted.'},

    Attributes
    ----------
        no_alert_for_skipped_runs: bool
            If true, do not send email to recipients specified in `on_failure` if the run is skipped.\nThis field is `deprecated`. Please use the `notification_settings.no_alert_for_skipped_runs` field.'},
        on_duration_warning_threshold_exceeded: [str]
            A list of email addresses to be notified when the duration of a run exceeds the threshold specified for the `RUN_DURATION_SECONDS` metric in the `health` field. If no rule for the `RUN_DURATION_SECONDS` metric is specified in the `health` field for the job, notifications are not sent.'},
        on_failure: [str]
            A list of email addresses to be notified when a run unsuccessfully completes. A run is considered to have completed unsuccessfully if it ends with an `INTERNAL_ERROR` `life_cycle_state` or a `FAILED`, or `TIMED_OUT` result_state. If this is not specified on job creation, reset, or update the list is empty, and notifications are not sent.'},
        on_start: [str]
            A list of email addresses to be notified when a run begins. If not specified on job creation, reset, or update, the list is empty, and notifications are not sent.'},
        on_streaming_backlog_exceeded: [str]
            A list of email addresses to notify when any streaming backlog thresholds are exceeded for any stream.\nStreaming backlog thresholds can be set in the `health` field using the following metrics: `STREAMING_BACKLOG_BYTES`, `STREAMING_BACKLOG_RECORDS`, `STREAMING_BACKLOG_SECONDS`, or `STREAMING_BACKLOG_FILES`.\nAlerting is based on the 10-minute average of these metrics. If the issue persists, notifications are resent every 30 minutes.'},
        on_success: [str]
            A list of email addresses to be notified when a run successfully completes. A run is considered to have completed successfully if it ends with a `TERMINATED` `life_cycle_state` and a `SUCCESS` result_state. If not specified on job creation, reset, or update, the list is empty, and notifications are not sent.'}},
    """
    no_alert_for_skipped_runs: bool
    on_duration_warning_threshold_exceeded: [str]
    on_failure: [str]
    on_start: [str]
    on_streaming_backlog_exceeded: [str]
    on_success: [str]

