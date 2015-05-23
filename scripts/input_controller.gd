var references={
	"player": "",
	"camera":"",
	"animation":"",
	"mapRoot":"",
	"map":"",
	"cursor":"",
	"rootNode":""
}
var currents={
	"MAP_DRAG":false,
	"CAMERA_SLIDING":false,
	"slideVector":Vector2(),
	"MAP_PROCESS_INPUT":false,
	"GUI_PROCESS_INPUT":false
}

func init(root):
	self.initReferences(root)
	self.initCurrents()
#	references["rootNode"].set_process_input(true)
	references["mapRoot"].set_process_input(true)	
	pass

func end(root):
#	references["rootNode"].set_process_input(false)
	references["mapRoot"].set_process_input(false)
	
func initReferences(root):
	references["rootNode"] = root
	references["mapRoot"] = root.get_node("world_root/map_root")
	references["map"] = references["mapRoot"].get_node("ground")
	references["player"] = references["mapRoot"].get_node("object/Player")
	references["camera"] = references["player"].get_node("camera")
	references["cursor"] = root.get_node("gui_layer/canvas_item/Cursor")
	references["animation"] = references["player"].get_node("animation")
	pass

func initCurrents():
	currents={
		"MAP_DRAG":false,
		"CAMERA_SLIDING":false,
		"slideVector":Vector2(),
		"MAP_PROCESS_INPUT":true,
		"GUI_PROCESS_INPUT":true
	}


func _input(ev, node, nodeName):
#	print("nodeName : "+ str(nodeName)+" MAP_PROCESS_INPUT : " + str(currents["MAP_PROCESS_INPUT"]) + " | MAP_DRAG : "+ str(currents["MAP_DRAG"]))
	if ev.type == InputEvent.MOUSE_BUTTON and not ev.pressed:
		references["cursor"].show()
	
	currents["MAP_PROCESS_INPUT"] = true
	if ev.type == InputEvent.MOUSE_BUTTON and nodeName != "map":
		if ev.type == InputEvent.MOUSE_BUTTON:
			if ev.button_index == 1:
				if ev.pressed:
					currents["MAP_PROCESS_INPUT"] = false
					currents["MAP_DRAG"] = false
#					print(nodeName + " | ev type: " + str(ev.type) +" | pressed: "+ str(ev.pressed) + " | mouse drag: "+ str(currents["MAP_DRAG"]) + " | map process: "+ str(currents["MAP_PROCESS_INPUT"]))
				else:
					currents["MAP_PROCESS_INPUT"] = true
			elif ev.button_index == 4 or ev.button_index == 5:
				currents["MAP_PROCESS_INPUT"] = false

#			references["map"].set_process_input(currents["MAP_PROCESS_INPUT"])
	
	if currents["MAP_PROCESS_INPUT"] and nodeName == "map":
		if ev.type == InputEvent.MOUSE_BUTTON:
			if ev.button_index == 1:
				if not ev.pressed and currents["MAP_DRAG"]:
					references["player"].slideCamera()
				currents["MAP_DRAG"] = ev.pressed
			elif ev.button_index == 4:
				references["player"].zoomCamera("in")
			elif ev.button_index == 5:
				references["player"].zoomCamera("out")
		elif ev.type == InputEvent.MOUSE_MOTION and currents["MAP_DRAG"]:
			references["player"].moveCamera(Vector2(ev.relative_x,ev.relative_y))
	
	if nodeName=="pieceContainerScroll":	
		node.get_node("_v_scroll")._input_event(ev)
	