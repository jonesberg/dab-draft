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

TODO

## What works?

Currently, this project is in its infancy. I am still working through the best way to express the bundle definition, and I am adding fields as I need them for my day job. Contributions and debates are welcome.
