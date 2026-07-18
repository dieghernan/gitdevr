

<!-- README.md is generated from README.qmd. Please edit that file -->

# gitdevr <a href="https://dieghernan.github.io/gitdevr/"><img src="man/figures/logo.png" alt="gitdevr website" align="right" height="139"/></a>

<!-- badges: start -->

[![Project Status: Concept – Minimal or no implementation has been done
yet, or the repository is only intended to be a limited example, demo,
or
proof-of-concept.](https://www.repostatus.org/badges/latest/concept.svg)](https://www.repostatus.org/#concept)
[![.github/workflows/check-simple.yaml](https://github.com/dieghernan/gitdevr/actions/workflows/check-simple.yaml/badge.svg)](https://github.com/dieghernan/gitdevr/actions/workflows/check-simple.yaml)

<!-- badges: end -->

## Overview

**gitdevr** provides a custom [**pkgdown**](https://pkgdown.r-lib.org)
template based on the [GitDev
skin](https://dieghernan.github.io/chulapa/skins/gitdev) provided with the
[chulapa](https://dieghernan.github.io/chulapa/) Jekyll theme.

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
`pkgdown::build_site()`.

``` yaml
template:
  bootstrap: 5
  package: gitdevr
```

> [!IMPORTANT]
>
> Keep in mind that you should not use `default_assets: false` when you
> use this template. **gitdevr** relies on some of the **pkgdown** assets
> and templates.

It is recommended to add the following line to your `DESCRIPTION`:

    Config/Needs/website: dieghernan/gitdevr

When you use [r-lib
actions](https://github.com/r-lib/actions/tree/v2-branch/setup-r-dependencies)
to deploy your site, GitHub Actions installs the package automatically.
