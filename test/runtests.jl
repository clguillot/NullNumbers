using Test
using NullNumbers

@testset "NullNumber basics" begin
    @test NullNumber <: Number
    n = NullNumber()
    @test n isa NullNumber
end

@testset "Addition" begin
    n = NullNumber()
    @test n + n == NullNumber()
    @test n + 1 == 1
    @test 1 + n == 1
    @test n + 1.5 == 1.5
    @test 1.5 + n == 1.5
    @test n + (1 + 2im) == 1 + 2im
    @test (1 + 2im) + n == 1 + 2im
end

@testset "Subtraction" begin
    n = NullNumber()
    @test -n == NullNumber()
    @test n - n == NullNumber()
    @test n - 3 == -3
    @test 3 - n == 3
    @test n - (1 + 2im) == -(1 + 2im)
    @test (1 + 2im) - n == 1 + 2im
end

@testset "Multiplication" begin
    n = NullNumber()
    @test n * n == NullNumber()
    @test n * 5 == NullNumber()
    @test 5 * n == NullNumber()
    @test n * (1 + 2im) == NullNumber()
    @test (1 + 2im) * n == NullNumber()
end

@testset "Division / and \\" begin
    n = NullNumber()

    # /
    @test_throws DivideError n / n
    @test n / 5 == NullNumber()
    @test_throws DivideError 5 / n

    # \
    @test_throws DivideError n \ n
    @test 5 \ n == NullNumber()
    @test_throws DivideError n \ 5
end

@testset "Power" begin
    n = NullNumber()

    @test_throws DomainError n ^ n

    # positive real(exponent), literal and runtime, integer/real/complex
    @test n ^ 2 == NullNumber()
    @test n ^ 2.0 == NullNumber()
    p = 2; @test n ^ p == NullNumber()
    q = 2.0; @test n ^ q == NullNumber()
    @test n ^ Inf == NullNumber()
    @test n ^ (1 + 2im) == NullNumber()
    @test n ^ (1 + Inf * im) == NullNumber()   # matches 0.0^(1+Inf*im) == 0.0+0.0im
    @test n ^ (1 + NaN * im) == NullNumber()   # matches 0.0^(1+NaN*im) == 0.0+0.0im

    # real(x) <= 0 (or NaN) is not handled (avoids type instability) and always throws,
    # matching 0.0^x == NaN whenever real(x) <= 0
    @test_throws DomainError n ^ 0
    @test_throws DomainError n ^ NaN
    @test_throws DomainError n ^ (-1.5)
    @test_throws DomainError n ^ (0 + 2im)
    @test_throws DomainError n ^ (-1 + 2im)
    @test_throws DomainError n ^ (NaN + 1im)
    r = -1; @test_throws DomainError n ^ r

    # Negative *integer literal* exponents are a documented exception: Julia lowers
    # `n^(-1)` to `inv(n)^1` via `literal_pow` before our `^` method ever runs, so it
    # throws DivideError (from `inv`) instead of the DomainError a runtime exponent
    # of the same value would throw. This is intentional (see README "Semantics").
    @test_throws DivideError n ^ (-1)
    @test_throws DivideError n ^ (-2)

    @test (2 :: Int) ^ n === one(Int)
    @test (2.0 :: Float64) ^ n === one(Float64)
    @test (1 + 2im) ^ n === one(Complex{Int})
end

@testset "muladd" begin
    n = NullNumber()
    @test muladd(n, n, n) == NullNumber()
    @test muladd(n, n, 3) == 3
    @test muladd(n, 5, 3) == 3
    @test muladd(5, n, 3) == 3
end

@testset "fma" begin
    n = NullNumber()
    @test fma(n, n, n) == NullNumber()
    @test fma(n, n, 3) == 3
    @test fma(n, 5, 3) == 3
    @test fma(5, n, 3) == 3
end

@testset "Other functions" begin
    n = NullNumber()

    # inv
    @test_throws DivideError inv(n)

    # sqrt / cbrt
    @test sqrt(n) == NullNumber()
    @test cbrt(n) == NullNumber()

    # abs / abs2
    @test abs(n) == NullNumber()
    @test abs2(n) == NullNumber()

    # exp / exp2 / cis
    @test exp(n) === true
    @test exp2(n) === true
    @test cis(n) === true

    # hypot
    @test hypot(n, n) == NullNumber()

    # real / imag / conj
    @test real(n) == NullNumber()
    @test imag(n) == NullNumber()
    @test conj(n) == NullNumber()
end

@testset "Comparisons" begin
    n = NullNumber()
    @test iszero(n) === true
    @test n == n
    @test !(n < n)
    @test n <= n
    @test n >= n
    @test !(n > n)
    @test isless(n, n) === false

    # mixed NullNumber / Real comparisons
    @test n < 5
    @test !(n < -5)
    @test -5 < n
    @test !(5 < n)
    @test n <= 0
    @test 0 <= n
    @test n >= 0
    @test 5 > n
    @test !(n > 5)
    @test isless(n, 5)
    @test isless(-5, n)
    @test !isless(n, -5)

    @test sort(Any[n, 5, -3]) == [-3, n, 5]
end

@testset "imagz" begin
    n = NullNumber()
    @test imagz(3) == NullNumber()
    @test imagz(3.5) == NullNumber()
    @test imagz(n) == NullNumber()
    @test imagz(1 + 2im) == 2
end

@testset "zero / convert / promote" begin
    n = NullNumber()

    @test zero(NullNumber) isa NullNumber
    @test zero(n) isa NullNumber

    @test convert(Float64, n) == 0.0
    @test convert(Int, n) == 0

    @test promote_type(NullNumber, Float64) == Float64
    @test promote_type(NullNumber, Int) == Int

    a, b = promote(n, 1.0)
    @test a == 0.0
    @test b == 1.0
    @test typeof(a) == Float64
    @test typeof(b) == Float64

    c, d = promote(n, 2)
    @test c == 0
    @test d == 2
    @test typeof(c) == Int
    @test typeof(d) == Int

    @test n + 1.0 == 1.0
    @test 1.0 + n == 1.0
    @test 2 * n == NullNumber()
    @test n * 2 == NullNumber()
end
