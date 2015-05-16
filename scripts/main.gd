
extends Control

var settings = {
	'SOUND_ENABLED' : false,
	'LANGUAGE' : 'en'
}
var fileReferences = {
	"mainMenuMusic" : "res://assets/music/mainmenu.ogg",
	"ingameMusic" : "res://assets/music/ingame.ogg"
}

var mapReferences = {
	"Procedural": {
		"proc1":{
			"bestCandy":2,
			"unlocked":true,
			"mapPath":"user://maps/kampret.acdmap"
		},
		"proc2":{
			"bestCandy":0,
			"unlocked": false,
			"mapPath":"asd"
		}
	},
	"Looping": {
		"loop1":{
			"bestCandy":1,
			"unlocked":true,
			"mapPath":""
		},
		"loop2":{
			"bestCandy":3,
			"unlocked": false,
			"mapPath":""
		}
	},
}

var settingFile = File.new()

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
	"map" : "",
	"GUI" : "",
	"music":"",
} 

#========================================
#=============GODOT FUNCTION=============
#========================================

func _ready():
	# Initialization here
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	self.initReferences()
#	self.readSettingsFromFile()
	self.settingsChanged()
	self.playMusic("mainMenuMusic")
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
	print(settingName + " " + str(settings[settingName]))
	settingsChanged()
	pass

func settingsChanged():
	if(settings["SOUND_ENABLED"] == false):
		self.references["soundController"].muteMusic(true)
	else:
		self.references["soundController"].muteMusic(false)

func playMusic(title):
	if fileReferences[title] :
		references["soundController"].playMusic(fileReferences[title])
		self.setCurrents("music", title)

func loadMap(path):
	if path :
		var temp = prefabs["mapTemplate"].instance()
		temp.init(self,path)
		references["worldRoot"].add_child(temp)
	pass

func readSettingsFromFile():
	var temp
	if settingFile.file_exists("user://savedata.acd"):
		settingFile.open("user://savedata.acd", File.READ)
		temp = settingFile.get_var()
		settings = temp
		temp = settingFile.get_var()
		fileReferences = temp
		temp = settingFile.get_var()
		mapReferences = temp
		print("setting loaded")
	else:
		self.writeSettingsToFile()
		print("failed to read setting, attempt to write")
	settingFile.close()

func writeSettingsToFile():
	settingFile.open("user://savedata.acd", File.WRITE)
	settingFile.store_var(self.settings)
	settingFile.store_var(self.fileReferences)
	settingFile.store_var(self.mapReferences)
	settingFile.close()
	print("setting saved")

func startGame(path):
	references["guiRoot"].setCurrentGUI("gameUI")
	references["soundController"].playMusic(fileReferences["ingameMusic"])
	self.loadMap(path)
	references["gameController"].init(self)
	references["inputController"].init(self)
	references["gameController"].startGame()
#======================================
#==========SETTER & GETTER=============
#======================================

func setCurrents(name, value):
	currents[name] = value

func getSettings(settingName):
	return settings[settingName]
	pass
	
func _fixed_process(delta):
	references["gameController"]._fixed_process(delta)
	pass

func _input(event):
	references["inputController"]._input(event)
	pass