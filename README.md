# NullNumbers

[![Build Status](https://github.com/clguillot/NullNumbers/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/clguillot/NullNumbers/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/clguillot/NullNumbers/branch/main/graph/badge.svg)](https://codecov.io/gh/clguillot/NullNumbers)
![License](https://img.shields.io/badge/license-MIT-blue.svg)

*NullNumbers* is a lightweight Julia package providing a numeric type that can explicitly represent a “null” value while still participating in arithmetic.
Null values act as a zero-like element: they are neutral for addition but absorb any numeric operand in multiplication.
 
## Usage

```
julia> NullNumber() + 10.5
10.5

julia> NullNumber() * Rational(1, 3)
NullNumber()

julia> NullNumber() / 2
NullNumber()

julia> NullNumber()^3
NullNumber()

julia> NullNumber() < 5
true
```

## Features

- A custom numeric type representing a null number
- Basic arithmetic operations and functions
- Useful to generate an instance of a function with hardcoded null parameters
- Seamless integration with Julia's type system

### `imagz`

`imagz(x)` is similar to `imag(x)`, except that it returns `NullNumber()`
for any non-`Complex` input.

```julia
julia> imagz(3.0)
NullNumber()

julia> imagz(1 + 2im)
2
```

## Semantics

`NullNumber` is a *hardcoded* zero, not the IEEE zero of `0.0`. It is meant for
cases where a parameter is known at compile time to be absent, so that the
compiler can eliminate the operations touching it. As a result, it does not
follow IEEE float semantics in a few places:

- `NullNumber() * NaN` and `NullNumber() * Inf` both evaluate to
  `NullNumber()`, not `NaN`.
- `NullNumber() / x` returns `NullNumber()`, even when `x = 0, or NaN`
- `x / NullNumber()` throws a `DivideError`, rather than returning `Inf`
  the way `x / 0.0` would.

### Power

`NullNumber()^x` returns `NullNumber()` when `real(x) > 0`, and throws a
`DomainError` otherwise (`real(x) <= 0`, or `real(x)` is `NaN`).

Conversely, `x^NullNumber()` always returns `one(x)` for any `x`, following
the usual `x^0 == 1` convention (including `Inf^0 == 1` and `NaN^0 == 1`).

## Installation

```julia
]add https://github.com/clguillot/NullNumbers
```
