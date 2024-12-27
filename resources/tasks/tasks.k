import .base_task

type Task = SparkPythonTask | SqlTask | RunJobTask

schema SparkPythonTask(base_task.BaseTask):
    spark_python_task: SparkPythonTaskParams

schema SqlTask(base_task.BaseTask):
    sql_task = SqlTaskParams

schema RunJobTask(base_task.BaseTask):
    """The task triggers another job when the `run_job_task` field is present."""
    run_job_task: RunJobTaskParams

schema PipelineTask(base_task.BaseTask):
    pipeline_task: PipelineTaskParams

schema SqlTaskParams:
    """The task runs a SQL query or file, or it refreshes a SQL alert or a legacy SQL dashboard when the `sql_task` field is present.'},
    """
    alert?: SqlTaskAlert
    dashboard?: SqlTaskDashboard
    file?: SqlTaskFile
    query?: SqlTaskQuery
    warehouse_id: str

schema SqlTaskFile:
    """
    If file, indicates that this job runs a SQL file in a remote Git repository.
    """
    alert: SqlTaskAlert
    path: str
    source?: "WORKSPACE" | "GIT"
    parameters: {str:str}

schema SqlTaskAlert:
    """
    """
    alert_id = str
    pause_subscriptions?: bool
    subscriptions?: [Subscription]

schema Subscription:
    """
    If specified, alert notifications are sent to subscribers.
    """
    destination_id?: str
    user_name?: str

schema SqlTaskDashboard:
    custom_subject?: str
    dashboard_id: str
    pause_subscriptions?: bool
    subscriptions?: [Subscription]

schema SqlTaskQuery:
    query_id: str

schema SparkPythonTaskParams:
    """The task runs a Python file when the `spark_python_task` field is present.

    Attributes
    ----------
    parameters
        Command line parameters passed to the Python file.
        Use [Task parameter variables](https://docs.databricks.com/jobs.html#parameter-variables) to set parameters containing information about job runs.'},
    python_file
    source
    """
    parameters?: [str]
    python_file: str
    source?: "WORKSPACE" | "GIT"

schema RunJobTaskParams:
    """The task triggers another job when the `run_job_task` field is present.

    Attributes
    ----------
    dbt_commands
        An array of commands to execute for jobs with the dbt task, for example
        `\"dbt_commands\": [\"dbt deps\", \"dbt seed\", \"dbt deps\", \"dbt seed\", \"dbt run\"]`
    jar_params
        A list of parameters for jobs with Spark JAR tasks, for example
        `\"jar_params\": [\"john doe\", \"35\"]`.\nThe parameters are used to invoke the main function of the main class specified in the Spark JAR task.\nIf not specified upon `run-now`, it defaults to an empty list.\njar_params cannot be specified in conjunction with notebook_params.\nThe JSON representation of this field (for example `{\"jar_params\":[\"john doe\",\"35\"]}`) cannot exceed 10,000 bytes.\n\nUse [Task parameter variables](https://docs.databricks.com/jobs.html#parameter-variables) to set parameters containing information about job runs.
    job_id
        ID of the job to trigger.
    job_parameters
        Job-level parameters used to trigger the job.
    notebook_params
        A map from keys to values for jobs with notebook task, for example
        `\"notebook_params\": {\"name\": \"john doe\", \"age\": \"35\"}`. The
        map is passed to the notebook and is accessible through the
        [dbutils.widgets.get](https://docs.databricks.com/dev-tools/databricks-utils.html)
        function. If not specified upon `run-now`, the triggered run uses the
        job’s base parameters. notebook_params cannot be specified in
        conjunction with jar_params. Use [Task parameter
        variables](https://docs.databricks.com/jobs.html#parameter-variables) to
        set parameters containing information about job runs. The JSON
        representation of this field (for example
        `{\"notebook_params\":{\"name\":\"john doe\",\"age\":\"35\"}}`) cannot
        exceed 10,000 bytes.
    pipeline_params
    python_named_params
    python_params
        A list of parameters for jobs with Python tasks, for example
        `\"python_params\": [\"john doe\", \"35\"]`. The parameters are passed
        to Python file as command-line parameters. If specified upon `run-now`,
        it would overwrite the parameters specified in job setting. The JSON
        representation of this field (for example `{\"python_params\":[\"john
        doe\",\"35\"]}`) cannot exceed 10,000 bytes. Use [Task parameter
        variables](https://docs.databricks.com/jobs.html#parameter-variables) to
        set parameters containing information about job runs. Important These
        parameters accept only Latin characters (ASCII character set). Using
        non-ASCII characters returns an error. Examples of invalid, non-ASCII
        characters are Chinese, Japanese kanjis, and emojis.
    spark_submit_params
        A list of parameters for jobs with spark submit task, for example
        `\"spark_submit_params\": [\"--class\",
        \"org.apache.spark.examples.SparkPi\"]`.The parameters are passed to
        spark-submit script as command-line parameters. If specified upon
        `run-now`, it would overwrite theparameters specified in job setting.
        The JSON representation of this field (for example
        `{\"python_params\":[\"john doe\",\"35\"]}`)cannot exceed 10,000
        bytes.\nUse [Task parameter
        variables](https://docs.databricks.com/jobs.html#parameter-variables) to
        set parameters containing information about job runs\nImportant\n\nThese
        parameters accept only Latin characters (ASCII character set). Using
        non-ASCII characters returns an error.Examples of invalid, non-ASCII
        characters are Chinese, Japanese kanjis, and emojis.
    sql_params
        A map from keys to values for jobs with SQL task, for example
        `\"sql_params\": {\"name\": \"john doe\", \"age\": \"35\"}`. The SQL
        alert task does not support custom parameters.
    """
    dbt_commands?: [str]
    jar_params?: [str]
    job_id: int
    job_parameters?: {str:str}
    notebook_params?: [str]
    pipeline_params?: PipelineTaskParams
    python_named_params?: {str:str}
    spark_submit_params?: [str]
    sql_params?: {str:str}

schema PipelineTaskRunParams:
    """

    Attributes
    ----------
    full_refresh
        If true, triggers a full refresh on the delta live table.
    """
    full_refresh?: bool

schema PipelineTaskParams(PipelineTaskRunParams):
    """The task triggers a pipeline update when the `pipeline_task` field is present.
    Only pipelines configured to use triggered more are supported.

    Attributes
    ----------
    pipeline_id
        The full name of the pipeline task to execute.
    """
    pipeline_id: str
