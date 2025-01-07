# dab-draft: a fresh take on defining Databricks Asset Bundles

dab-draft is a pre-processor for [Databricks Asset Bundles](https://docs.databricks.com/en/dev-tools/bundles/index.html) (DAB) that leverage the [KCL configuration language](https://kcl-lang.org/) for ease of authoring, extension, and maintainance.

Compared to the YAML approach, dab-draft in my opinion provides

* A friendlier, object-oriented-*(ish)* definition for bundles.
* Strong typing and value validation through the pre-processor (when applicable)
* Better re-usability across bundle defition through cleaner imports and variable expansion (when applicable).

Most of the advantages are provided by the KCL configuration language directly.

dab-draft is **not** a replacement for the Databricks CLI. It simply takes your configuration files in the KCL format and generates the `databricks.yml` that is used for assets bundle definition.

## How to use

*Please note that dab-draft isn't 100% feature complete regarding the Databricks Assets Bundle.*

While this project is in alpha, there is not automated way to download and import the package. To use (or test) it, follow these instructions.

1. Clone this repository
2. _From the project where you plan to generate your `databricks.yml`, run the `kcl mod add ${DIRECTORY WHERE DAB-DRAFT IS DOWNLOADED}`
3. Use `kcl run ${YOUR KCL FILE} -o databricks.yml`


## What works?

Currently, most of the objects for doing basic data engineering tasks are working. See the documentation under `doc/dab-draft.md` for a detailled list of the objects and their attributes. This includes the following

* bundle
* artifact
* experimental
* permissions
* presets
* run_as
* sync
* workspaces
* **resources**
  * clusters
  * dashboards
  * schema
  * **tasks**
    * Spark Python
    * SQL
    * Run Job
    * Pipeline

I am adding new objects as my day job requires me to. I welcome ideas, bug fixes, contributions, and test cases. Please be patient for replies (vacations, other obligations, life).
