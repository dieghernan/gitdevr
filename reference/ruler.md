# Print a console ruler

Print a console ruler

## Usage

``` r
ruler(width = getOption("width"))
```

## Arguments

- width:

  Width of the ruler in characters.

## Value

[`NULL`](https://rdrr.io/r/base/NULL.html), invisibly.

## See also

[`base::cat()`](https://rdrr.io/r/base/cat.html) for the underlying
console output function and
[gitdevr-package](https://dieghernan.github.io/gitdevr/reference/gitdevr-package.md)
for an overview of the template.

Console and documentation helpers:
[`test()`](https://dieghernan.github.io/gitdevr/reference/test.md)

## Examples

``` r
ruler()
#> ----+----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8
#> 12345678901234567890123456789012345678901234567890123456789012345678901234567890
```
