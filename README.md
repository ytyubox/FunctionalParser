# FunctionalParser

This a practice of Functional parsing inspired by [
Computerphile](https://www.youtube.com/user/Computerphile)
[![](https://i.ytimg.com/vi/dDtZLm7HIJs/maxresdefault.jpg)](https://www.youtube.com/watch?v=dDtZLm7HIJs&ab_channel=Computerphile)

## Haskell parsing

### basic parsing logic 
```haskell
parse digit "123"
[('1, "23")]

parse digit "abc"
[]

parse (char 'a') "abc"
[('a', "bc")]

parse (some digit) "123"
[("123", "")]

parse (digit <|> letter) "abc123"
[('a', "bc123")]

parse (some (digit <|> letter)) "abc123"
[("abc123", "")]
```
### Math parse logic

```Haskell
nat = do xs <- some digit
         return (read xs)

int = do char '-'
         n <- nat
         return (-n)
      <|> nat
```

However, I really don't know anything about Haskell and the parse tool, please forgive me that I can't explain anything.

## Swift parse

```swift
let p = MathParser()
p.nat("123") //  [Q(123,"")]
p.nat("1abc") //  [Q(1,"abc")]
p.nat("-123") //  []
p.nat("abc") //  []

p.int("123") // [Q(123,"")]
p.int("1abc") // [Q(1,"abc")]
p.int("-123") // [Q(-123,"")]
p.int("abc") // []
```
