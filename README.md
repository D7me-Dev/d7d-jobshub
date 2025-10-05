# d7d-jobshub

## Requirements

- qb-core — https://github.com/qbcore-framework/qb-core
- ox_lib  — https://github.com/overextended/ox_lib

> Make sure these resources are installed and started before `ensure d7d-jobshub`.

## Installation

1. Place the folder in your resources
2. Add to your `server.cfg`
   
---

## Add a New Job (config.lua)

Open `config.lua` and add a new entry under `Config.Jobs`. Example for a `new job`:

```lua
Config.Jobs = Config.Jobs or {}

Config.Jobs["job_name"] = {
  Command = "job_open_command",             -- chat command to toggle the hub
  Title   = "job_title",     -- title shown in the UI
  Style = {
    -- core colors (valid CSS: #RRGGBB / #RRGGBBAA / rgb()/rgba())
    danger                = "#ed0c0c",
    radio                 = "#c13939",
    ["radio-grad-end"]    = "#7c4040",
    ["option-hover"]      = "#ed0c0c",
    ["option-text-hover"] = "#ee1212",

    -- role backgrounds (you can use any gradients/colors)
    ["Comander-Bg"]       = "linear-gradient(270deg, rgba(16,15,15,0.566) 86%, rgba(142,119,68,1) 100%)",
    ["Dispatch-Bg"]       = "linear-gradient(270deg, rgba(16,15,15,0.566) 86%, #683B8F 100%)",
    ["Break-Bg"]          = "linear-gradient(270deg, rgba(16,15,15,0.566) 86%, #8f4c3b 100%)",
    ["Duty-Bg"]           = "linear-gradient(270deg, rgba(16,15,15,0.566) 86%, #558B47 100%)",

    -- hover text colors
    ["Commander-Color"]   = "rgb(111, 89, 42)",
    ["Dispatch-Color"]    = "#683B8F",
    ["Break-Color"]       = "#8f4c3b",
    ["Duty-Color"]        = "#35642a",
  }
}
```

----

## Credits

- Original Script Author: PRX - https://discord.gg/ZWeaTtcgbE
- Fully Modified By: D7me - https://discord.com/invite/6kBKEHW4cd

----

## Preview

![Preview](https://cdn.discordapp.com/attachments/1129942093641551872/1424472202534719538/Y1QudV7.png?ex=68e4129e&is=68e2c11e&hm=951094d9c4157d17e7f865281826468abdf747e85b69c34ecc3018593f11ca1c&)
![Preview](https://cdn.discordapp.com/attachments/1129942093641551872/1424472201926541352/BpZ16z4.png?ex=68e4129e&is=68e2c11e&hm=8c0a9d779ff7a1adcd15f4218d8e171c4643b0724857d34dc646345cc6b0cf1f&)
