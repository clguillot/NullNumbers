module NullNumbers

export NullNumber
export imagz

struct NullNumber <: Number end

# +
@inline Base.:+(::NullNumber, ::NullNumber) = NullNumber()
@inline Base.:+(::NullNumber, x::Number) = x
@inline Base.:+(x::Number, ::NullNumber) = x
# -
@inline Base.:-(::NullNumber) = NullNumber()
@inline Base.:-(::NullNumber, ::NullNumber) = NullNumber()
@inline Base.:-(::NullNumber, x::Number) = -x
@inline Base.:-(x::Number, ::NullNumber) = x
# *
@inline Base.:*(::NullNumber, ::NullNumber) = NullNumber()
@inline Base.:*(::NullNumber, ::Number) = NullNumber()
@inline Base.:*(::Number, ::NullNumber) = NullNumber()
# /
@inline Base.:/(::NullNumber, ::NullNumber) = throw(DivideError())
@inline Base.:/(::NullNumber, ::Number) = NullNumber()
@inline Base.:/(::Number, ::NullNumber) = throw(DivideError())
# \
@inline Base.:\(::NullNumber, ::NullNumber) = throw(DivideError())
@inline Base.:\(::Number, ::NullNumber) = NullNumber()
@inline Base.:\(::NullNumber, ::Number) = throw(DivideError())
# ^
@inline Base.:^(::NullNumber, ::NullNumber) = throw(DomainError(NullNumber(), "NullNumber^NullNumber is undefined"))
function _pow_nullnumber(x::Number)
    real(x) > 0 && return NullNumber()
    throw(DomainError(x, "NullNumber^x is only defined for real(x) > 0"))
end
# A dedicated ::Integer method is required (not just ::Real) to disambiguate against
# Base's `^(x::Number, p::Integer)`, which would otherwise be equally specific.
@inline Base.:^(::NullNumber, x::Number) = _pow_nullnumber(x)
@inline Base.:^(::NullNumber, x::Integer) = _pow_nullnumber(x)
# Literal integer powers (e.g. `n^2`, `n^-1`) are routed by Base through `literal_pow`,
# which for negative literals calls `inv(x)` before ever reaching `^`. Overriding it here
# keeps literal and runtime exponents throwing the same DomainError.
@inline Base.literal_pow(::typeof(^), ::NullNumber, ::Val{p}) where p = _pow_nullnumber(p)
@inline Base.:^(::T, ::NullNumber) where T<:Number = one(T)

# muladd
@inline Base.muladd(::NullNumber, ::NullNumber, ::NullNumber) = NullNumber()
@inline Base.muladd(::NullNumber, ::NullNumber, x::Number) = x
@inline Base.muladd(::NullNumber, ::Number, x::Number) = x
@inline Base.muladd(::Number, ::NullNumber, x::Number) = x
@inline Base.fma(::NullNumber, ::NullNumber, ::NullNumber) = NullNumber()
@inline Base.fma(::NullNumber, ::NullNumber, x::Number) = x
@inline Base.fma(::NullNumber, ::Number, x::Number) = x
@inline Base.fma(::Number, ::NullNumber, x::Number) = x

# other functions
@inline Base.inv(::NullNumber) = throw(DivideError())
@inline Base.sqrt(::NullNumber) = NullNumber()
@inline Base.cbrt(::NullNumber) = NullNumber()
@inline Base.abs(::NullNumber) = NullNumber()
@inline Base.abs2(::NullNumber) = NullNumber()
@inline Base.exp(::NullNumber) = true
@inline Base.exp2(::NullNumber) = true
@inline Base.cis(::NullNumber) = true

@inline Base.hypot(::NullNumber, ::NullNumber) = NullNumber()

# Comparisons
# Ordering is only defined against Real (not Number/Complex in general), matching
# Base's own convention that `<`/`isless` aren't defined for complex numbers.
@inline Base.iszero(::NullNumber) = true
@inline Base.:(==)(::NullNumber, ::NullNumber) = true
@inline Base.isless(::NullNumber, ::NullNumber) = false
@inline Base.isless(::NullNumber, x::Real) = isless(0, x)
@inline Base.isless(x::Real, ::NullNumber) = isless(x, 0)
@inline Base.:<(::NullNumber, ::NullNumber) = false
@inline Base.:<(::NullNumber, x::Real) = 0 < x
@inline Base.:<(x::Real, ::NullNumber) = x < 0
@inline Base.:<=(::NullNumber, ::NullNumber) = true
@inline Base.:<=(::NullNumber, x::Real) = 0 <= x
@inline Base.:<=(x::Real, ::NullNumber) = x <= 0
@inline Base.:>(::NullNumber, ::NullNumber) = false
@inline Base.:>(::NullNumber, x::Real) = 0 > x
@inline Base.:>(x::Real, ::NullNumber) = x > 0
@inline Base.:>=(::NullNumber, ::NullNumber) = true
@inline Base.:>=(::NullNumber, x::Real) = 0 >= x
@inline Base.:>=(x::Real, ::NullNumber) = x >= 0

@inline Base.real(::NullNumber) = NullNumber()
@inline Base.imag(::NullNumber) = NullNumber()
@inline Base.conj(::NullNumber) = NullNumber()
@inline imagz(::Union{Real, NullNumber}) = NullNumber()
@inline imagz(z::Complex) = imag(z)

@inline Base.zero(::Type{NullNumber}) = NullNumber()
@inline Base.zero(::NullNumber) = NullNumber()
Base.convert(::Type{T}, ::NullNumber) where T<:Number = zero(T)
Base.promote_rule(::Type{NullNumber}, ::Type{T}) where T<:Number = T

end # module NullNumber

