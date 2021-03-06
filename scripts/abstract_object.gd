
extends Node2D

var currentMap 
var objectAttribute= {}
var defaultAttribute={}
var references={}
var currents = {}
var type

func _ready():
	# Initialization here
	pass

	
func init(map, cellData):
	currentMap = map
	self.initReferences()
	self.setObjectAttribute(cellData.objectAttribute)
	self.initCurrents()
	self.setPosition(map, cellData)
	pass

func initReferences():
	references["animation"] = self.get_node("animation")
	pass

func destroy(map):
	self.queue_free()

func initCurrents():
	currents["position"] = {
		"x":"",
		"y":"",
		"z":"",
		"direction":"",
		"worldPosition":Vector2()
	}
	pass

	
func setPosition(map, cellData):
	var worldPosition = map.map_to_world(Vector2(cellData.x,cellData.y), false)
	var direction
	if cellData.objectAttribute.has("direction"):
		direction = cellData.objectAttribute.direction
	else:
		direction = objectAttribute.direction
	currents["position"]  = {"x":cellData.x,"y":cellData.y,"z":cellData.z,"direction":direction,"worldPosition":worldPosition}
	self.updateSprite("idle")
	
func getPosition():
	return currents["position"]

func interact(actor, newPos):
	pass

func updateObject():
	pass

func resetObject():
	pass

func setObjectAttribute(attribute):
	if not attribute.empty():
		objectAttribute = attribute
	else:
		objectAttribute = defaultAttribute
		
	if currents.has("position"):
		self.setPosition(currentMap, {"x": currents["position"].x,"y": currents["position"].y, "z": currents["position"].z, "objectAttribute": objectAttribute})
	self.resetObject()
	pass
	
func getObjectAttribute():
	return objectAttribute

func setType(what):
	type = what

func updateSprite(state):
	if currents.has("position"):
		references["animation"].play(state+"_"+str(currents["position"].direction))

func getType():
	return type