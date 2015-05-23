
extends Sprite

var currentMap 
var objectAttribute
var references
var currents = {}

func _ready():
	# Initialization here
	pass

	
func init(map, cellData):
	currentMap = map
	self.initReferences()
	self.initObjectAttribute(cellData.objectAttribute)
	self.initCurrents()
	self.setPosition(map, cellData)
	pass

func initReferences():
	pass

func initCurrents():
	currents["position"] = {
		"x":"",
		"y":"",
		"z":"",
		"direction":"",
		"worldPosition":Vector2()
	}
	pass

func initObjectAttribute(attribute):
	objectAttribute = attribute
	pass
	
func setPosition(map, cellData):
	var worldPosition = map.map_to_world(Vector2(cellData.x,cellData.y), false)
	currents["position"]  = {"x":cellData.x,"y":cellData.y,"z":cellData.z,"direction":cellData.objectAttribute.direction,"worldPosition":worldPosition}
	
func getPosition():
	return currents["position"]

func updateObject():
	pass

func resetObject():
	pass

func getObjectAttribute():
	return objectAttribute