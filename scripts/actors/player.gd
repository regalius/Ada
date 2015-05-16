
extends KinematicBody2D

const MOTION_SPEED=160
const OFFSET_X = 0
const OFFSET_Y = 0

var references={
	"map":"",
	"mapRoot":""
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
	"motion": Vector2(),
	"ACTION_STATE":"idle",
}


func _ready():
	# Initialization here
#	self.set_fixed_process(true)
	pass

func _fixed_process(delta):
	handleMovement(delta)
		
func init(mapRoot, position):
	self.initReferences(mapRoot)
	self.setPosition(position)
	pass

func initReferences(mapRoot):
	references["mapRoot"] = mapRoot
	references["map"] = mapRoot.get_node("ground")
	
func moveTo(position):
	if references["map"].get_cell(position.x,position.y) == references["mapRoot"].PATH_TILE_INDEX and not currents["ACTION_STATE"] == "moveTo":
		currents["newpos"].x= position.x
		currents["newpos"].y= position.y
		currents["newpos"].z= position.z
		currents["newpos"].direction= position.direction
		currents["newpos"]["worldPosition"]= self.getWorldPosition(Vector2(position.x,position.y))
		currents["ACTION_STATE"] = "moveTo"
	pass

func changeDirection(newpos):
	if currents["newpos"].direction != currents["position"].direction:
		currents["position"].direction == currents["newpos"].direction

func deliverItem():
	if references["mapRoot"].getAdjacentTile(currents["position"],"") == references["mapRoot"].HOUSE_TILE_INDEX:
		return true
	else:
		return false
	
func doAction(action, position):
	if action=="moveTo":
		self.moveTo(position)
	elif action=="deliverItem":
		self.deliverItem()
	elif action=="changeDirection":
		self.changeDirection(position)
	pass

func handleMovement(delta):
	if currents["ACTION_STATE"] == "moveTo":
		if not self.inRange(currents["position"]["worldPosition"], currents["newpos"]["worldPosition"], 5):
			if currents["newpos"].x < currents["position"].x: 
				# move_front
				currents["motion"]+=Vector2(-2,-1)
#				print("move_front")
			elif currents["newpos"].x > currents["position"].x:
				# move_back
				currents["motion"]+=Vector2(2,1)
#				print("move_back")
			elif currents["newpos"].y < currents["position"].y:
				#move_right
				currents["motion"]+=Vector2(1,-.5)
#				print("move_right")
			elif  currents["newpos"].y > currents["position"].y: 
				#move_left	
				currents["motion"]+=Vector2(-1,.5)
#				print("move_left")
				
			currents["position"]["worldPosition"] = Vector2(floor(self.get_pos().x),floor(self.get_pos().y))	
			currents["motion"] = currents["motion"].normalized() * MOTION_SPEED * delta
			currents["motion"] = move(currents["motion"])
			
		else :
			currents["ACTION_STATE"] = "idle"
#			print(str(currents["position"])+ " " + str(currents["newpos"]))
			currents["position"].x = currents["newpos"].x
			currents["position"].y = currents["newpos"].y
			currents["position"].z = currents["newpos"].z
			currents["position"].direction = currents["newpos"].direction
	
func inRange(point1, point2, deviation):
	if point2.x-deviation <= point1.x and point1.x <= point2.x+deviation and point2.y-deviation <= point1.y and point1.y <= point2.y+deviation :
		return true
	else:
		return false

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