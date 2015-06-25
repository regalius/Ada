
extends Camera2D

var MAX_ZOOM = 1
var MIN_ZOOM = 10
var INITIAL_POSITION= Vector2(0,0)
var INITIAL_ZOOM= Vector2(5,5)


var ZOOM_SPEED
var SLIDE_SPEED
var SLIDE_ACCELERATION
var MOVE_SPEED
var MAX_X 
var MAX_Y 
var MIN_X 
var MIN_Y 

var currents={}
var references ={}

func _ready():
	pass

func init(mapRoot):
	self.initReferences(mapRoot)
	self.initCurrents()
	
	ZOOM_SPEED = .1
	SLIDE_SPEED = 2
	SLIDE_ACCELERATION = .05
	MOVE_SPEED = .5
		
func _fixed_process(delta):
	self.handleCameraSlide(delta)

func initReferences(mapRoot):
	references["mapRoot"] = mapRoot
	references["ground"] = mapRoot.references["ground"]

func initCurrents():
	currents["CAMERA_SLIDING"]=false
	currents["CAMERA_CAN_MOVE"]=true
	currents["zoomLevel"]= self.get_zoom().x
	currents["slideVector"]= Vector2()
	currents["slideSpeed"]=0
	self.setMaxPos(references["mapRoot"].getMapSize(), references["ground"].get_cell_size())
	pass
	
func handleCameraSlide(delta):
	if currents["CAMERA_SLIDING"]:
		var moveVector = Vector2()
		if currents["slideSpeed"] > 0 :
			moveVector = currents["slideVector"] * currents["slideSpeed"]
			self.move(moveVector,false)
			currents["slideSpeed"]-=SLIDE_ACCELERATION
#			print("slideSpeed :"+str(currents["slideSpeed"])+" | moveVector : " + str(moveVector)+" | slideVector : "+ str(currents["slideVector"]))
		else:
			currents["CAMERA_SLIDING"] = false
	pass

func zoom(command):
	currents["zoomLevel"] = self.get_zoom().x
	if command =="in" and currents["zoomLevel"] > MAX_ZOOM:
		currents["zoomLevel"] -= ZOOM_SPEED
		self.set_zoom(Vector2(currents["zoomLevel"],currents["zoomLevel"]))
		pass
	elif command =="out" and currents["zoomLevel"] < MIN_ZOOM:
		currents["zoomLevel"] += ZOOM_SPEED
		self.set_zoom(Vector2(currents["zoomLevel"],currents["zoomLevel"]))
		pass

func move(moveVector,slide):
	if currents["CAMERA_CAN_MOVE"]:
		var newPos= self.thresholdPosition(self.get_pos() - moveVector * MOVE_SPEED)
		self.set_pos(newPos)
		if slide:
			currents["slideVector"] = Vector2(moveVector.x, moveVector.y)

func slide():
	if currents["CAMERA_CAN_MOVE"]:
		currents["CAMERA_SLIDING"] = true
		currents["slideSpeed"] = SLIDE_SPEED

func reset():
	if currents["CAMERA_CAN_MOVE"]:
		self.set_pos(INITIAL_POSITION)

func thresholdPosition(position):
	var newPos = position
	if newPos.x > MAX_X:
		newPos.x = MAX_X
	elif newPos.x < MIN_X:
		newPos.x = MIN_X
		
	if newPos.y > MAX_Y:
		newPos.y = MAX_Y
	elif newPos.y < MIN_Y:
		newPos.y = MIN_Y
	return newPos
	
func setPositionFromScreen(position):
	var newPos = self.thresholdPosition(references["mapRoot"].get_viewport_transform().affine_inverse().xform(position))
	self.set_pos(newPos)

func setMaxPos(mapSize,groundSize):
	MAX_X = (mapSize.x * groundSize.x)/2
	MAX_Y = mapSize.y * groundSize.y
	MIN_X = -(mapSize.x * groundSize.x)/2
	MIN_Y = -(10 * groundSize.y)/2
	
func setCameraCanMove(state):
	currents["CAMERA_CAN_MOVE"] = state

func setCameraSliding(state):
	currents["CAMERA_SLIDING"] = state

func isCameraSliding():
	return currents["CAMERA_SLIDING"]

func isCameraCanMove():
	return currents["CAMERA_CAN_MOVE"]
