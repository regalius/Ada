
extends Sprite

var references={}


func _ready():
	# Initialization here
	self.init()
	pass

func init():
	self.initReferences()
	pass

func initReferences():
	references["rootNode"] = self.get_node("/root").get_child(self.get_node("/root").get_child_count()-1)
	references["mapRoot"] = self.get_parent()
	references["map"] = references["mapRoot"]
	pass

func setPosition(position):
	var mapPos = references["mapRoot"].getMapPosition(position)
	if mapPos.x >=0 and mapPos.y >=0:
		self.set_pos(references["mapRoot"].getWorldPosition(mapPos))
