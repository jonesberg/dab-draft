# dab-draft: a fresh take on defining Databricks Asset Bundles

dab-draft is a pre-processor for [Databricks Asset Bundles](https://docs.databricks.com/en/dev-tools/bundles/index.html) (DAB) that leverage the [KCL configuration language](https://kcl-lang.org/) for ease of authoring, extension, and maintainance.

Compared to the YAML approach, dab-draft in my opinion provides

* A friendlier, object-oriented-*(ish)* definition for bundles.
* Strong typing and value validation through the pre-processor (when applicable)
* Better re-usability across bundle defition through cleaner imports and variable expansion (when applicable).

Most of the advantages are provided by the KCL configuration language directly.

dab-draft is **not** a replacement for the Databricks CLI. It simply takes your configuration files in the KCL format and generates the `databricks.yml` that is used for assets bundle definition.

## How to use

_Note: I plan on writing a quick tutorial on how to use KCL in the context of dab-draft. In the meantime, review their [excellent tutorial](https://www.kcl-lang.io/docs/user_docs/getting-started/kcl-quick-start)!_

Create two files at the root of your project.

- `kcl.mod`
- `main.k` (you can call it whatever you want)

Then import dab-draft using the command line

``` sh
kcl mod add dab-draft
```

The `main.k` file in this repository gives a very simple example of using dab-draft to generate a bundle. To create the `databricks.yml` file:

``` sh
kcl main.k -o databricks.yml
```

## What works?

Currently, most of the objects for doing the tasks I'm interested in are working. See the documentation under `doc/dab-draft.md` for a detailled list of the objects and their attributes. This includes the following

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
