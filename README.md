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
```

## Features

- A custom numeric type representing a null number
- Basic arithmetic operations and functions
- Useful to generate an instance of a function with hardcoded null parameters
- Seamless integration with Julia's type system  

## Installation

```julia
]add https://github.com/clguillot/NullNumbers
```
