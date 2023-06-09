# gitdevr <img src="man/figures/logo.png" align="right" height="139"/>

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)

<!-- badges: end -->

## Overview

**gitdevr** provides a custom [pkgdown](https://pkgdown.r-lib.org) template
based on the [GitDev skin](https://dieghernan.github.io/chulapa/skins/gitdev)
provided with my Jekyll theme [chulapa](https://dieghernan.github.io/chulapa/).

## Installation

You can install the developing version of **gitdevr** with:

``` r
devtools::install_github("dieghernan/gitdevr")
```

Alternatively, you can install **gitdevr** using the
[r-universe](https://dieghernan.r-universe.dev/pkgdev):

``` r
# Enable this universe
options(repos = c(
  dieghernan = "https://dieghernan.r-universe.dev",
  CRAN = "https://cloud.r-project.org"
))


install.packages("gitdevr")
```

## Usage

After the successful installation, if you already have your **pkgdown** setup
ready, you only need to specify the `template` parameter as follow. Then, as
before, you can build your site using `pkgdown::build_site()`.

``` yml
template:
  package: gitdevr
```

> Keep in mind that you should NOT use `default_assets: false` when you change
> the default template. **gitdevr** relies on some of the **pkgdown** assets and
> templates.

It is recommended to add the following line to your `DESCRIPTION`:

```         
Config/Needs/website: dieghernan/gitdevr
```

By doing so, when using [r-lib
actions](https://github.com/r-lib/actions/tree/v2-branch/setup-r-dependencies)
for deploying your site, the github action would install the package for you
automatically.
