# gitdevr

## Overview

**gitdevr** provides a custom [pkgdown](https://pkgdown.r-lib.org)
template based on the [GitDev
skin](https://dieghernan.github.io/chulapa/skins/gitdev) provided with
my Jekyll theme [chulapa](https://dieghernan.github.io/chulapa/).

See a preview of the template in <https://dieghernan.github.io/gitdevr/>

## Installation

You can install the developing version of **gitdevr** with:

``` r
pak::pak("dieghernan/gitdevr")
```

Alternatively, you can install **gitdevr** using the
[r-universe](https://dieghernan.r-universe.dev/gitdevr):

``` r
# Install gitdevr in R:
install.packages("gitdevr", repos = c(
  "https://dieghernan.r-universe.dev",
  "https://cloud.r-project.org"
))
```

## Usage

After the successful installation, if you already have your **pkgdown**
setup ready, you only need to specify the `template` parameter as
follow. Then, as before, you can build your site using
[`pkgdown::build_site()`](https://pkgdown.r-lib.org/reference/build_site.html).

``` yml
template:
  bootstrap: 5
  package: gitdevr
```

> Keep in mind that you should NOT use `default_assets: false` when you
> change the default template. **gitdevr** relies on some of the
> **pkgdown** assets and templates.

It is recommended to add the following line to your `DESCRIPTION`:

``` R
Config/Needs/website: dieghernan/gitdevr
```

By doing so, when using [r-lib
actions](https://github.com/r-lib/actions/tree/v2-branch/setup-r-dependencies)
for deploying your site, the github action would install the package for
you automatically.
