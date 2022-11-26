rngWait = 3600
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
	if rngWait == 0 then
	rngBaseSpeed = math.random(1,40)
	rngValor = math.random(1,60)
	rngWisdom = math.random(1,60)
	rngMaster = math.random(1,50)
	rngFinal = math.random(1,80)
	rngAnti = math.random(1,80)
	rngLion = math.random(1,90)
	rngMermaid = math.random(1,35)
	rngCarpet = math.random(1,100)
	rngDice = math.random(1,40)
	rngCard = math.random(1,40)
	rngLimit = math.random(1,40)
	rngAttack = math.random(1,80)
	rngMagic = math.random(1,80)
	rngDefense = math.random(1,80)
	rngHP = math.random(1,120)
	rngMP = math.random(1,140)
	rngGlideSpeed = math.random(1,100)
	rngScale = math.random(10,100)/100
	rngAnimation = math.random(3,50)/10
	rngHighJump = math.random(1,2000)
	rngAerial = math.random(1,100)
	rngValorCost = math.random(0,9)
	rngWisdomCost = math.random(0,9)
	rngLimitCost = math.random(0,9)
	rngMasterCost = math.random(0,9)
	rngFinalCost = math.random(0,9)
	rngSummonCost = math.random(0,9)
	rngMagicCost = math.random(0,140)
	rngQuickRun = math.random(1,125)
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
WriteByte(Slot1+0x4, rngHP)
WriteByte(Slot1+0x184, rngMP)
WriteByte(0x24BC8D2, rngAttack)
WriteByte(0x24BC8D4, rngMagic)
WriteByte(0x24BC8D6, rngDefense)
WriteFloat(0x250D332, rngGlideSpeed) --Glide 1 Speed (Default: 16)
WriteFloat(0x250D376, rngGlideSpeed) --Glide 2 Speed (Default: 20)
WriteFloat(0x250D3BA, rngGlideSpeed) --Glide 3 Speed (Default: 24)
WriteFloat(0x250D3FE, rngGlideSpeed) --Glide MAX Speed (Default: 32)
WriteFloat(0x250D442, rngGlideSpeed) --Glide AX2 Speed (Default: 64)
WriteFloat(0x250D312, rngHighJump)
WriteFloat(0x250D356, rngHighJump) -- Sora High Jump 2
WriteFloat(0x250D39A, rngHighJump) -- Sora High Jump 3
WriteFloat(0x250D3DE, rngHighJump) -- Sora High Jump MAX
WriteFloat(0x250D422, rngHighJump) -- Sora High Jump AX2
WriteFloat(0x250CEC6, rngAerial)
WriteByte(Sys3+0x03E0,rngValorCost) -- Valor
WriteByte(Sys3+0x0410,rngWisdomCost) -- Wisdom
WriteByte(Sys3+0x7A30,rngLimitCost) -- Limit
WriteByte(Sys3+0x04A0,rngMasterCost) -- Master
WriteByte(Sys3+0x04D0,rngFinalCost) -- Final
WriteByte(Sys3+0x5180,rngSummonCost) -- Chicken
WriteByte(Sys3+0x1070,rngSummonCost) -- Stitch
WriteByte(Sys3+0x10A0,rngSummonCost) -- Genie
WriteByte(Sys3+0x37A0,rngSummonCost) -- Pan
WriteByte(Sys3+0x9E0,rngMagicCost) -- Fire Cost: 15
WriteByte(Sys3+0x15E0,rngMagicCost) -- Fira Cost: 15
WriteByte(Sys3+0x1610,rngMagicCost) -- Firaga Cost: 15
WriteByte(Sys3+0xA40,rngMagicCost) -- Blizzard Cost: 15
WriteByte(Sys3+0x1640,rngMagicCost) -- Blizzara Cost: 15
WriteByte(Sys3+0x1670,rngMagicCost) -- Blizzaga Cost: 15
WriteByte(Sys3+0xA10,rngMagicCost) -- Thunder Cost: 15
WriteByte(Sys3+0x16A0,rngMagicCost) -- Thundara Cost: 15
WriteByte(Sys3+0x16D0,rngMagicCost) -- Thundaga Cost: 15
WriteByte(Sys3+0xA70,rngMagicCost) -- Cure Cost: 3
WriteByte(Sys3+0x1700,rngMagicCost) -- Cura Cost: 2
WriteByte(Sys3+0x1730,rngMagicCost) -- Curaga Cost: 2
WriteByte(Sys3+0x1F40,rngMagicCost) -- Magnet Cost: 15
WriteByte(Sys3+0x1F70,rngMagicCost) -- Magnera Cost: 15
WriteByte(Sys3+0x1FA0,rngMagicCost) -- Magnega Cost: 15
WriteByte(Sys3+0x1FD0,rngMagicCost) -- Reflect Cost: 3
WriteByte(Sys3+0x2000,rngMagicCost) -- Reflera Cost: 2
WriteByte(Sys3+0x2030,rngMagicCost) -- Reflega Cost: 1
WriteByte(Sys3+0xE30,rngMagicCost) -- Twin Howl Cost: 254
WriteByte(Sys3+0xFB0,rngMagicCost) -- Bushido Cost: 254
WriteByte(Sys3+0x1940,rngMagicCost) -- Red Rocket Cost: 254
WriteByte(Sys3+0x3F80,rngMagicCost) -- Speedster Cost: 254
WriteByte(Sys3+0x40A0,rngMagicCost) -- Bluff Cost: 254
WriteByte(Sys3+0x4430,rngMagicCost) -- Wildcat Cost: 254
WriteByte(Sys3+0x49A0,rngMagicCost) -- Dance Call Cost: 254
WriteByte(Sys3+0x4B80,rngMagicCost) -- Setup Cost: 254
WriteByte(Sys3+0x67D0,rngMagicCost) -- Session Cost: 254
WriteByte(Sys3+0x5840,rngMagicCost) -- Trinity Limit Cost: 254
WriteByte(Sys3+0x5840+0x1830,rngMagicCost) -- (Solo) Trinity Limit Cost: 3
WriteByte(Sys3+0x2E10,rngMagicCost) -- Whirli-Goof Cost: 3
WriteByte(Sys3+0x3D40,rngMagicCost) -- Knocksmash Cost: 3
WriteByte(Sys3+0x3320,rngMagicCost) -- Comet Cost: 254
WriteByte(Sys3+0x3E60,rngMagicCost) -- Duck Flare Cost: 254
WriteByte(Sys3+0x7E50,rngMagicCost) -- Strike Raid Cost: 1
WriteByte(Sys3+0x7D30,rngMagicCost) -- Sonic Blade Cost: 2
WriteByte(Sys3+0x7C10,rngMagicCost) -- Ragnarok Cost: 100
WriteByte(Sys3+0x7DC0,rngMagicCost) -- Ars Arcanum Cost: 3
WriteFloat(0x250D322, rngQuickRun) --QR1 Speed
WriteFloat(0x250D366, rngQuickRun) --QR2 Speed
WriteFloat(0x250D3AA, rngQuickRun) --QR3 Speed
WriteFloat(0x250D3EE, rngQuickRun) --QR4 Speed
WriteFloat(0x250D432, rngQuickRun) --AX2 QR Speed
WriteFloat(soraJumpStrengthPointer, rngHighJump, true)
if ReadShort(Now+0) == 0x1C12 and ReadShort(Now+8) == 0x44 then
		WriteFloat(soraScalePointer, 1, true)
    elseif ReadShort(Now+0) == 0x2202 and ReadShort(Now+8) == 0x9D then
		WriteFloat(soraScalePointer, 1, true)
    else WriteFloat(soraScalePointer, rngScale, true)
end
if ReadShort(Now+0) == 0x0310 and ReadShort(Now+8) == 0x38 then -- Port Royal Barrels
	WriteFloat(animpointer, 1, true)
	elseif ReadShort(Now+0) == 0x0505 and ReadShort(Now+8) == 0x4F then -- Dark Thorn
	WriteFloat(animpointer, 1, true)
	elseif ReadShort(Now+0) == 0x1C12 and ReadShort(Now+8) == 0x44 then -- TWTNW Buildings
	WriteFloat(animpointer, 1, true)
	elseif ReadShort(Now+0) == 0x2202 and ReadShort(Now+8) == 0x9D then -- Twilight Thorn
	WriteFloat(animpointer, 1, true)
	elseif ReadShort(Now+0) == 0x1A12 and ReadShort(Now+8) == 0x45 then -- TWTNW Outside Core
	WriteFloat(animpointer, 1, true)
	else WriteFloat(animpointer, rngAnimation, true)
end
	if rngWait == 0 then
	ConsolePrint("New Attack:")
	ConsolePrint(rngAttack)
	ConsolePrint("New Magic:")
	ConsolePrint(rngMagic)
	ConsolePrint("New Defense:")
	ConsolePrint(rngDefense)
	ConsolePrint("New HP:")
	ConsolePrint(rngHP)
	ConsolePrint("New MP:")
	ConsolePrint(rngMP)
	ConsolePrint("New Size:")
	ConsolePrint(rngScale)
	ConsolePrint("New Animation Speed:")
	ConsolePrint(rngAnimation)
	ConsolePrint("Valor Now Costs:")
	ConsolePrint(rngValorCost)
	ConsolePrint("Wisdom Now Costs:")
	ConsolePrint(rngWisdomCost)
	ConsolePrint("Limit Now Costs:")
	ConsolePrint(rngLimitCost)
	ConsolePrint("Master Now Costs:")
	ConsolePrint(rngMasterCost)
	ConsolePrint("Final Now Costs:")
	ConsolePrint(rngFinalCost)
	ConsolePrint("Summon Now Costs:")
	ConsolePrint(rngSummonCost)
	ConsolePrint("All Spells and Limits Now Cost:")
	ConsolePrint(rngMagicCost)
	end
	if rngWait == 180 then
	ConsolePrint("Next random set of stats in 3 seconds!")
	elseif rngWait == 120 then
	ConsolePrint("Next random set of stats in 2 seconds!")
	elseif rngWait == 60 then
	ConsolePrint("Next random set of stats in 1 second!")
	elseif rngWait == 0 then
	rngWait = 3600
	end
end
