local LuaE = {
	Expressions = {
        fbz = function(len)
            for i = 1, len do
                if i % 15 == 0 then
                    print("FizzBuzz")
                elseif i % 3 == 0 then
                    print("Fizz")
                elseif i % 5 == 0 then
                    print("Buzz")
                else
                    print(i)
                end
            end
        end,
		["≈"] = function(arg1, arg2, area)
			return math.abs(arg1 - arg2) <= area
		end,
        var = "local",
        lcl = "local",
        out = print,
        rtr = "return",
        fnc = "function",
        wle = "while",
        elif = "elseif",
        brk = "break",
        cont = "continue",
        typ = typeof or type,
        asrt = assert,
        str = '"string"', -- as in `typ(x) == str`
        num = '"number"', -- read above
        bool = '"boolean"', -- read above
        tbl = '"table"', -- read above
        prs = pairs,
        iprs = ipairs,
        mabs = math.abs,
        mmin = math.min,
        mmax = math.max,
        mcl = math.ceil,
        mflr = math.floor,
        mceil = math.ceil,
        mfloor = math.floor,
        mrand = math.random,
        mrnd = math.round,
        mround = math.round,
        minf = math.huge,
        mavg = function(...)
            local args = {...}
            return math.sum(table.unpack(args)) / #args
        end,
        msq = math.sqrt,
        mdeg = math.deg,
        mrad = math.rad,
        msin = math.sin,
        mcos = math.cos,
        mtan = math.tan,
        masin = math.asin,
        macos = math.acos, -- haha MacOS
        mlog = math.log,
        mexp = math.exp,
        mpw = math.pow,
        ml10 = math.log10,
        tbin = table.insert,
        tbclr = table.clear,
        tbrm = table.remove,
        tbcl = table.clone,
        tbmv = table.move,
        sfm = string.format,
        ssb = string.sub,
        sln = string.len,
        sup = string.upper,
        slw = string.lower,
        scp = string.char,
        sgs = string.gsub,
        ["&"] = "and", -- i remember adding this to my last LuaU-based Transpiler
        ["|"] = "or",
        ["!="] = "~=",
        ["!"] = "not",
        fori = "for i = 1, ", -- fori something do print(i) end
        forp = "for i, x in pairs", -- forp(something) do print(i, x) end
        whlw = "while task.wait"
	}
}

function LuaE.new(roblox: boolean?)
	local self = {}
	setmetatable(self, {__index = LuaE})
    if roblox then
        self.Roblox = {
            brc = BrickColor.new,
            vec3 = Vector3.new,
            col3 = Color3.new,
            cfr = CFrame.new,
            vec2 = Vector2.new,
            insn = Instance.new,
            plrs = game:GetService("Players"),
            mksr = game:GetService("MarketplaceService"),
            rpst = game:GetService("ReplicatedStorage"),
            wrk = game:GetService("Workspace"),
            htsr = game:GetService("HttpService"),
            lplr = game:GetService("Players").LocalPlayer, -- for all my exploiters ig
            gtsr = "game:GetService"
        }
        for _, v in pairs(self.Roblox) do
            table.insert(self.Expressions, v)
        end
    end
	return self
end

function LuaE:Compile(scr: string)
	local args = {}

	for i, x in pairs(self.Expressions) do local xtype = typeof(x) == "function" or typeof(x) == "table" or typeof(x) == "Instance"
        if xtype then
			scr = scr:gsub(i, "(LuaEenv[\""..i.."\"])") -- this used to use select, but it doesn't work more than once
		else
			scr = scr:gsub(i, tostring(x))
		end
	end

    scr = "return function(LuaEenv)" .. scr .. " end"

	local comp, prob = loadstring(scr)

	if not comp then
        print("[LuaE Debug] " .. scr)
		error(prob)
	end

    self.LatestCompile = comp
    return self
end

function LuaE:Run(...)
    local envVars = {env = {}}
    for key, val in pairs(self.Expressions) do
        envVars[key] = val
    end
    for key, val in table.pack(...) do
        envVars["env"][key] = val
    end

    local chunk = self.LatestCompile()
    local ok, prob = pcall(chunk, envVars)

    if not ok then
        error(prob)
    end

    return self
end

function LuaE:Call(scr: string, ...)
    self:Compile(scr):Run(...)
    return self
end

function LuaE:CreateExpression(shorthand: string, value: any)
    self.Expressions[shorthand] = value
    return self
end

function LuaE:DisableProblematic()
    local problematic = {
        "!",
        "&"
    }
    for _, key in pairs(problematic) do
        self.Expressions[key] = nil
    end
    return self
end

return LuaE
