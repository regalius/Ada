
extends KinematicBody2D

const MOTION_SPEED=160
const OFFSET_X = 0
const OFFSET_Y = 0

#const MAX_ZOOM = 1
#const MIN_ZOOM = 10
#const ZOOM_SPEED = .1
#const SLIDE_SPEED = 2
#const SLIDE_ACCELERATION = .05

var references={
	"map":"",
	"mapRoot":"",
	"camera":""
}

var currents={
	"position":{
		"direction":"",
		"x":0,
		"y":0,
		"z":0,
		"worldPosition":Vector2()
	},
	"newpos":{
		"direction":"",
		"x":0,
		"y":0,
		"z":0,
		"worldPosition":Vector2()
	},
	"ACTION_STATE":"idle",
#	"CAMERA_SLIDING":false,
#	"CAMERA_CAN_MOVE":true,
#	"zoomLevel":0,
#	"slideVector": Vector2(),
#	"slideSpeed":0
}


func _ready():
#	Initialization here
#	self.set_fixed_process(true)
	pass

func _fixed_process(delta):
	self.handleMovement(delta)
#	handleCameraSlide(delta)
	
func init(mapRoot):
	self.initReferences(mapRoot)
	currents["position"]= {"x":0,"y":0,"z":0,"direction":"front"}
	self.setPosition(currents["position"], true)
	pass
	
func initReferences(mapRoot):
	references["mapRoot"] = mapRoot
	references["map"] = mapRoot.get_node("ground")
	references["camera"] = self.get_node("camera")
	references["sprite"] = self.get_node("sprite")
	references["animation"] = self.get_node("animation")
	
func moveTo(position):
	if references["map"].get_cell(position.x,position.y) == references["mapRoot"].getTileIndex("path") and not currents["ACTION_STATE"] == "moveTo":
		currents["newpos"].x= position.x
		currents["newpos"].y= position.y
		currents["newpos"].z= position.z
		currents["newpos"].direction= position.direction
		currents["newpos"]["worldPosition"]= references["mapRoot"].getWorldPosition(Vector2(position.x,position.y))
		currents["ACTION_STATE"] = "moveTo"
	pass

func determineNextPos():
	var newPos={}
	if currents["position"].direction == "front":
		newPos["x"] = currents["position"].x+1
		newPos["y"] = currents["position"].y
		pass
	elif currents["position"].direction == "back":
		newPos["x"] = currents["position"].x-1
		newPos["y"] = currents["position"].y
		pass
	elif currents["position"].direction == "left":
		newPos["x"] = currents["position"].x
		newPos["y"] = currents["position"].y+1
		pass
	elif currents["position"].direction == "right":
		newPos["x"] = currents["position"].x
		newPos["y"] = currents["position"].y-1
		pass
	newPos["z"] = currents["position"].z
	newPos["direction"] = currents["position"].direction
	return newPos

func doAction(action):
	if action=="move":
		self.moveAction()
	elif action=="interact":
		self.interact()
	elif action=="turnLeft":
		self.turn("left")
	elif action=="turnRight":
		self.turn("right")
		
	self.updateSprite("idle")
	pass

func moveAction():
	self.moveTo(self.determineNextPos())
	
func interact():
	var newPos = self.determineNextPos()
	var object = references["mapRoot"].getObjectAt(Vector2(newPos.x,newPos.y))
	if object:
		self.onInteract(object.getType())
		object.interact(self, newPos)
		
func turn(dir):
	if currents["position"].direction == "front":
		if dir=="left":
			currents["position"].direction = "right"
		else:
			currents["position"].direction = "left"
	elif currents["position"].direction == "back":
		if dir=="left":
			currents["position"].direction = "left"
		else:
			currents["position"].direction = "right"
	elif currents["position"].direction == "left":
		if dir=="left":
			currents["position"].direction = "front"
		else:
			currents["position"].direction = "back"
	elif currents["position"].direction == "right":
		if dir=="left":
			currents["position"].direction = "back"
		else:
			currents["position"].direction = "front"
			
	
func handleMovement(delta):
	if currents["ACTION_STATE"] == "moveTo":
		var motionVector = Vector2()
		if not self.inRange(currents["position"]["worldPosition"], currents["newpos"]["worldPosition"], 5):
			if currents["newpos"].x < currents["position"].x: 
				# move_front
				motionVector+=Vector2(-2,-1)
			elif currents["newpos"].x > currents["position"].x:
				# move_back
				motionVector+=Vector2(2,1)
			elif currents["newpos"].y < currents["position"].y:
				#move_right
				motionVector+=Vector2(1,-.5)
			elif  currents["newpos"].y > currents["position"].y: 
				#move_left	
				motionVector+=Vector2(-1,.5)
				
			currents["position"]["worldPosition"] = Vector2(floor(self.get_pos().x),floor(self.get_pos().y))	
			motionVector = motionVector.normalized() * MOTION_SPEED * delta
			motionVector = move(motionVector)
			
		else :
			currents["ACTION_STATE"] = "idle"
			currents["position"].x = currents["newpos"].x
			currents["position"].y = currents["newpos"].y
			currents["position"].z = currents["newpos"].z
			currents["position"].direction = currents["newpos"].direction

func inRange(point1, point2, deviation):
	if point2.x-deviation <= point1.x and point1.x <= point2.x+deviation and point2.y-deviation <= point1.y and point1.y <= point2.y+deviation :
		return true
	else:
		return false

func setPosition(position, ignore):
	var groundType = "null"
	if not ignore:
		var cell = references["mapRoot"].getMapDataCell(position.x,position.y,position.z)
		if cell != null:
			groundType = references["mapRoot"].getTileType(cell.groundType)
	
	if groundType == "path" or ignore:
		currents["position"].x = position.x
		currents["position"].y = position.y
		currents["position"].z = position.z
		currents["position"].direction = position.direction
		currents["position"]["worldPosition"] = references["mapRoot"].getWorldPosition(Vector2(position.x,position.y))
	#	currents["newpos"] = currents["position"]
		self.set_pos(currents["position"]["worldPosition"])
		self.updateSprite("idle")
		return true
	return false

func updateSprite(state):
	references["animation"].play(state+"_"+currents["position"].direction)

func onInteract(type):
	if type == "house":
		pass
	elif type == "teleporter":
		pass

func getPosition():
	return currents["position"]

func getCurrentActionState():
	return currents["ACTION_STATE"]