

<!-- index.md is generated from index.qmd. Please edit that file -->

# gitdevr <a href="https://dieghernan.github.io/gitdevr/"><img src="man/figures/logo.png" alt="gitdevr website" align="right" height="139"/></a>

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![.github/workflows/check-simple.yaml](https://github.com/dieghernan/gitdevr/actions/workflows/check-simple.yaml/badge.svg)](https://github.com/dieghernan/gitdevr/actions/workflows/check-simple.yaml)

<!-- badges: end -->

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
install.packages(
  "gitdevr",
  repos = c(
    "https://dieghernan.r-universe.dev",
    "https://cloud.r-project.org"
  )
)
```

## Usage

After the successful installation, if you already have your **pkgdown**
setup ready, you only need to specify the `template` parameter as
follow. Then, as before, you can build your site using
`pkgdown::build_site()`.

<div class="code-with-filename">

<div class="code-with-filename-file">

<pre><strong>.pkgdown.yaml</strong></pre>

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

Keep in mind that you should NOT use `default_assets: false` when you
change the default template. **gitdevr** relies on some of the
**pkgdown** assets and templates.

</div>
</div>

It is recommended to add the following line to your `DESCRIPTION`:

<div class="code-with-filename">

<div class="code-with-filename-file">

<pre><strong>DESCRIPTION</strong></pre>

    Config/Needs/website: dieghernan/gitdevr

</div>

</div>

By doing so, when using [r-lib
actions](https://github.com/r-lib/actions/tree/v2-branch/setup-r-dependencies)
for deploying your site, the github action would install the package for
you automatically.
