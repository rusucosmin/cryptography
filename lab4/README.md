# Lab4 - Factorizing

## Classic algorithm
The classic algorithm is pretty straight forward:
- We take each possible divisor, and when we find one, we keep dividing that number
with the same divisor while we can. We also only need to go only until `sqrt(n)`.

A simple pseudocode for this is:
```python
def factorize(n):
  factors = []                  # will keep our result
  for p from 2 to sqrt(n):      # iterate from 2 to sqrt(n)
    cnt = 0                     # will store the current power of the current prime
    while n % p == 0:           # while we can,
      n /= p                    # divide n by p
      cnt += 1                  # increase the count
    if cnt != 0:                # if it was a divisor
      factors.append((p, cnt))  # append to the solution
  if n != 1:                    # there may be only one divisor left
    factors.append((n, 1))      # append if necessary
  return factors                # return the result

```
Other approches precomputes all the primes in the interval [2, sqrt(n)], and the implementation
would be faster so that you are not iterating to all numbers in the interval, but rather on only
the number of divisors there. However, a precomputation is neccesary.

## Pollard p algorithm
The algorithm returns a non-obvious divisor of a number. It uses Floyd's idea of detecting cycles,
also knonw as the rabbit & turtle problem.
