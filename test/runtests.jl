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

    @test n ^ 2 == NullNumber()
    @test n ^ 2.0 == NullNumber()

    @test (2 :: Int) ^ n == one(Int)
    @test (2.0 :: Float64) ^ n == one(Float64)
    @test (1 + 2im) ^ n == one(Complex{Int}) || (1 + 2im) ^ n == one(ComplexF64)
end

@testset "muladd" begin
    n = NullNumber()
    @test muladd(n, n, n) == NullNumber()
    @test muladd(n, n, 3) == 3
    @test muladd(n, 5, 3) == 3
    @test muladd(5, n, 3) == 3
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
