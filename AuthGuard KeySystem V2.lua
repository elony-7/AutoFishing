--[[
     PLEASE, IF YOU ARE GOING TO TEST THIS, FIRST OBFUSCATE ALL THIS CODE ON AuthGuard, ELSE IT WILL NOT WORK.
]]--
getgenv().KeySystemVerified = false

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local key = "" -- dont delete this, leave it blank, its for AuthGuard Key System.

local folderPath = "workspace/IkanTerbang"
local keyFile = folderPath .. "/key.txt"

if not isfolder(folderPath) then
    makefolder(folderPath)
end

-- Check saved key
local key = ""
if isfile(keyFile) then
    key = readfile(keyFile)
    print("Found saved key:", key)

    if AuthGuard:validateKey(key) then
        getgenv().KeySystemVerified = true
        Fluent:Notify({
            Title = "Ikan Terbang Hub",
            Content = "Saved key is valid! Loading...",
            Duration = 5
        })

        loadstring(game:HttpGet("https://raw.githubusercontent.com/elony-7/AutoFishing/refs/heads/main/Ikan%20Terbang%20V1.0.4%20Key"))()
        return -- stop here, no loader UI
    else
        Fluent:Notify({
            Title = "Ikan Terbang Hub",
            Content = "Saved key expired or invalid. Please re-enter.",
            Duration = 5
        })
        -- optional: delfile(keyFile)
    end
end

local Window = Fluent:CreateWindow({
    Title = "Ikan Terbang Hub", -- your hub (script) name
    SubTitle = "Key System",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 340),
    Acrylic = false,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.RightControl -- if you dont know how to use this, search a video how to use this.
})

local Tabs = {
    KeySystemTab = Window:AddTab({ Title = "Key System", Icon = "key" }),
    DiscordTab = Window:AddTab({ Title = "Discord", Icon = "globe" }),
}

local EnterKey = Tabs.KeySystemTab:AddInput("Input", {
    Title = "Enter Key",
    Default = "",
    Placeholder = "Your key goes here",
    Numeric = false,
    Finished = false,
    Callback = function(Value)
        key = Value
    end
})

local CheckKey = Tabs.KeySystemTab:AddButton({
    Title = "Check Key",
    Callback = function()
        if AuthGuard:validateKey(key) then
            getgenv().KeySystemVerified = true
            Fluent:Notify({
                Title = "Key System",
                Content = "Key is valid! Loading...",
                Duration = 4
            })

            print("Key is valid, loading...")

            loadstring(game:HttpGet("https://raw.githubusercontent.com/elony-7/AutoFishing/refs/heads/main/Ikan%20Terbang%20V1.0.4%20Key"))()

            ------------------------------------
            print("Print Update Test KEDUA TAMBAH CLOSE WINDOW") -- your script here, i recommend to use the AuthGuard obfuscator for your main script and use the loadstring and add it here.
            ------------------------------------
            -- Save key to file
            writefile(keyFile, key)

            Fluent:Notify({
            Title = "Ikan Terbang Hub",
            Content = "Key saved successfully!",
            Duration = 4
})

			-- Close the key UI after success
			Window:Destroy()    

        else
            Fluent:Notify({
                Title = "Key System",
                Content = "Key is invalid.",
                Duration = 4
            })
            print("Key is invalid.")
        end
    end
})

local GetKey = Tabs.KeySystemTab:AddButton({
    Title = "Get Key",
    Callback = function()
        local success, err = pcall(function()
            setclipboard(AuthGuard:getLink())
        end)
        if success then
            Fluent:Notify({
                Title = "Key System",
                Content = "Copied Key URL!",
                Duration = 4
            })
        else
            Fluent:Notify({
                Title = "Key System",
                Content = "Error while trying to copy key URL.",
                Duration = 4
            })
        end
    end
})

local GetDiscord = Tabs.DiscordTab:AddButton({
    Title = "Copy Discord",
    Description = "Need help? Join the discord server!",
    Callback = function()
        local success, err = pcall(function()
            setclipboard("https://discord.gg/4V2GWJwe") -- change "invite" for ur discord invite code, or just change it for your discord server url.
        end)
        if success then
            Fluent:Notify({
                Title = "Discord",
                Content = "Copied Discord!",
                Duration = 4
            })
        else
            Fluent:Notify({
                Title = "Discord",
                Content = "Error while trying to copy discord.",
                Duration = 4
            })
        end
    end
})

Window:SelectTab(1)