
extends Camera2D

const MAX_ZOOM = 1
const MIN_ZOOM = 10
const ZOOM_SPEED = .1
const SLIDE_SPEED = 2
const SLIDE_ACCELERATION = .05

var currents={}

func _ready():
	# Initialization here
	self.init()
	pass

func init():
	self.initCurrents()

func _fixed_process(delta):
	handleCameraSlide(delta)

func initCurrents():
	currents["CAMERA_SLIDING"]=false
	currents["CAMERA_CAN_MOVE"]=true
	currents["INITIAL_POSITION"]= Vector2(0,0)
	currents["zoomLevel"]=0
	currents["slideVector"]= Vector2()
	currents["slideSpeed"]=0
	pass
	
func handleCameraSlide(delta):
	if currents["CAMERA_SLIDING"]:
		var moveVector = Vector2()
		if currents["slideSpeed"] > 0 :
			moveVector = currents["slideVector"] * currents["slideSpeed"]
			self.set_pos(self.get_pos() - moveVector)
			currents["slideSpeed"]-=SLIDE_ACCELERATION
#			print("slideSpeed :"+str(currents["slideSpeed"])+" | moveVector : " + str(moveVector)+" | slideVector : "+ str(currents["slideVector"]))
		else:
			currents["CAMERA_SLIDING"] = false
	pass

func zoom(command):
	if currents["CAMERA_CAN_MOVE"]:
		currents["zoomLevel"] = self.get_zoom().x
		if command =="in" and currents["zoomLevel"] > MAX_ZOOM:
			currents["zoomLevel"] -= ZOOM_SPEED
			self.set_zoom(Vector2(currents["zoomLevel"],currents["zoomLevel"]))
			pass
		elif command =="out" and currents["zoomLevel"] < MIN_ZOOM:
			currents["zoomLevel"] += ZOOM_SPEED
			self.set_zoom(Vector2(currents["zoomLevel"],currents["zoomLevel"]))
			pass

func move(moveVector):
	if currents["CAMERA_CAN_MOVE"]:
		self.set_pos(references["camera"].get_pos() - moveVector)
		currents["slideVector"] = Vector2(moveVector.x, moveVector.y)

func slide():
	if currents["CAMERA_CAN_MOVE"]:
		currents["CAMERA_SLIDING"] = true
		currents["slideSpeed"] = SLIDE_SPEED

func reset():
	if currents["CAMERA_CAN_MOVE"]:
		self.set_pos(currents["INITIAL_POSITION"])

func setCameraCanMove(state):
	currents["CAMERA_CAN_MOVE"] = state

func setCameraSliding(state):
	currents["CAMERA_SLIDING"] = state

func isCameraSliding():
	return currents["CAMERA_SLIDING"]

func isCameraCanMove():
	return currents["CAMERA_CAN_MOVE"]
