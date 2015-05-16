
extends Control

var references={
	"levelBtn" : "",
	"levelLbl" : "",
	"candyContainer" : "",
	"guiRoot":"",
	"rootNode": ""
}

var mapPath = ""
var btnIndex = 1
var bestCandy
var unlocked

func _ready():
	# Initialization here
	initReferences()
	initConnections()
	pass
func init(path,unlock,candy, index):
	self.setMapPath(path)
	self.setUnlocked(unlock)
	self.setBestCandy(candy)
	self.setIndex(index)
	pass

func initReferences():
	references["levelBtn"] = self.get_node("level_button")
	references["levelLbl"] = self.get_node("level_button/Label")
	references["candyContainer"] = self.get_node("candyContainer")
	references["rootNode"] = self.get_node("/root").get_child(self.get_node("/root").get_child_count()-1)
	references["guiRoot"] = references["rootNode"].get_node("gui_layer/canvas_item/gui_root")
	pass

func initConnections():
	references["levelBtn"].connect("pressed", self, "loadMap")
	pass

func loadMap():
	references["guiRoot"].buttonPressed("loadMap", [mapPath])
	

func setMapPath(path):
	mapPath = path
	pass
	
func getMapPath():
	return mapPath
	pass

func setIndex(index):
	btnIndex = index;
	references["levelLbl"].set_text(str(btnIndex))
	
func getIndex():
	return btnIndex

func setUnlocked(unlock):
	unlocked = unlock
	pass

func setBestCandy(candy):
	bestCandy = candy
	for candy in references["candyContainer"].get_children():
		candy.set_disabled(true)
	for i in range(candy):
		references["candyContainer"].get_child(i).set_disabled(false)
	pass