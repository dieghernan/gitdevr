# quarto features

## Citations

- Citation: Wickham ([2014](#ref-JSSv059i10))

## Code annotations

``` r
library(tidyverse)
library(palmerpenguins)
1penguins |>
2  mutate(
    bill_ratio = bill_depth_mm / bill_length_mm,
    bill_area  = bill_depth_mm * bill_length_mm
  )
```

- 1:

  Take `penguins`, and then,

- 2:

  add new columns for the bill ratio and bill area.

## Code filename

    matplotlib.py

``` python
import matplotlib.pyplot as plt
plt.plot([1,23,2,4])
plt.show()
```

## Callout Blocks

> **None**
>
> Note
>
> Note that there are five types of callouts, including: `note`, `tip`,
> `warning`, `caution`, and `important`.

> **None**
>
> Warning
>
> Callouts provide a simple way to attract attention, for example, to
> this warning.

> **None**
>
> Important
>
> The callout heading is provided by the callout type, with the expected
> heading (i.e., Note, Warning, Important, Tip, or Caution).

> **None**
>
> TipTip With Title
>
> This is an example of a callout with a title. Providing a callout
> heading is optional.

Simple

> **None**
>
> NotePay Attention
>
> Using callouts is an effective way to highlight content that your
> reader give special consideration or attention.

No icon

> **None**
>
> NotePay Attention
>
> Using callouts is an effective way to highlight content that your
> reader give special consideration or attention.

## Diagrams

``` mermaid
flowchart LR
  A[Hard edge] --> B(Round edge)
  B --> C{Decision}
  C --> D[Result one]
  C --> E[Result two]
```

## HTML widgets

## Keyboard

- Keyboard shortcut: Shift-Ctrl-PShift-Ctrl-P

## References

Wickham, Hadley. 2014. “Tidy Data.” *Journal of Statistical Software,
Articles* 59 (10): 1–23. <https://doi.org/10.18637/jss.v059.i10>.
