script_name('FastOpenGate')
script_author('Ben_Puls')
script_description('FastOpenGate')
require 'lib.moonloader'
local vkeys = require "vkeys"
local ini = require "inicfg"
local nCfg = "FastOpenGate.ini"
local cfg = ini.load({opengate = { lock = true }}, nCfg)
local cmd_opengate = { [VK_H] = '/opengate' }

function main()
    if not isSampfuncsLoaded() or not isSampLoaded() then return end
    while not isSampAvailable() do wait(100) end
        sampAddChatMessage("{58c9b1}[FastOpenGate by Ben Puls] {ffffff}my cmds: /gateinfo, /gate", -1)
        print("Has been started by Ben Puls")
        sampRegisterChatCommand("gate", function()
		cfg.opengate.lock = not cfg.opengate.lock
		if ini.save(cfg, nCfg) then
			sampAddChatMessage("{58c9b1}[FastOpenGate] " .. (cfg.opengate.lock and "{AAFFAA}ON" or "{FFAAAA}OFF"), 0xEEEEEE)
		end
	end)
        sampRegisterChatCommand("gateinfo", function ()
            sampShowDialog(6405, 'FastOpenGate by Ben Puls', 'FastOpenGate: ' .. (cfg.opengate.lock and "{AAFFAA}ON" or "{FFAAAA}OFF")..'\n\n\n{FFFFFF}Fast open gates on button H', 'Close', '', DIALOG_STYLE_MSGBOX)
        end)
    while true do wait(0)
        if cfg.opengate.lock then
            for k, cmd in pairs(cmd_opengate) do
                if isKeyJustPressed(k) then
                    if not sampIsCursorActive() and not isSampfuncsConsoleActive() then
                        sampSendChat(cmd)
                    end
                end
            end
        end
    end
end
