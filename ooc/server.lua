AddEventHandler('chatMessage', function(source, name, msg)
	sm = stringsplit(msg, " ");
	if sm[1] == "/ooc" then
		CancelEvent()
		TriggerClientEvent('chatMessage', -1, "Global |OOC - " .. name,  { 128, 128, 128 }, string.sub(msg,5))
	end
end)

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

GithubUpdater = function()
	GetCurrentVersion = function()
		return GetResourceMetadata( GetCurrentResourceName(), "version" )
	end

	local CurrentVersion = GetCurrentVersion()
	local resourceName = "^4["..GetCurrentResourceName().."]^0"
	local VehicleKeyChain = "^3[VehicleKeyChain]^0"

	if Config.VersionChecker then
		PerformHttpRequest('https://raw.githubusercontent.com/Musiker15/msk_enginetoggle/main/VERSION', function(Error, NewestVersion, Header)
			print("###############################")
			if CurrentVersion == NewestVersion then
				print(resourceName .. '^2 ✓ Resource is Up to Date^0 - ^5Current Version: ^2' .. CurrentVersion .. '^0')
				if Config.VehicleKeyChain then
					if (GetResourceState("VehicleKeyChain") == "started") then
						print('^2[READY]^0 Script '.. VehicleKeyChain ..' found!')
					elseif (GetResourceState("VehicleKeyChain") == "stopped") then
						print('^1[ERROR]^0 Script '.. VehicleKeyChain ..' not found! Please be sure, that '.. VehicleKeyChain ..' is started.')
					end
				end
			elseif CurrentVersion ~= NewestVersion then
				print(resourceName .. '^1 ✗ Resource Outdated. Please Update!^0 - ^5Current Version: ^1' .. CurrentVersion .. '^0')
				print('^5Newest Version: ^2' .. NewestVersion .. '^0 - ^6Download here: ^9https://github.com/Musiker15/msk_enginetoggle/releases/tag/v'.. NewestVersion .. '^0')
				if Config.VehicleKeyChain then
					if (GetResourceState("VehicleKeyChain") == "started") then
						print('^2[READY]^0 Script '.. VehicleKeyChain ..' found!')
					elseif (GetResourceState("VehicleKeyChain") == "stopped") then
						print('^1[ERROR]^0 Script '.. VehicleKeyChain ..' not found! Please be sure, that '.. VehicleKeyChain ..' is started.')
					end
				end
			end
			print("###############################")
		end)
	else
		print("###############################")
		print(resourceName .. '^2 ✓ Resource loaded^0 - ^5Current Version: ^1' .. CurrentVersion .. '^0')
		print("###############################")
	end
end
GithubUpdater()