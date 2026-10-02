

<!-- index.md is generated from index.qmd. Please edit that file -->

# gitdevr <a href="https://dieghernan.github.io/gitdevr/"><img src="man/figures/logo.png" alt="gitdevr home page" align="right" height="139"/></a>

<!-- badges: start -->

[![Project Status: Concept – Minimal or no implementation has been done
yet, or the repository is only intended to be a limited example, demo or
proof-of-concept.](https://www.repostatus.org/badges/latest/concept.svg)](https://www.repostatus.org/#concept)
[![R package check
status](https://github.com/dieghernan/gitdevr/actions/workflows/check-simple.yaml/badge.svg)](https://github.com/dieghernan/gitdevr/actions/workflows/check-simple.yaml)

<!-- badges: end -->

## Overview

**gitdevr** provides a custom [**pkgdown**](https://pkgdown.r-lib.org)
template based on the [**GitDev**
skin](https://dieghernan.github.io/chulapa/skins/gitdev) provided with
the [**chulapa**](https://dieghernan.github.io/chulapa/) **Jekyll**
theme.

See a preview of the template at
<https://dieghernan.github.io/gitdevr/>.

## Installation

You can install the development version of **gitdevr** by running:

``` r
pak::pak("dieghernan/gitdevr")
```

Alternatively, you can install **gitdevr** from
[**r-universe**](https://dieghernan.r-universe.dev/gitdevr):

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

After installing **gitdevr**, add the following `template` settings to
your `_pkgdown.yml` file. Then build your site with
`pkgdown::build_site()`.

<div class="code-with-filename">

<div class="code-with-filename-file">

<pre><strong>_pkgdown.yml</strong></pre>

``` yaml
template:
  bootstrap: 5
  package: gitdevr
```

</div>

</div>

<div class="callout callout-style-default callout-important callout-titled">
<div class="callout-header d-flex align-content-center">
<div class="callout-icon-container"><i class="callout-icon"></i></div>
<div class="callout-title-container flex-fill">Important</div>
</div>
<div class="callout-body-container callout-body">

Do not use `default_assets: false` with this template. **gitdevr**
relies on **pkgdown** assets and templates.

</div>
</div>

We recommend adding the following line to your `DESCRIPTION`:

<div class="code-with-filename">

<div class="code-with-filename-file">

<pre><strong>DESCRIPTION</strong></pre>

    Config/Needs/website: dieghernan/gitdevr

</div>

</div>

When you use [**r-lib
actions**](https://github.com/r-lib/actions/tree/v2-branch/setup-r-dependencies)
to deploy your site, **GitHub Actions** installs the package
automatically.
