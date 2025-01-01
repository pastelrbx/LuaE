# LuaE
Don't use this unless you care more about speed of development than speed that the end-user experiences.

## Differences from Lua(u)

### Length of code

#### FizzBuzz

*Just to be clear, this comparison is a joke, even though it's true. So please don't come after me.*

|Language|Length|Code|
|-|-|-|
|LuaE|8|`fbz(100)`|
|LuaE(Luau)|34|`require("./LuaE"):Call("fbz(100)")`|
|Lua(u)|132(minified)|`for a=1,100 do if a%15==0 then print("FizzBuzz")elseif a%3==0 then print("Fizz")elseif a%5==0 then print("Buzz")else print(a)end end`|
