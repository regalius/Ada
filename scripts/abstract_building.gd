
extends Sprite

# member variables here, example:
# var a=2
# var b="textvar"
var position
var currentMap 
var objectAttribute
var references

func _ready():
	# Initialization here
	pass

func initReferences():
	pass
	
func init(map, objectAttribute):
	currentMap = map
	self.updatePosition()
	self.initReferences()
	self.initObjectAttribute(objectAttribute)
	pass

	
func updatePosition():
	position = currentMap.world_to_map(self.get_pos())

func initObjectAttribute(attribute):
	objectAttribute = attribute
	pass
	
func isPosition(x,y):
	if position.x == x and position.y == y:
		return true
	else:
		return false
		
func getObjectAttribute():
	return objectAttribute