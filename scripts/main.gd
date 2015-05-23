
extends Control

var settings = {
	'SOUND_ENABLED' : true,
	'LANGUAGE' : 'en'
}
var fileReferences = {
	"mainMenuMusic" : "res://assets/music/mainmenu.ogg",
	"ingameMusic" : "res://assets/music/ingame.ogg"
}

var mapReferences = {
	"1": {
		"title":"Procedural",
		"levels":{
			"1":{
				"title":"Procedural 1",
				"bestCandy":0,
				"bestScore":0,
				"unlocked":true,
				"path":"user://maps/procedural1.acdmap"
			},
			"2":{
				"title":"Procedural 2",
				"bestCandy":0,
				"bestScore":0,
				"unlocked": false,
				"path":"user://maps/procedural2.acdmap"
			}
		}
	},
	"2": {
		"title":"Looping",
		"levels":{
			"1":{
				"title":"Looping 1",
				"bestCandy":0,
				"bestScore":0,
				"unlocked":false,
				"path":""
			},
			"2":{
				"title":"Looping 2",
				"bestCandy":0,
				"bestScore":0,
				"unlocked": false,
				"path":""
			}
		}
	},
}

var file = File.new()
var directory = Directory.new()

var prefabs= {
	"mapTemplate": preload("res://map/map_template.scn")
}

var references = {
	"worldRoot": "",
	"guiRoot": "",
	"soundController":"",
	"gameController":"",
	"inputController":""
}

var currents = {
	"map" : {},
	"GUI" : "",
	"music":"",
	"CURSOR_ENABLED": true
} 

#========================================
#=============GODOT FUNCTION=============
#========================================

func _ready():
	# Initialization here
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	self.initReferences()
	self.manageUserDirectory()
	self.readSettingsFromFile()
	self.readUserDataFromFile()
	self.playMusic("mainMenuMusic")
	self.settingsChanged()
	references["guiRoot"].init()
	pass

#======================================
#=============OWN FUNCTION=============
#======================================

func initReferences():
	references["worldRoot"] = self.get_node("world_root")
	references["guiRoot"] = self.get_node("gui_layer/canvas_item/gui_root")
	references["soundController"] = preload("res://scripts/sound_controller.gd").new()
	references["gameController"] = preload("res://scripts/game_controller.gd").new()
	references["inputController"] = preload("res://scripts/input_controller.gd").new()
	references["soundController"].init(self)

func changeSettings(settingName, newValue):
	settings[settingName] = newValue
	self.settingsChanged()
	pass

func settingsChanged():
	if settings["SOUND_ENABLED"]:
		self.references["soundController"].muteMusic(false)
	else:
		self.references["soundController"].muteMusic(true)
	self.writeSettingsToFile()

func playMusic(title):
	if fileReferences[title] :
		references["soundController"].playMusic(fileReferences[title])
		currents["music"] = title

func loadMap(path):
	if path :
		var temp = prefabs["mapTemplate"].instance()
		temp.init(self,path)
		references["worldRoot"].add_child(temp)
		return true
	else:
		return false
	pass

func unloadMap():
	references["worldRoot"].remove_child(references["worldRoot"].get_child(0))

func manageUserDirectory():
	directory.open("user://")
	if not directory.dir_exists("maps"):
		directory.make_dir("maps")
	pass

func readSettingsFromFile():
	var temp
	if file.file_exists("user://settings.acd"):
		file.open("user://settings.acd", File.READ)
		temp = file.get_var()
		settings = temp
		print("setting loaded")
	else:
		self.writeSettingsToFile()
		print("failed to read setting, attempt to write")
	file.close()

func writeSettingsToFile():
	file.open("user://settings.acd", File.WRITE)
	file.store_var(self.settings)
	file.close()
	print("setting saved")

func readUserDataFromFile():
	var temp
	if file.file_exists("user://userdata.acd"):
		file.open("user://userdata.acd", File.READ)
		temp = file.get_var()
		fileReferences = temp
		temp = file.get_var()
		mapReferences = temp
		print("userdata loaded")
	else:
		self.writeUserDataToFile()
		print("failed to read userdata, attempt to write")
	file.close()

func writeUserDataToFile():
	file.open("user://userdata.acd", File.WRITE)
	file.store_var(self.fileReferences)
	file.store_var(self.mapReferences)
	file.close()
	print("userdata saved")

func startLevel(mapIndex):
	if references["worldRoot"].get_child_count() > 0:
		self.quitLevel()
	var path = mapReferences[mapIndex.containerIndex]["levels"][str(mapIndex.levelIndex)].path
	var unlocked = mapReferences[mapIndex.containerIndex]["levels"][str(mapIndex.levelIndex)].unlocked
	if unlocked and self.loadMap(path):
		references["guiRoot"].setCurrentGUI("gameUI")
		references["soundController"].playMusic(fileReferences["ingameMusic"])
		references["gameController"].init(self)
		references["inputController"].init(self)
		currents["map"] = mapIndex

func quitLevel():
	references["guiRoot"].showDialog(false,"")
	references["gameController"].end(self)
	references["inputController"].end(self)
	self.unloadMap()
	self.writeUserDataToFile()
	references["guiRoot"].getGUI("levelMenu").updateLevelSelector()
	references["guiRoot"].setCurrentGUI("levelMenu")

func unlockLevel(mapIndex):
	mapReferences[mapIndex.containerIndex]["levels"][str(mapIndex.levelIndex)].unlocked = true

func saveLevel(score,candy):
	if score > mapReferences[str(currents["map"].containerIndex)]["levels"][str(currents["map"].levelIndex)].bestScore:
		mapReferences[str(currents["map"].containerIndex)]["levels"][str(currents["map"].levelIndex)].score = score
	if candy > mapReferences[str(currents["map"].containerIndex)]["levels"][str(currents["map"].levelIndex)].bestCandy:
		mapReferences[str(currents["map"].containerIndex)]["levels"][str(currents["map"].levelIndex)].bestCandy = candy

func quitGame():
	OS.get_main_loop().quit()
	pass
	

#======================================
#==========SETTER & GETTER=============
#======================================

func getNextLevel():
	if int(currents["map"].levelIndex) < mapReferences[str(currents["map"].containerIndex)].size():
		return  {"containerIndex":currents["map"].containerIndex,"levelIndex":str(int(currents["map"].levelIndex)+1)}
	else:
		return  {"containerIndex":currents["map"].containerIndex+1,"levelIndex":"1"}


func getSettings(settingName):
	return settings[settingName]
	pass
	
func _fixed_process(delta):
	references["gameController"]._fixed_process(delta)
	pass

func _input(event):
	references["inputController"]._input(event,self, "global")
	pass