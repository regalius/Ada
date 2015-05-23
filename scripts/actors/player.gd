
extends KinematicBody2D

const MOTION_SPEED=160
const OFFSET_X = 0
const OFFSET_Y = 0

const MAX_ZOOM = 1
const MIN_ZOOM = 10
const ZOOM_SPEED = .1
const SLIDE_SPEED = 2
const SLIDE_ACCELERATION = .05

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
	"CAMERA_SLIDING":false,
	"CAMERA_CAN_MOVE":true,
	"zoomLevel":0,
	"slideVector": Vector2(),
	"slideSpeed":0
}


func _ready():
	# Initialization here
#	self.set_fixed_process(true)
	pass

func _fixed_process(delta):
	handleMovement(delta)
	handleCameraSlide(delta)
		
func init(mapRoot, position):
	self.initReferences(mapRoot)
	self.setPosition(position)
	pass

func initReferences(mapRoot):
	references["mapRoot"] = mapRoot
	references["map"] = mapRoot.get_node("ground")
	references["camera"] = self.get_node("camera")
	
func moveTo(position):
	if references["map"].get_cell(position.x,position.y) == references["mapRoot"].PATH_TILE_INDEX and not currents["ACTION_STATE"] == "moveTo":
		currents["newpos"].x= position.x
		currents["newpos"].y= position.y
		currents["newpos"].z= position.z
		currents["newpos"].direction= position.direction
		currents["newpos"]["worldPosition"]= self.getWorldPosition(Vector2(position.x,position.y))
		currents["ACTION_STATE"] = "moveTo"
	pass

func determineNextPos():
	var newPos={}
	if currents["position"].direction == "front":
		newPos["x"] = currents["position"].x-1
		newPos["y"] = currents["position"].y
		pass
	elif currents["position"].direction == "back":
		newPos["x"] = currents["position"].x+1
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
	elif action=="deliver":
		self.deliverItem()
	elif action=="turnLeft":
		self.turn("left")
	elif action=="turnRight":
		self.turn("right")
	pass

func moveAction():
	self.moveTo(self.determineNextPos())
	
func deliverItem():
	var newPos = self.determineNextPos()
	if references["mapRoot"].getObjectAt("house", newPos.x,newPos.y):
		references["mapRoot"].getObjectAt("house", newPos.x,newPos.y).receiveItem(true, newPos)
		
func turn(dir):
	if currents["position"].direction == "front":
		if dir=="left":
			currents["position"].direction = "left"
		else:
			currents["position"].direction = "right"
	elif currents["position"].direction == "back":
		if dir=="left":
			currents["position"].direction = "right"
		else:
			currents["position"].direction = "left"
	elif currents["position"].direction == "left":
		if dir=="left":
			currents["position"].direction = "back"
		else:
			currents["position"].direction = "front"
	elif currents["position"].direction == "right":
		if dir=="left":
			currents["position"].direction = "front"
		else:
			currents["position"].direction = "back"
	
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

func handleCameraSlide(delta):
	if currents["CAMERA_SLIDING"]:
		var moveVector = Vector2()
		if currents["slideSpeed"] > 0 :
			moveVector = currents["slideVector"] * currents["slideSpeed"]
			references["camera"].set_pos(references["camera"].get_pos() - moveVector)
			currents["slideSpeed"]-=SLIDE_ACCELERATION
#			print("slideSpeed :"+str(currents["slideSpeed"])+" | moveVector : " + str(moveVector)+" | slideVector : "+ str(currents["slideVector"]))
		else:
			currents["CAMERA_SLIDING"] = false
	pass

func inRange(point1, point2, deviation):
	if point2.x-deviation <= point1.x and point1.x <= point2.x+deviation and point2.y-deviation <= point1.y and point1.y <= point2.y+deviation :
		return true
	else:
		return false

func zoomCamera(command):
	if currents["CAMERA_CAN_MOVE"]:
		currents["zoomLevel"] = references["camera"].get_zoom().x
		if command =="in" and currents["zoomLevel"] > MAX_ZOOM:
			currents["zoomLevel"] -= ZOOM_SPEED
			references["camera"].set_zoom(Vector2(currents["zoomLevel"],currents["zoomLevel"]))
			pass
		elif command =="out" and currents["zoomLevel"] < MIN_ZOOM:
			currents["zoomLevel"] += ZOOM_SPEED
			references["camera"].set_zoom(Vector2(currents["zoomLevel"],currents["zoomLevel"]))
			pass


func moveCamera(moveVector):
	if currents["CAMERA_CAN_MOVE"]:
		references["camera"].set_pos(references["camera"].get_pos() - moveVector)
		currents["slideVector"] = Vector2(moveVector.x, moveVector.y)

func slideCamera():
	if currents["CAMERA_CAN_MOVE"]:
		currents["CAMERA_SLIDING"] = true
		currents["slideSpeed"] = SLIDE_SPEED

func resetCamera():
	if currents["CAMERA_CAN_MOVE"]:
		references["camera"].set_pos(Vector2(0,0))


func setPosition(position):
	currents["position"].x = position.x
	currents["position"].y = position.y
	currents["position"].z = position.z
	currents["position"].direction = position.direction
	currents["position"]["worldPosition"] = self.getWorldPosition(Vector2(position.x,position.y))
#	currents["newpos"] = currents["position"]
	self.set_pos(currents["position"]["worldPosition"])

func getPosition():
	return currents["position"]

func getWorldPosition(position):
	return Vector2(references["map"].map_to_world(position, false ).x+OFFSET_X,references["map"].map_to_world(position, false ).y+OFFSET_Y)

func getCurrentActionState():
	return currents["ACTION_STATE"]