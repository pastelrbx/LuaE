# LuaE
Don't use this unless you care more about speed of development than speed that the end-user experiences.<br>
*P.S. I know my coding looks and is rubbish. Please don't attack me for it.*

## How to Use

### Roblox
```luau
local LuaE = require(game:GetService("ReplicatedStorage").LuaE).new(true) -- the assetid is "71968516616302", but i cant publish it for some reason, so just copy the LuaE.luau file to ReplicatedStorage.
LuaE:Call([[
    -- your code here
]], true)
```

## How to Run

### Linux/macOS
```bash
git clone https://github.com/pastelrbx/LuaE.git
cd LuaE
# make sure you have curl and unzip or install a luau binary before continuing
sh ./luae.sh path args
```

### Windows
```batch
git clone https://github.com/pastelrbx/LuaE.git
cd LuaE
REM install luau binary before continuing
luae.bat path args
```

## Differences from Lua(u)

### Length of code

#### FizzBuzz

*Just to be clear, this comparison is a joke, even though it's true. So please don't come after me.*

|Language|Length|Code|
|-|-|-|
|LuaE|8|`fbz(100)`|
|LuaE(Luau)|34|`require("./LuaE"):Call("fbz(100)")`|
|Lua(u)|132(minified)|`for a=1,100 do if a%15==0 then print("FizzBuzz")elseif a%3==0 then print("Fizz")elseif a%5==0 then print("Buzz")else print(a)end end`|
