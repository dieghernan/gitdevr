# Print a console ruler

Print a console ruler

## Usage

``` r
ruler(width = getOption("width"))
```

## Arguments

- width:

  Width of the ruler.

## Value

`NULL`, invisibly.

## See also

[`base::cat()`](https://rdrr.io/r/base/cat.html).

Console helpers:
[`test()`](https://dieghernan.github.io/gitdevr/reference/test.md)

## Examples

``` r
ruler()
#> ----+----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8
#> 12345678901234567890123456789012345678901234567890123456789012345678901234567890
```
