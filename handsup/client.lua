ESX = nil

Player = {
	inAnim = false,
}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end


	ESX.PlayerData = ESX.GetPlayerData()
end)

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do 
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end

RegisterCommand(Config.Command ,function(source, args)
	local player = GetPlayerPed( -1 )
	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
		loadAnimDict( "random@arrests" )
		loadAnimDict( "random@arrests@busted" )
		if ( IsEntityPlayingAnim( player, "random@arrests@busted", "idle_a", 3 ) ) then 
			TaskPlayAnim( player, "random@arrests@busted", "exit", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
			Wait (3000)
			TaskPlayAnim( player, "random@arrests", "kneeling_arrest_get_up", 8.0, 1.0, -1, 128, 0, 0, 0, 0 )
			surrendered = false
		else
			TaskPlayAnim( player, "random@arrests", "idle_2_hands_up", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
			Wait (4000)
			TaskPlayAnim( player, "random@arrests", "kneeling_arrest_idle", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
			Wait (500)
			TaskPlayAnim( player, "random@arrests@busted", "enter", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
			Wait (1000)
			TaskPlayAnim( player, "random@arrests@busted", "idle_a", 8.0, 1.0, -1, 9, 0, 0, 0, 0 )
			Wait(100)
			surrendered = true
		end     
	end
end, false)



RegisterCommand(Config.Command1 ,function()
	local dict = "missminuteman_1ig_2"
	
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
	end
	local handsup = false
	
	if not handsup then
        TaskPlayAnim(GetPlayerPed(-1), dict, "handsup_enter", 8.0, 8.0, -1, 50, 0, false, false, false)
        handsup = true
    else
        handsup = false
        ClearPedTasks(GetPlayerPed(-1))
    end

end, false)

Citizen.CreateThread(function()
	while true do
		plyPed = PlayerPedId()

		if IsControlJustReleased(0, Config.Controls.StopTasks.keyboard) and IsInputDisabled(2) and not Player.isDead then
			ClearPedTasks(plyPed)
		end

		Citizen.Wait(0)
	end
end)
