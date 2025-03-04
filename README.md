# dab-draft: a fresh take on defining Databricks Asset Bundles

dab-draft is a pre-processor for [Databricks Asset Bundles](https://docs.databricks.com/en/dev-tools/bundles/index.html) (DAB) that leverage the [KCL configuration language](https://kcl-lang.org/) for ease of authoring, extension, and maintainance.

Compared to the YAML approach, dab-draft in my opinion provides

* A friendlier, object-oriented-*(ish)* definition for bundles.
* Strong typing and value validation through the pre-processor (when applicable)
* Better re-usability across bundle defition through cleaner imports and variable expansion (when applicable).

Most of the advantages are provided by the KCL configuration language directly.

dab-draft is **not** a replacement for the Databricks CLI. It simply takes your configuration files in the KCL format and generates the `databricks.yml` that is used for assets bundle definition.

## Why would you want to use dab-draft

So far, I've seen three primary use-cases where dab-draft is useful.

**Almost-identical configuration:** you have several jobs that require similar (but not quite identical) resources. As an example, you have set tags for workflows or have a base cluster configuration that you want to re-use for all your engineering. With dab-draft, you can create prototypes that you can extend as needed.

**Navigating the DAB documentation:** I find the KCL configuration language to be easier to navigate than the official Databricks Assets Bundle documentation or the JSONSchema. YMMV here, but starting from the objects I want to define and walking down the attributes is easier to me than grabbing a hugh schema.

**DAB configuration refactoring:** dab-draft makes IMO a cleaner and more modular asset bundle configuration, which makes modifying and updating your `databricks.yml` easier. I find myself starting with a base configuration and tweaking for resource allocation/costing/new dependencies (dashboards, models, etc.) as I go, so this helps me a lot.

## What you would not want to use dab-draft

dab-draft might not suit you if

**You need the latest configuration the day Databricks launches it:** Databricks' communication strategy around assets bundle is lacklustre, so I try to keep as close to the schema they define. Still, this project may trail behind a few days/weeks after a change happened in the configuration. During my free time, I'm building tooling to convert the schema into KCL configuration automatically, but it's not ready yet.

**You can't install KCL on your machine:** KCL is needed to run dab-draft. It's a single binary available for all major operating systems. If you can't get in on your machine/visible on your `PATH`, you won't be able to use dab-draft. The same applies if you materialize your DAB configuration from dab-draft in your CI/CD pipeline.

## How to use

_Note: I plan on writing a quick tutorial on how to use KCL in the context of dab-draft. In the meantime, review their [excellent tutorial](https://www.kcl-lang.io/docs/user_docs/getting-started/kcl-quick-start) for installation and getting started!_

Create two files at the root of your project.

- `kcl.mod`
- `main.k` (you can call it whatever you want, but for the example, I'll refer to the file by that name)

Then import dab-draft using the command line

``` sh
kcl mod add dab-draft
```

The `main.k` file in this repository gives a very simple example of using dab-draft to generate a bundle. To create the `databricks.yml` file:

``` sh
kcl main.k -o databricks.yml
```

> [!WARNING]
> If you use variable expansion within dab-draft (_e.g.,_ `$var.something`), you need to add a back-slash (`\$var.something`), otherwise, KCL will expand it prematurely. 

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
