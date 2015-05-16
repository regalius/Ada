var references = {
	"player": "",
	"camera":"",
	"animation":"",
	"mapRoot":"",
	"map":"",
	"rootNode":""
}

#const ACTION_WAIT_TIME =50

var currents = {
	"playerActionQueue":[
		{"action":"moveTo", "position":{"x":1,"y":2, "z":0, "direction":"back"}},
		{"action":"moveTo", "position":{"x":2,"y":2, "z":0, "direction":"back"}},
		{"action":"moveTo", "position":{"x":3,"y":2, "z":0, "direction":"back"}},
		{"action":"moveTo", "position":{"x":4,"y":2, "z":0, "direction":"back"}},
		{"action":"moveTo", "position":{"x":3,"y":2, "z":0, "direction":"back"}}
	],
#	"waitTime":50
}

func init(root):
	self.initReferences(root)
	references["rootNode"].set_fixed_process(true)
	self.insertPlayerAction("haha",{"x":3,"y":2, "z":0, "direction":"back"}, 2)
	print(currents["playerActionQueue"])
	pass
	
func initReferences(root):
	references["rootNode"] = root
	references["mapRoot"] = root.get_node("world_root/map_root")
	references["map"] = references["mapRoot"].get_node("ground")
	references["player"] = references["mapRoot"].get_node("object/Player")
	references["camera"] = references["player"].get_node("camera")
	references["animation"] = references["player"].get_node("animation")
	pass

func startGame():
	references["animation"].play("camera_start")

func insertPlayerAction(action,position, index):
	for i in range(currents["playerActionQueue"].size()-1, index):
		if i == currents["playerActionQueue"].size() -1:
			currents["playerActionQueue"].append(currents["playerActionQueue"][i])
		else:		
			currents["playerActionQueue"][i+1] = currents["playerActionQueue"][i]
	
	currents["playerActionQueue"].insert(index, {"action":action, "position":position})

func handlePlayerActionQueue(delta):
	if  not currents["playerActionQueue"].empty() && references["player"].getCurrentActionState() == "idle":
		references["player"].doAction(currents["playerActionQueue"][0].action,currents["playerActionQueue"][0].position)
		currents["playerActionQueue"].remove(0)
		currents["waitTime"] = 0
		
func _fixed_process(delta):
#	if currents["waitTime"] < ACTION_WAIT_TIME:
#		currents["waitTime"]+=1
#	else:
	self.handlePlayerActionQueue(delta)
	references["player"]._fixed_process(delta)
#	references["map"]._fixed_process(delta)
	