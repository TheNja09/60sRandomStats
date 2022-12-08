rngWait = 3600 --This is the FIRST time before the random stat generation, counted in frames (3600 equals 1 minute).
--You should also edit the value at the very bottom of this page if you wish to have different RNG timings!
--You can ignore these values below
rngBaseSpeed = 8
rngValor = 12
rngWisdom = 12
rngMaster = 10
rngFinal = 16
rngAnti = 16
rngLion = 18
rngMermaid = 7
rngCarpet = 20
rngDice = 8
rngCard = 8
rngLimit = 8
rngAttack = 10
rngMagic = 10
rngDefense = 10
rngHP = 20
rngMP = 100
rngScale = 1
rngGlideSpeed = 16
rngAnimation = 1
rngHighJump = 310
rngAerial = 10
rngValorCost = 3
rngWisdomCost = 3
rngLimitCost = 4
rngMasterCost = 4
rngFinalCost = 5
rngSummonCost = 3
rngMagicCost = 15
rngQuickRun = 30
rngADodgeHeight = 145
rngADodgeSpeed = 18
--rngCameraFOV = 1 -- Experimental! Please comment out if you experience crashes.
rngDriveSpd = 1 -- Experimental! Please comment out if you experience crashes.
rngAudio = 1 -- Experimental! Please comment out if you experience crashes.
rngDodgeRoll = 10
rngDraw = 125
function _OnFrame()
    World = ReadByte(Now + 0x00)
    Room = ReadByte(Now + 0x01)
    Place = ReadShort(Now + 0x00)
    Door = ReadShort(Now + 0x02)
    Map = ReadShort(Now + 0x04)
    Btl = ReadShort(Now + 0x06)
    Evt = ReadShort(Now + 0x08)
    Cheats()
end

function _OnInit()
    if GAME_ID == 0xF266B00B or GAME_ID == 0xFAF99301 and ENGINE_TYPE == "ENGINE" then--PCSX2
        Platform = 'PS2'
        Now = 0x032BAE0 --Current Location
        Save = 0x032BB30 --Save File
        Obj0 = 0x1C94100 --00objentry.bin
        Sys3 = 0x1CCB300 --03system.bin
        Btl0 = 0x1CE5D80 --00battle.bin
        Slot1 = 0x1C6C750 --Unit Slot 1
    elseif GAME_ID == 0x431219CC and ENGINE_TYPE == 'BACKEND' then--PC
        Platform = 'PC'
        Now = 0x0714DB8 - 0x56454E
        Save = 0x09A7070 - 0x56450E
        Obj0 = 0x2A22B90 - 0x56450E
        Sys3 = 0x2A59DB0 - 0x56450E
	--CameraFOV = 0x47435D - 0x56454E
	--DriveSpd = 0x3FEF56 - 0x56454E
	--SumSpd = 0x3FEF88 - 0x56454E
	--GamAud = 0xB0928 - 0x56454E
        Btl0 = 0x2A74840 - 0x56450E
        Slot1 = 0x2A20C58 - 0x56450E
    end
end

function Events(M,B,E) --Check for Map, Btl, and Evt
    return ((Map == M or not M) and (Btl == B or not B) and (Evt == E or not E))
end

function Cheats()
local soraJumpStrengthPointer=ReadLong(0x1B2512)+0x130
local animpointer=ReadLong(0x1B2512)+0x2A8
local soraScalePointer=ReadLong(0x55629A)+0x3C
    if ReadLong(0x24AA2CA) == 0 or ReadShort(0x6877DA) == 0 then
        rngWait = rngWait - 1
    end
    if ReadByte(Slot1+0x0) > ReadByte(Slot1+0x4) then
        WriteByte(Slot1+0x0, ReadByte(Slot1+0x4))
    end
    if ReadByte(Slot1+0x180) > ReadByte(Slot1+0x184) then
        WriteByte(Slot1+0x180, ReadByte(Slot1+0x184))
    end
    -- Okay this is where the fun stuff is!
    -- If you would like to edit the minimum and maximum RNG values, just change the values in math.random().
    -- The first number is the minimum value, and the second number is the maximum value.
    if rngWait == 0 then
        rngBaseSpeed = math.random(1,40) -- Base running speed of Sora/Roxas. The minimum is 1, and the maxmimum is 40.
        rngValor = math.random(1,60) -- Base running speed of Valor. Min is 1, Max is 60, and so on.
        rngWisdom = math.random(1,60) -- Base Wisdom Speed
        rngMaster = math.random(1,50) -- Base Master Speed
        rngFinal = math.random(1,80) -- Base Final Speed
        rngAnti = math.random(1,80) -- Base Anti Speed
        rngLion = math.random(1,90) -- Base Lion Speed (Does not include dash)
        rngMermaid = math.random(1,35) -- Base Mermaid Speed
        rngCarpet = math.random(1,100) -- Base Carpet Speed
        rngDice = math.random(1,40) -- Base Dice Speed
        rngCard = math.random(1,40) -- Base Card Speed (Does not seem to work?)
        rngLimit = math.random(1,40) -- Base Limit Form Speed
        rngAttack = math.random(1,80) -- Attack Stat (Note: for ATK, MAG, & DEF, leveling up and stat boosts will not work with this mod.)
        rngMagic = math.random(1,80) -- Magic Stat
        rngDefense = math.random(1,80) -- Defense Stat
        rngHP = math.random(1,120) -- Maximum HP
        rngMP = math.random(1,140) -- Maximum MP
        rngGlideSpeed = math.random(1,100) -- Glide Speed (Affects all levels with the same value)
        rngScale = math.random(30,200)/100 -- Sora's Size (Divided by 100 in order to get decimal values)
        rngAnimation = math.random(8,30)/10 -- Sora's Animation Speed
        rngHighJump = math.random(1,2000) -- Jump Height (Affects base and all High Jump levels)
        rngAerial = math.random(1,100) -- Aerial Recovery Movement Speed
        rngValorCost = math.random(0,9) -- Valor Form Cost
        rngWisdomCost = math.random(0,9) -- Wisdom Form Cost
        rngLimitCost = math.random(0,9) -- Limit Form Cost
        rngMasterCost = math.random(0,9) -- Master Form Cost
        rngFinalCost = math.random(0,9) -- Final Form Cost
        rngSummonCost = math.random(0,9) -- Summon Costs (Affects all summons)
        rngMagicCost = math.random(0,rngMP+20) -- Magic Cost (Affects every magic spell and limit)
        rngQuickRun = math.random(1,125)  -- Quick Run Speed
        rngADodgeHeight = math.random(0,2000)  -- Aerial Dodge Height (Affects all levels)
        rngADodgeSpeed = math.random(1,350) -- Aerial Dodge Speed [Horizontal Speed] (Affects all levels)
		rngDriveSpd = math.random(-2,3) -- Experimental! Please comment out if you experience crashes. [Changes the drive/summon drain speed, requires a transition]
		--rngCameraFOV = math.random(100,300)/100 -- Experimental! Please comment out if you experience crashes. [Changes the camera's field of view. Do not go below 1!]
		rngAudio = math.random(10,300)/100 -- Experimental! Please comment out if you experience crashes. [Changes the speed/pitch of the game's audio]
		rngDodgeRoll = math.random(0,300) -- Dodge Roll iFrames
		rngDraw = math.random(0,20)*125 -- Draw Range
    end
WriteFloat(Sys3+0x17CE4, rngBaseSpeed) -- Base Speed: DS = 8
WriteFloat(Sys3+0x17D18, rngValor) -- Valor Form: DS = 12
WriteFloat(Sys3+0x17D4C, rngWisdom) -- Wisdom Form: DS = 12
WriteFloat(Sys3+0x17D80, rngMaster) -- Master Form: DS = 10
WriteFloat(Sys3+0x17DB4, rngFinal) -- Final Form: DS = 16
WriteFloat(Sys3+0x17E1C, rngLion) -- Lion Sora: DS = 18
WriteFloat(Sys3+0x17DE8, rngAnti) -- Anti Form: DS = 16
WriteFloat(Sys3+0x17E50, rngMermaid) -- Mermaid Sora: DS = 7
WriteFloat(Sys3+0x18190, rngCarpet) -- Carpet Sora: DS = 20
WriteFloat(Sys3+0x181F8, rngDice) -- Dice Sora: DS = 8
WriteFloat(Sys3+0x1822C, rngCard) -- Card Sora: DS = 8
WriteFloat(Sys3+0x18364, rngLimit) -- Limit Form: DS = 8
WriteByte(Slot1+0x4, rngHP) -- Max HP
WriteByte(Slot1+0x184, rngMP) -- Max MP
WriteByte(0x24BC8D2, rngAttack) -- Attack Stat
WriteByte(0x24BC8D4, rngMagic) -- Magic Stat
WriteByte(0x24BC8D6, rngDefense) -- Defense Stat
WriteFloat(0x250D332, rngGlideSpeed) -- Glide 1 Speed (Default: 16)
WriteFloat(0x250D376, rngGlideSpeed) -- Glide 2 Speed (Default: 20)
WriteFloat(0x250D3BA, rngGlideSpeed) -- Glide 3 Speed (Default: 24)
WriteFloat(0x250D3FE, rngGlideSpeed) -- Glide MAX Speed (Default: 32)
WriteFloat(0x250D442, rngGlideSpeed) -- Glide AX2 Speed (Default: 64)
WriteFloat(0x250D312, rngHighJump) -- Sora Base Jump Height
WriteFloat(0x250D356, rngHighJump) -- Sora High Jump 2
WriteFloat(0x250D39A, rngHighJump) -- Sora High Jump 3
WriteFloat(0x250D3DE, rngHighJump) -- Sora High Jump MAX
WriteFloat(0x250D422, rngHighJump) -- Sora High Jump AX2
WriteFloat(0x250CEC6, rngAerial) -- Aerial Recovery Movement Speed
WriteByte(Sys3+0x03E0,rngValorCost) -- Valor
WriteByte(Sys3+0x0410,rngWisdomCost) -- Wisdom
WriteByte(Sys3+0x7A30,rngLimitCost) -- Limit
WriteByte(Sys3+0x04A0,rngMasterCost) -- Master
WriteByte(Sys3+0x04D0,rngFinalCost) -- Final
WriteByte(Sys3+0x5180,rngSummonCost) -- Chicken
WriteByte(Sys3+0x1070,rngSummonCost) -- Stitch
WriteByte(Sys3+0x10A0,rngSummonCost) -- Genie
WriteByte(Sys3+0x37A0,rngSummonCost) -- Pan
WriteByte(Sys3+0x9E0,rngMagicCost) -- Fire Cost
WriteByte(Sys3+0x15E0,rngMagicCost) -- Fira Cost
WriteByte(Sys3+0x1610,rngMagicCost) -- Firaga Cost
WriteByte(Sys3+0xA40,rngMagicCost) -- Blizzard Cost
WriteByte(Sys3+0x1640,rngMagicCost) -- Blizzara Cost
WriteByte(Sys3+0x1670,rngMagicCost) -- Blizzaga Cost
WriteByte(Sys3+0xA10,rngMagicCost) -- Thunder Cost
WriteByte(Sys3+0x16A0,rngMagicCost) -- Thundara Cost
WriteByte(Sys3+0x16D0,rngMagicCost) -- Thundaga Cost
WriteByte(Sys3+0xA70,rngMagicCost) -- Cure Cost
WriteByte(Sys3+0x1700,rngMagicCost) -- Cura Cost
WriteByte(Sys3+0x1730,rngMagicCost) -- Curaga Cost
WriteByte(Sys3+0x1F40,rngMagicCost) -- Magnet Cost
WriteByte(Sys3+0x1F70,rngMagicCost) -- Magnera Cost
WriteByte(Sys3+0x1FA0,rngMagicCost) -- Magnega Cost
WriteByte(Sys3+0x1FD0,rngMagicCost) -- Reflect Cost
WriteByte(Sys3+0x2000,rngMagicCost) -- Reflera Cost
WriteByte(Sys3+0x2030,rngMagicCost) -- Reflega Cost
WriteByte(Sys3+0xE30,rngMagicCost) -- Twin Howl Cost
WriteByte(Sys3+0xFB0,rngMagicCost) -- Bushido Cost
WriteByte(Sys3+0x1940,rngMagicCost) -- Red Rocket Cost
WriteByte(Sys3+0x3F80,rngMagicCost) -- Speedster Cost
WriteByte(Sys3+0x40A0,rngMagicCost) -- Bluff Cost
WriteByte(Sys3+0x4430,rngMagicCost) -- Wildcat Cost
WriteByte(Sys3+0x49A0,rngMagicCost) -- Dance Call Cost
WriteByte(Sys3+0x4B80,rngMagicCost) -- Setup Cost
WriteByte(Sys3+0x67D0,rngMagicCost) -- Session Cost
WriteByte(Sys3+0x5840,rngMagicCost) -- Trinity Limit Cost
WriteByte(Sys3+0x5840+0x1830,rngMagicCost) -- (Solo) Trinity Limit Cost
WriteByte(Sys3+0x2E10,rngMagicCost) -- Whirli-Goof Cost
WriteByte(Sys3+0x3D40,rngMagicCost) -- Knocksmash Cost
WriteByte(Sys3+0x3320,rngMagicCost) -- Comet Cost
WriteByte(Sys3+0x3E60,rngMagicCost) -- Duck Flare Cost
WriteByte(Sys3+0x7E50,rngMagicCost) -- Strike Raid Cost
WriteByte(Sys3+0x7D30,rngMagicCost) -- Sonic Blade Cost
WriteByte(Sys3+0x7C10,rngMagicCost) -- Ragnarok Cost
WriteByte(Sys3+0x7DC0,rngMagicCost) -- Ars Arcanum Cost
WriteFloat(0x250D322, rngQuickRun) -- QR1 Speed
WriteFloat(0x250D366, rngQuickRun) -- QR2 Speed
WriteFloat(0x250D3AA, rngQuickRun) -- QR3 Speed
WriteFloat(0x250D3EE, rngQuickRun) -- QR4 Speed
WriteFloat(0x250D432, rngQuickRun) -- QRAX2 Speed
WriteFloat(0x250D316, rngADodgeHeight) -- AD1 Height
WriteFloat(0x250D31A, rngADodgeSpeed) -- AD1 Speed
WriteFloat(0x250D35A, rngADodgeHeight) -- AD2 Height
WriteFloat(0x250D35E, rngADodgeSpeed) -- AD2 Speed
WriteFloat(0x250D39E, rngADodgeHeight) -- AD3 Height
WriteFloat(0x250D3A2, rngADodgeSpeed) -- AD3 Speed
WriteFloat(0x250D3E2, rngADodgeHeight) -- AD4 Height
WriteFloat(0x250D3E6, rngADodgeSpeed) -- AD4 Speed
WriteFloat(0x250D426, rngADodgeHeight) -- ADAX2 Height
WriteFloat(0x250D42A, rngADodgeSpeed) -- ADAX2 Speed
WriteFloat(0xFFFFFFFFFFE9AA08, rngDriveSpd) -- Experimental! Please comment out if you experience crashes.
WriteFloat(0xFFFFFFFFFFE9AA3A, rngDriveSpd) -- Experimental! Please comment out if you experience crashes.
--WriteFloat(0xFFFFFFFFFFF0FE0F, rngCameraFOV) -- Experimental! Please comment out if you experience crashes.
WriteFloat(0xFFFFFFFFFFB4C3DA, rngAudio) -- Experimental! Please comment out if you experience crashes.
WriteFloat(0x250D352, rngDodgeRoll) -- Dodge Roll 1
WriteFloat(0x250D396, rngDodgeRoll) -- Dodge Roll 2
WriteFloat(0x250D3DA, rngDodgeRoll) -- Dodge Roll 3
WriteFloat(0x250D41E, rngDodgeRoll) -- Dodge Roll MAX
WriteFloat(0x250D462, rngDodgeRoll) -- Dodge Roll AX2
WriteFloat(0x24BC952, rngDraw)
WriteFloat(soraJumpStrengthPointer, rngHighJump, true)
    if ReadShort(Now+0) == 0x1C12 and ReadShort(Now+8) == 0x44 then
        WriteFloat(soraScalePointer, 1, true)
    elseif ReadShort(Now+0) == 0x2202 and ReadShort(Now+8) == 0x9D then
        WriteFloat(soraScalePointer, 1, true)
    else WriteFloat(soraScalePointer, rngScale, true) -- Base Jump Height
    end
    -- Softlock prevention code with the scale function.
    if ReadShort(Now+0) == 0x0310 and ReadShort(Now+8) == 0x38 then -- Port Royal Barrels (Not really a softlock but I included it anyway)
        WriteFloat(animpointer, 1, true)
    elseif ReadShort(Now+0) == 0x0505 and ReadShort(Now+8) == 0x4F then -- Dark Thorn
        WriteFloat(animpointer, 1, true)
    elseif ReadShort(Now+0) == 0x1C12 and ReadShort(Now+8) == 0x44 then -- TWTNW Buildings
        WriteFloat(animpointer, 1, true)
    elseif ReadShort(Now+0) == 0x2202 and ReadShort(Now+8) == 0x9D then -- Twilight Thorn
        WriteFloat(animpointer, 1, true)
    elseif ReadShort(Now+0) == 0x1A12 and ReadShort(Now+8) == 0x45 then -- TWTNW Cylinders Battle
        WriteFloat(animpointer, 1, true)
    else WriteFloat(animpointer, rngAnimation, true)
    end
    -- These are what the file will print to the console [F2] with your new stats. If you would like to add your own, just follow the format!
    -- You may also safely remove any prints by deleting them or commenting them out with double dashes.
    if rngWait == 0 then
        print("New Attack:")
        print(rngAttack)
        print("New Magic:")
        print(rngMagic)
        print("New Defense:")
        print(rngDefense)
        print("New HP:")
        print(rngHP)
        print("New MP:")
        print(rngMP)
        print("New Animation Speed:")
        print(rngAnimation)
        print("New Dodge Roll iFrames:")
        print(rngDodgeRoll)
        print("Valor Now Costs:")
        if rngValorCost == 0 then
            print("FREE!!!")
        else print(rngValorCost)
        end
        print("Wisdom Now Costs:")
        if rngWisdomCost == 0 then
            print("FREE!!!")
        else print(rngWisdomCost)
        end
        print("Limit Now Costs:")
        if rngLimitCost == 0 then
            print("FREE!!!")
        else print(rngLimitCost)
        end
        print("Master Now Costs:")
        if rngMasterCost == 0 then
            print("FREE!!!")
        else print(rngMasterCost)
        end
        print("Final Now Costs:")
        if rngFinalCost == 0 then
            print("FREE!!!")
        else print(rngFinalCost)
        end
        print("Summon Now Costs:")
        if rngSummonCost == 0 then
            print("FREE!!!")
        else print(rngSummonCost)
        end
        print("All Spells and Limits Now Cost:")
        if rngMagicCost == 0 then
            print("FREE!!!")
        else print(rngMagicCost)
        end
    end
    -- Optional warnings to notify when the next RNG event will happen.
    -- Remember that the rngWait function counts down by 1 every frame!
    if rngWait == 180 then -- 3 Seconds left
        print("Next random set of stats in 3 seconds!")
    elseif rngWait == 120 then -- 2 Seconds left
        print("Next random set of stats in 2 seconds!")
    elseif rngWait == 60 then -- 1 Second left
        print("Next random set of stats in 1 second!")
    elseif rngWait == 0 then
        rngWait = 3600 --You should edit this value if you wish to have different RNG timings! The one at the top is just for the first call.
    end
end
