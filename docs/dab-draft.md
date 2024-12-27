# dab-draft

## Index

- [Artifact](#artifact)
- [Bundle](#bundle)
- [File](#file)
- [Git](#git)
- [Permission](#permission)
- [Presets](#presets)
- [RunAs](#runas)
- [Sync](#sync)
- [Workspace](#workspace)
- resources
  - [Continuous](#continuous)
  - [EmailNotifications](#emailnotifications)
  - [Environment](#environment)
  - [EnvironmentSpec](#environmentspec)
  - [GitSource](#gitsource)
  - [Health](#health)
  - [HealthRule](#healthrule)
  - [Job](#job)
  - [NotificationSettings](#notificationsettings)
  - [Parameter](#parameter)
  - [Queue](#queue)
  - [Schedule](#schedule)
  - tasks
    - [BaseTask](#basetask)
    - [CRAN](#cran)
    - [Dependent](#dependent)
    - [Library](#library)
    - [Maven](#maven)
    - [PyPI](#pypi)
    - [RunJobTask](#runjobtask)
    - [RunJobTaskParams](#runjobtaskparams)
    - [SparkPythonTask](#sparkpythontask)
    - [SparkPythonTaskParams](#sparkpythontaskparams)
    - [SqlTask](#sqltask)
    - [SqlTaskAlert](#sqltaskalert)
    - [SqlTaskDashboard](#sqltaskdashboard)
    - [SqlTaskFile](#sqltaskfile)
    - [SqlTaskParams](#sqltaskparams)
    - [SqlTaskQuery](#sqltaskquery)
    - [Subscription](#subscription)

## Schemas

### Artifact

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**build**|str|||
|**executable**|str|||
|**files**|[[File](#file)]|||
|**path**|str|||
|**type** `required`|str|||
### Bundle

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**cluster_id**|str|||
|**compute_id**|str|||
|**databricks_cli_version**|str|||
|**git** `required`|[Git](#git)|||
|**name** `required`|str|||
### File

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**source** `required`|str|||
### Git

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**branch**|str|||
|**origin_url**|str|||
### Permission

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**group_name**|str|||
|**level** `required`|str|||
|**service_principal_name**|str|||
|**user_name**|str|||
### Presets

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**jobs_max_concurrent_runs**|int|||
|**name_prefix**|str|||
|**pipelines_development**|bool|||
|**tags**|{str:str}|||
|**trigger_pause_status**|str|||
### RunAs

Write-only setting. Specifies the user, service principal or group that the job/pipeline runs as. If not specified, the job/pipeline runs as the user who created the job/pipeline.  Exactly one of `user_name`, `service_principal_name`, `group_name` should be specified. If not, an error is thrown.',

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**service_principal_name** `required`|str|Application ID of an active service principal. Setting this field<br />requires the `servicePrincipal/user` role.||
|**user_name** `required`|str|The email of an active workspace user. Non-admin users can only set this<br />field to their own email.||
### Sync

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**exclude** `required`|[str]|||
|**include** `required`|[str]|||
|**paths** `required`|[str]|||
### Workspace

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**artifact_path**|str|||
|**auth_type**|str|||
|**azure_client_id** `required`|any|||
|**azure_environment** `required`|any|||
|**azure_login_app_id** `required`|any|||
|**azure_tenant_id** `required`|any|||
|**azure_use_msi** `required`|any|||
|**azure_workspace_resource_id** `required`|any|||
|**client_id** `required`|any|||
|**file_path** `required`|any|||
|**google_service_account** `required`|any|||
|**host** `required`|any|||
|**profile** `required`|any|||
|**resource_path** `required`|any|||
|**root_path** `required`|any|||
|**state_path** `required`|any|||
### Continuous

Indicate whether the continuous execution of the job is paused or not. Defaults to UNPAUSED.'}}, 'additionalProperties': False}, {'type': 'string', 'pattern': '\\$\\{(var(\\.[a-zA-Z]+([-_]?[a-zA-Z0-9]+)*(\\[[0-9]+\\])*)+)\\}'}], 'description': 'An optional continuous property for this job. The continuous property will ensure that there is always one run executing. Only one of `schedule` and `continuous` can be used.'},

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**pause_status** `required`|"UNPAUSED" | "PAUSED"|||
### EmailNotifications

An optional set of email addresses that is notified when runs of this job begin or complete as well as when this job is deleted.'},

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**no_alert_for_skipped_runs** `required`|bool|||
|**on_duration_warning_threshold_exceeded** `required`|[str]|||
|**on_failure** `required`|[str]|||
|**on_start** `required`|[str]|||
|**on_streaming_backlog_exceeded** `required`|[str]|||
|**on_success** `required`|[str]|||
### Environment

A list of task execution environment specifications that can be referenced by serverless tasks of this job.\nAn environment is required to be present for serverless tasks.\nFor serverless notebook tasks, the environment is accessible in the notebook environment panel.\nFor other serverless tasks, the task environment is required to be specified using environment_key in the task settings.'}

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**environment_key** `required`|str|||
|**spec**|[EnvironmentSpec](#environmentspec)|||
### EnvironmentSpec

The environment entity used to preserve serverless environment side panel and jobs' environment for non-notebook task. In this minimal environment spec, only pip dependencies are supported.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**client** `required`|str|||
|**dependencies**|[str]|||
### GitSource

An optional specification for a remote Git repository containing the source code used by tasks. Version-controlled source code is supported by notebook, dbt, Python script, and SQL File tasks.\n\nIf `git_source` is set, these tasks retrieve the file from the remote repository by default. However, this behavior can be overridden by setting `source` to `WORKSPACE` on the task.\n\nNote: dbt and SQL File tasks support only version-controlled sources. If dbt or SQL File tasks are used, `git_source` must be defined on the job.',

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**git_branch**|str|||
|**git_commit**|str|||
|**git_provider** `required`|"gitHub" | "bitbucketCloud" | "azureDevOpsServices" | "gitHubEnterprise" | "bitbucketServer" | "gitLab" | "gitLabEnterpriseEdition" | "awsCodeCommit"|||
|**git_tag**|str|||
|**git_url** `required`|str|||
### Health

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**rules** `required`|[[HealthRule](#healthrule)]|||
### HealthRule

An optional set of health rules that can be defined for this job.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**metric** `required`|"RUN_DURATION_SECONDS" | "STREAMING_BACKLOG_BYTES" | "STREAMING_BACKLOG_RECORDS" | "STREAMING_BACKLOG_SECONDS" | "STREAMING_BACKLOG_FILES"|||
|**op** `required` `readOnly`|"GREATER_THAN"||"GREATER_THAN"|
|**value** `required`|int|||
### Job

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**budget_policy_id**|str|||
|**continuous**|[Continuous](#continuous)|||
|**description**|str|||
|**email_notifications**|[EmailNotifications](#emailnotifications)|||
|**environments**|[[Environment](#environment)]|||
|**git_source**|[GitSource](#gitsource)|||
|**health**|[Health](#health)|||
|**max_concurrent_runs**|int|||
|**name**|str|||
|**notification_settings**|[NotificationSettings](#notificationsettings)|||
|**parameters**|[[Parameter](#parameter)]|||
|**permissions**|[[Permission](#permission)]|||
|**queue**|[Queue](#queue)|||
|**run_as**|[RunAs](#runas)|||
|**schedule**|[Schedule](#schedule)|||
|**tags**|{str:str}|||
|**tasks**|[[SparkPythonTask](#sparkpythontask)]|||
|**timeout_seconds**|int|||
### NotificationSettings

Optional notification settings that are used when sending notifications to each of the `email_notifications` and `webhook_notifications` for this job. Attributes ---------- no_alert_for_canceled_runs: bool If true, do not send notifications to recipients specified in `on_failure` if the run is canceled.'}, no_alert_for_skipped_run: bool If true, do not send notifications to recipients specified in `on_failure` if the run is skipped.'}},

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**no_alert_for_canceled_runs** `required`|bool|||
|**no_alert_for_skipped_run** `required`|bool|||
### Parameter

Job-level parameter definitions

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**default** `required`|str|||
|**name** `required`|str|||
### Queue

The queue settings of the job.'},

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**enabled** `required`|bool|||
### Schedule

An optional periodic schedule for this job. The default behavior is that the job only runs when triggered by clicking “Run Now” in the Jobs UI or sending an API request to `runNow`.'},

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**pause_status**|"UNPAUSED" | "PAUSED"|||
|**quartz_cron_expression** `required`|str|A Cron expression using Quartz syntax that describes the schedule for a job. See [Cron Trigger](http://www.quartz-scheduler.org/documentation/quartz-2.3.0/tutorials/crontrigger.html) for details. This field is required.'},||
|**timezone_id** `required`|str|A Java timezone ID. The schedule for a job is resolved with respect to this timezone. See [Java TimeZone](https://docs.oracle.com/javase/7/docs/api/java/util/TimeZone.html) for details. This field is required.'}},||
### BaseTask

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**depends_on**|[[Dependent](#dependent)]|||
|**description**|str|||
|**disable_auto_optimization**|bool|||
|**environment_key**|str|||
|**existing_cluster_id**|str|||
|**job_cluster_key**|str|||
|**libraries**|[[Library](#library)]|||
|**max_retries**|int|||
|**min_retry_interval_millis**|int|||
|**retry_on_timeout**|bool|||
|**run_if**|"ALL_SUCCESS" | "ALL_DONE" | "NONE_FAILED" | "AT_LEAST_ONE_SUCCESS" | "ALL_FAILED" | "AT_LEAST_ONE_FAILED"|||
|**task_key** `required`|str|||
|**timeout_seconds**|int|||
### CRAN

Specification of a CRAN library to be installed as part of the library.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**package** `required`|str|||
|**repo**|str|||
### Dependent

An optional array of objects specifying the dependency graph of the task. All tasks specified in this field must complete before executing this task. The task will run only if the `run_if` condition is true.\nThe key is `task_key`, and the value is the name assigned to the dependent task.'},

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**outcome**|str|||
|**task_key** `required`|str|||
### Library

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**cran**|[CRAN](#cran)|||
|**egg**|str|||
|**jar**|str|||
|**maven**|[Maven](#maven)|||
|**pypi**|[PyPI](#pypi)|||
|**requirements**|str|||
|**whl**|str|||
### Maven

Specification of a maven library to be installed. For example:\n`{ "coordinates": "org.jsoup:jsoup:1.7.2" }`'},

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**coordinates** `required`|str|||
|**exclusion**|[str]|||
|**repo**|str|||
### PyPI

Specification of a PyPi library to be installed. For example:\n`{ "package": "simplejson" }`'},

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**package** `required`|str|||
|**repo**|str|||
### RunJobTask

The task triggers another job when the `run_job_task` field is present.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**depends_on**|[[Dependent](#dependent)]|||
|**description**|str|||
|**disable_auto_optimization**|bool|||
|**environment_key**|str|||
|**existing_cluster_id**|str|||
|**job_cluster_key**|str|||
|**libraries**|[[Library](#library)]|||
|**max_retries**|int|||
|**min_retry_interval_millis**|int|||
|**retry_on_timeout**|bool|||
|**run_if**|"ALL_SUCCESS" | "ALL_DONE" | "NONE_FAILED" | "AT_LEAST_ONE_SUCCESS" | "ALL_FAILED" | "AT_LEAST_ONE_FAILED"|||
|**run_job_task** `required`|[RunJobTaskParams](#runjobtaskparams)|||
|**task_key** `required`|str|||
|**timeout_seconds**|int|||
### RunJobTaskParams

The task triggers another job when the `run_job_task` field is present.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**dbt_commands**|[str]|||
|**jar_params**|[str]|||
|**job_id** `required`|int|||
|**job_parameters**|{str:str}|||
|**notebook_params**|[str]|||
|**python_named_params**|{str:str}|||
|**spark_submit_params**|[str]|||
|**sql_params**|{str:str}|||
### SparkPythonTask

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**depends_on**|[[Dependent](#dependent)]|||
|**description**|str|||
|**disable_auto_optimization**|bool|||
|**environment_key**|str|||
|**existing_cluster_id**|str|||
|**job_cluster_key**|str|||
|**libraries**|[[Library](#library)]|||
|**max_retries**|int|||
|**min_retry_interval_millis**|int|||
|**retry_on_timeout**|bool|||
|**run_if**|"ALL_SUCCESS" | "ALL_DONE" | "NONE_FAILED" | "AT_LEAST_ONE_SUCCESS" | "ALL_FAILED" | "AT_LEAST_ONE_FAILED"|||
|**spark_python_task** `required`|[SparkPythonTaskParams](#sparkpythontaskparams)|||
|**task_key** `required`|str|||
|**timeout_seconds**|int|||
### SparkPythonTaskParams

The task runs a Python file when the `spark_python_task` field is present.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**parameters**|[str]|||
|**python_file** `required`|str|||
|**source**|"WORKSPACE" | "GIT"|||
### SqlTask

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**depends_on**|[[Dependent](#dependent)]|||
|**description**|str|||
|**disable_auto_optimization**|bool|||
|**environment_key**|str|||
|**existing_cluster_id**|str|||
|**job_cluster_key**|str|||
|**libraries**|[[Library](#library)]|||
|**max_retries**|int|||
|**min_retry_interval_millis**|int|||
|**retry_on_timeout**|bool|||
|**run_if**|"ALL_SUCCESS" | "ALL_DONE" | "NONE_FAILED" | "AT_LEAST_ONE_SUCCESS" | "ALL_FAILED" | "AT_LEAST_ONE_FAILED"|||
|**task_key** `required`|str|||
|**timeout_seconds**|int|||
### SqlTaskAlert

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**pause_subscriptions**|bool|||
|**subscriptions**|[[Subscription](#subscription)]|||
### SqlTaskDashboard

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**custom_subject**|str|||
|**dashboard_id** `required`|str|||
|**pause_subscriptions**|bool|||
|**subscriptions**|[[Subscription](#subscription)]|||
### SqlTaskFile

If file, indicates that this job runs a SQL file in a remote Git repository.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**alert** `required`|[SqlTaskAlert](#sqltaskalert)|||
|**parameters** `required`|{str:str}|||
|**path** `required`|str|||
|**source**|"WORKSPACE" | "GIT"|||
### SqlTaskParams

The task runs a SQL query or file, or it refreshes a SQL alert or a legacy SQL dashboard when the `sql_task` field is present.'},

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**alert**|[SqlTaskAlert](#sqltaskalert)|||
|**dashboard**|[SqlTaskDashboard](#sqltaskdashboard)|||
|**file**|[SqlTaskFile](#sqltaskfile)|||
|**query**|[SqlTaskQuery](#sqltaskquery)|||
|**warehouse_id** `required`|str|||
### SqlTaskQuery

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**query_id** `required`|str|||
### Subscription

If specified, alert notifications are sent to subscribers.

#### Attributes

| name | type | description | default value |
| --- | --- | --- | --- |
|**destination_id**|str|||
|**user_name**|str|||
<!-- Auto generated by kcl-doc tool, please do not edit. -->
