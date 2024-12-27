import .resources.job as job
import .permissions
import .resources.tasks.tasks as task

my_job = job.Job {
    permissions = [permissions.Permission {
        level = "one"
    }]
    tasks = [
        task.SparkPythonTask {
            description = "Test"
            task_key = "Sample Task"
            spark_python_task = {
                python_file = "test.py"
            }
        },
        task.RunJobTask {
            task_key = "1"
            run_job_task = {
                job_id = 1
            }
        }
    ]
    run_as = None
    max_concurrent_runs = -1
}
