
extends Control

var references={}

var currents={
	"mapIndex": {},
	"bestCandy": 0,
	"unlocked" : false,
}

func _ready():
	# Initialization here
	pass
	
func init(mapIndex,unlock,candy):
	self.initReferences()
	self.initConnections()
	self.setMapIndex(mapIndex)
	self.setUnlocked(unlock)
	self.setBestCandy(candy)
	pass

func initReferences():
	references["levelBtn"] = self.get_node("level_btn")
	references["candyContainer"] = self.get_node("bot/candy_container")
	references["candy1"] = references["candyContainer"].get_node("1")
	references["candy2"] = references["candyContainer"].get_node("2")
	references["candy3"] = references["candyContainer"].get_node("3")
	references["rootNode"] = self.get_node("/root").get_child(self.get_node("/root").get_child_count()-1)
	references["guiRoot"] = references["rootNode"].getGUIRoot()
	pass

func initConnections():
	references["levelBtn"].connect("pressed", self, "loadMap")
	references["candy1"].connect("pressed", self, "loadMap")
	references["candy2"].connect("pressed", self, "loadMap")
	references["candy3"].connect("pressed", self, "loadMap")
	pass

func loadMap():
	references["rootNode"].startLevel(currents["mapIndex"])
	
func setMapIndex(mapIndex):
	currents["mapIndex"] = mapIndex
	references["levelBtn"].set_text(str(currents["mapIndex"].levelIndex))

func getMapIndex():
	return currents["mapIndex"]

func setUnlocked(unlock):
	currents["unlocked"] = unlock
	if not currents["unlocked"] :
		references["candyContainer"].hide()
		references["levelBtn"].set_disabled(true)
	else:
		references["candyContainer"].show()
		references["levelBtn"].set_disabled(false)
	pass

func setBestCandy(candy):
	currents["bestCandy"] = candy
	for candy in references["candyContainer"].get_children():
		candy.set_disabled(true)
	for i in range(1, candy):
		references["candyContainer"].get_node(str(i)).set_disabled(false)
	pass