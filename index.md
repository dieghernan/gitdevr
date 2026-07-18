# gitdevr

## Overview

**gitdevr** provides a custom [**pkgdown**](https://pkgdown.r-lib.org)
template based on the [GitDev
skin](https://dieghernan.github.io/chulapa/skins/gitdev) provided with
the [chulapa](https://dieghernan.github.io/chulapa/) Jekyll theme.

See a preview of the template at
<https://dieghernan.github.io/gitdevr/>.

## Installation

You can install the development version of **gitdevr** with:

``` r

pak::pak("dieghernan/gitdevr")
```

Alternatively, you can install **gitdevr** using the
[r-universe](https://dieghernan.r-universe.dev/gitdevr):

``` r

# Install gitdevr in R:
install.packages(
  "gitdevr",
  repos = c(
    "https://dieghernan.r-universe.dev",
    "https://cloud.r-project.org"
  )
)
```

## Usage

After installation, if your **pkgdown** setup is ready, specify the
`template` parameter as follows. Then, as before, build your site with
[`pkgdown::build_site()`](https://pkgdown.r-lib.org/reference/build_site.html).

    _pkgdown.yml

``` yaml
template:
  bootstrap: 5
  package: gitdevr
```

Important

Keep in mind that you should not use `default_assets: false` when you
use this template. **gitdevr** relies on some of the **pkgdown** assets
and templates.

It is recommended to add the following line to your `DESCRIPTION`:

    DESCRIPTION

``` R
Config/Needs/website: dieghernan/gitdevr
```

When you use [r-lib
actions](https://github.com/r-lib/actions/tree/v2-branch/setup-r-dependencies)
to deploy your site, GitHub Actions installs the package automatically.
