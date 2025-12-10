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
@inline Base.:^(::NullNumber, ::NullNumber) = throw(DomainError("NullNumber^NullNumber is undefined"))
@inline Base.:^(::NullNumber, ::Number) = NullNumber()
@inline Base.:^(::NullNumber, ::Integer) = NullNumber()
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
@inline Base.iszero(::NullNumber) = true
@inline Base.:(==)(::NullNumber, ::NullNumber) = true
@inline Base.:(<=)(::NullNumber, ::NullNumber) = true
@inline Base.:(>=)(::NullNumber, ::NullNumber) = true
@inline Base.:<(::NullNumber, ::NullNumber) = false
@inline Base.:>(::NullNumber, ::NullNumber) = false

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

