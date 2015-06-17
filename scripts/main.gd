
extends Control

const USER_MAP_PATH = 	{	"X11":"user://",
							"Android":"/storage/sdcard0/com.pixcap.ada/"
#							"Android":"user://"
						}

var settings ={}
var userdata ={}

#var fileReferences = {
#	"mainMenuMusic" : "res://assets/music/mainmenu.ogg",
#	"ingameMusic" : "res://assets/music/ingame.ogg"
#}

#var mapReferences = {
#	"1": {
#		"title":"Procedural",
#		"levels":{
#			"1":{
#				"title":"Procedural 1",
#				"bestCandy":0,
#				"bestScore":0,
#				"unlocked":true,
#				"path":"user://maps/procedural1.acdmap"
#			},
#			"2":{
#				"title":"Procedural 2",
#				"bestCandy":0,
#				"bestScore":0,
#				"unlocked": false,
#				"path":"user://maps/procedural2.acdmap"
#			}
#		}
#	},
#	"2": {
#		"title":"Looping",
#		"levels":{
#			"1":{
#				"title":"Looping 1",
#				"bestCandy":0,
#				"bestScore":0,
#				"unlocked":false,
#				"path":""
#			},
#			"2":{
#				"title":"Looping 2",
#				"bestCandy":0,
#				"bestScore":0,
#				"unlocked": false,
#				"path":""
#			}
#		}
#	},
#}

var file = File.new()
var directory = Directory.new()

var prefabs= {
	"mapTemplate": preload("res://map/map_template.scn")
}

var references = {
	"worldRoot": null,
	"guiRoot": null,
	"soundController":null,
	"gameController":null,
	"inputController":null,
	"editorController":null,
}

var currents = {
	"map" : {},
	"music":"",
	"controller":null,
	"CURSOR_ENABLED": true,
	"MAP_STARTED": false,
	"userMapPath": ""
} 

#========================================
#=============GODOT FUNCTION=============
#========================================

func _ready():
	# Initialization here
#	print("setting: "+ str(settings))
#	print("userdata: "+ str(userdata))
	
	self.initReferences()
	
	if OS.get_name() == "Android":
		currents["CURSOR_ENABLED"] = false 
		self.get_tree().set_auto_accept_quit(false)
	references["cursor"].show()
	self.playMusic("mainMenuMusic")
	self.settingsChanged("")
	references["guiRoot"].init()
	references["mapRoot"].init(self)
	
#	var conversTest ={
#		0:{"text":"Ini Teks 1 Lho",
#			"actor":"ada",
#			"emotion":"normal",
#			"currentAction":[["showFocusedItem",[true,"house"]]],
#			"nextAction":[["showFocusedItem",[false,"house"]],["goTo",[1]]]
#		},
#		1:{
#			"text":"Ini Teks 2 Lho",
#			"actor":"ada",
#			"emotion":"normal",
#			"currentAction":[["showFocusedItem",[true,"teleporter"]]],
#			"nextAction":[["showFocusedItem",[false,"teleporter"]],["endConversation",""]]
#		}
#	}
#	references["guiRoot"].showConversation(true,conversTest)
	pass
	
func _init():

	settings = {
		'SOUND_ENABLED' : "On",
		'LANGUAGE' : 'en'
	}

	userdata ={
		"fileReferences": 	{
							"mainMenuMusic" : "res://assets/music/mainmenu.ogg",
							"ingameMusic" : "res://assets/music/ingame.ogg"
						},
		"mapReferences":	{
							"1": {
								"title":"Procedural",
								"levels":{
									"1":{
										"title":"Procedural 1",
										"bestCandy":0,
										"bestScore":0,
										"unlocked":true,
										"path":"res://map/map_data/procedural1.acdmap"
									},
									"2":{
										"title":"Procedural 2",
										"bestCandy":0,
										"bestScore":0,
										"unlocked": false,
										"path":"res://map/map_data/procedural2.acdmap"
									}
								}
							}
						}
	}

	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	self.manageUserDirectory()
	if self.readFromFile("user://config/settings.acd") != null:
		settings = self.readFromFile("user://config/settings.acd")
	else:
		self.writeToFile("user://config/settings.acd", settings)
	if self.readFromFile("user://config/userdata.acd") != null:
		userdata = self.readFromFile("user://config/userdata.acd")
	else:
		self.writeToFile("user://config/userdata.acd", userdata)
	TranslationServer.set_locale(settings["LANGUAGE"])
	

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST and OS.get_name() == "Android":
		references["guiRoot"].backAction()
#======================================
#=============OWN FUNCTION=============
#======================================

func initReferences():
	references["worldRoot"] = self.get_node("world_root")
	references["mapRoot"] = references["worldRoot"].get_node("map_root")
	references["guiRoot"] = self.get_node("gui_layer/canvas_item/gui_root")
	references["soundController"] = preload("res://scripts/sound_controller.gd").new()
	references["gameController"] = preload("res://scripts/game_controller.gd").new()
	references["editorController"] = preload("res://scripts/editor_controller.gd").new()
	references["debug"] = self.get_node("debug")
	references["cursor"] = self.get_node("gui_layer/canvas_item/Cursor")
	if OS.get_name() == "Android":
		references["inputController"] = preload("res://scripts/android_input_controller.gd").new()
	else:
		references["inputController"] = preload("res://scripts/input_controller.gd").new()
	references["soundController"].init(self)

func changeSettings(settingName, newValue):
	settings[settingName] = newValue
	self.settingsChanged(settingName)
	pass

func settingsChanged(settingName):
	if settings["SOUND_ENABLED"] == "On":
		self.references["soundController"].muteMusic(false)
	else:
		self.references["soundController"].muteMusic(true)
		
	if settingName == "LANGUAGE":
		references["guiRoot"].showDialog(true,self,"yesno",["restart"])
		
	self.writeToFile("user://config/settings.acd", settings)

func playMusic(title):
	if userdata.fileReferences.has(title) :
		references["soundController"].playMusic(userdata.fileReferences[title])
		currents["music"] = title

func loadMap(path, editorMode):
	if path :
		references["mapRoot"].loadMap(path, editorMode)
		return true
	else:
		return false
	pass

func unloadMap():
	references["mapRoot"].clearMap()
	references["mapRoot"].showObjects(false)
	references["mapRoot"].setEditorMode(false)
	
func manageUserDirectory():
	if OS.get_name() == "Android":
		directory.open("/storage/sdcard0")
		if not directory.dir_exists("com.pixcap.ada"):
			directory.make_dir("com.pixcap.ada")
			
		directory.change_dir("com.pixcap.ada")
			
		if not directory.dir_exists("map"):
			directory.make_dir("map")
				
	elif OS.get_name() == "X11":
		directory.open("user://")
		if not directory.dir_exists("map"):
			directory.make_dir("map")
			
	directory.open("user://")
	if not directory.dir_exists("config"):
		directory.make_dir("config")
	
	currents["userMapPath"] = USER_MAP_PATH[OS.get_name()]
	pass

func readFromFile(filePath):
	if file.file_exists(filePath):
		file.open(filePath, File.READ)
		var temp = file.get_var()
#			print("read "+fileName +": " + str(file.get_var()))
#			if fileName == "settings":
#				print("setting loaded")
#			elif fileName == "userdata":
#				temp = file.get_var()
#				fileReferences = temp
#				temp = file.get_var()
#				mapReferences = temp
#				print("userdata loaded")
		file.close()
		return temp
	else:
#		self.writeToFile(dir, fileName, variable)
		return null
	
func writeToFile(filePath, variable):
	file.open(filePath, File.WRITE)
	file.store_var(variable)
	file.close()
	return true


func startLevel(mapIndex):
	if currents["MAP_STARTED"]:
		self.quitLevel()
	if mapIndex != null:
		var path = userdata.mapReferences[str(mapIndex.containerIndex)]["levels"][str(mapIndex.levelIndex)].path
		var unlocked = userdata.mapReferences[str(mapIndex.containerIndex)]["levels"][str(mapIndex.levelIndex)].unlocked
		if unlocked and self.loadMap(path, false):
			references["guiRoot"].setCurrentGUI("gameUI")
			references["soundController"].playMusic(userdata.fileReferences["ingameMusic"])
			references["gameController"].init(self)
			references["inputController"].init(self)
			currents["controller"] = references["gameController"]
			currents["map"] = mapIndex
			currents["MAP_STARTED"] = true
	
func quitLevel():
	references["guiRoot"].showDialog(false,"","","")
	currents["controller"] = null
	references["gameController"].end(self)
	references["inputController"].end(self)
	self.unloadMap()
	self.writeToFile("user://config/userdata.acd", userdata)
	references["guiRoot"].getGUI("levelMenu").updateLevelSelector()
	references["guiRoot"].setCurrentGUI("levelMenu")
	currents["MAP_STARTED"] = false

func retryLevel():
	references["gameController"].retryLevel()

func unlockLevel(mapIndex):
	if mapIndex != null:
		userdata.mapReferences[str(mapIndex.containerIndex)]["levels"][str(mapIndex.levelIndex)].unlocked = true

func saveLevel(score,candy):
	if score > userdata.mapReferences[str(currents["map"].containerIndex)]["levels"][str(currents["map"].levelIndex)].bestScore:
		userdata.mapReferences[str(currents["map"].containerIndex)]["levels"][str(currents["map"].levelIndex)].score = score
	if candy > userdata.mapReferences[str(currents["map"].containerIndex)]["levels"][str(currents["map"].levelIndex)].bestCandy:
		userdata.mapReferences[str(currents["map"].containerIndex)]["levels"][str(currents["map"].levelIndex)].bestCandy = candy

func startPreviewMode():
	references["soundController"].playMusic(userdata.fileReferences["ingameMusic"])
	references["mapRoot"].setPreviewMode(true)	
	
	references["guiRoot"].setCurrentGUI("gameUI")
	references["gameController"].init(self)
	
	references["guiRoot"].getGUI("gameUI").setPreviewMode(true)
	references["gameController"].setPreviewMode(true)
	currents["controller"] = references["gameController"]

	references["inputController"].init(self)

func quitPreviewMode():
	references["guiRoot"].showDialog(false,"","","")
	references["mapRoot"].setPreviewMode(false)
	references["guiRoot"].getGUI("gameUI").setPreviewMode(false)
	
	references["gameController"].end(self)
	references["editorController"].init(self)
	currents["controller"] = references["editorController"]
	
	references["inputController"].init(self)	
	references["guiRoot"].setCurrentGUI("editorUI")
	
	references["gameController"].setPreviewMode(false)
	

func startEditor():
	self.loadMap("res://map/map_data/editordefault.acdmap", true)
	references["editorController"].init(self)
	references["inputController"].init(self)
	references["guiRoot"].setCurrentGUI("editorUI")
	currents["controller"] = references["editorController"]
	currents["MAP_STARTED"] = true
	pass

func quitEditor():
	references["guiRoot"].setCurrentGUI("mainMenu")
	references["editorController"].end(self)
	references["inputController"].end(self)
	currents["controller"] = null
	self.unloadMap()
	currents["MAP_STARTED"] = false
	pass

func quitGame():
	OS.get_main_loop().quit()
	pass
	
func restartGame():
	self.get_node("/root/global").restartGame()
#======================================
#==========SETTER & GETTER=============
#======================================

func getNextLevel():
	if int(currents["map"].levelIndex) < userdata.mapReferences[str(currents["map"].containerIndex)].size():
		return  {"containerIndex":currents["map"].containerIndex,"levelIndex":str(int(currents["map"].levelIndex)+1)}
	elif int(currents["map"].containerIndex) < userdata.mapReferences.size():
		return  {"containerIndex":int(currents["map"].containerIndex)+1,"levelIndex":"1"}
	else: 
		return null

func getSettings(name):
	return settings[name]
	pass

func getUserdata(name):
	return userdata[name]

func _fixed_process(delta):
	currents["controller"]._fixed_process(delta)
	pass

func _input(event):
	references["inputController"]._input(event,self, "global")
	pass
	
func getGUIRoot():
	return self.get_node("gui_layer/canvas_item/gui_root")

func getWorldRoot():
	return self.get_node("world_root")

func getCurrentController():
	return currents["controller"]

func getUserMapPath(filename):
	return currents["userMapPath"] + "map/"+ filename + ".acdmap"

func isMapStarted():
	return currents["MAP_STARTED"]
	
