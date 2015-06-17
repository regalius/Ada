var references={}
var currents={}

func init(root):
	self.initReferences(root)
	self.initCurrents()
	references["mapRoot"].set_process_input(true)	
	pass

func end(root):
	references["mapRoot"].set_process_input(false)
	pass	
	
func initReferences(root):
	references["rootNode"] = root
	references["mapRoot"] = root.get_node("world_root/map_root")
	references["map"] = references["mapRoot"].get_node("ground")
	references["player"] = references["mapRoot"].get_node("object/Player")
	references["camera"] = references["mapRoot"].currents["camera"]
	references["cursor"] = root.get_node("gui_layer/canvas_item/Cursor")
	references["selector"] = references["mapRoot"].references["selector"]
	references["animation"] = references["player"].get_node("animation")
	pass

func initCurrents():
	currents["MAP_DRAG"]=false
	currents["MOUSE_DRAG"]=false
	currents["CAMERA_SLIDING"]=false
	currents["slideVector"]=Vector2()
	currents["MAP_PROCESS_INPUT"]=true
	currents["GUI_PROCESS_INPUT"]=false

func handleMapInput(ev):
	if ev.type == InputEvent.MOUSE_BUTTON:
		if ev.button_index == 1:
			
			if references["mapRoot"].isEditorMode():
				references["selector"].setPosition(ev.pos)
				if not ev.pressed and not currents["MAP_DRAG"]:
					references["rootNode"].references["editorController"].handleBrushAction(ev.pos)

			if not ev.pressed and currents["MAP_DRAG"]:
				currents["MAP_DRAG"] = false
				references["camera"].slide()
				
			currents["MOUSE_DRAG"] = ev.pressed
			
		elif ev.button_index == 4:
			references["camera"].zoom("in")
			
		elif ev.button_index == 5:
			references["camera"].zoom("out")
			
	elif ev.type == InputEvent.MOUSE_MOTION:
#		print("x "+ str(ev.relative_x)+ " y "+ str(ev.relative_y))
		if references["mapRoot"].isEditorMode():
			references["selector"].setPosition(ev.pos)
		if currents["MAP_DRAG"] and currents["MOUSE_DRAG"]:
			references["camera"].move(Vector2(ev.relative_x,ev.relative_y),true)
		elif currents["MOUSE_DRAG"] and (abs(ev.relative_x) > 2 or abs(ev.relative_y) > 2) :
			currents["MAP_DRAG"]=true

func _input(ev, node, nodeName):
	if ev.type == InputEvent.MOUSE_BUTTON and not ev.pressed:
		references["cursor"].show()
	
#	currents["MAP_PROCESS_INPUT"] = true
#	if ev.type == InputEvent.MOUSE_BUTTON and nodeName != "map":
#		if ev.type == InputEvent.MOUSE_BUTTON:
#			if ev.button_index == 1:
#				if ev.pressed:
#					currents["MAP_PROCESS_INPUT"] = false
#					currents["GUI_PROCESS_INPUT"] = true
#					currents["MAP_DRAG"] = false
#					currents["MOUSE_DRAG"] = false
#				else:
#					currents["MAP_PROCESS_INPUT"] = true
#					currents["GUI_PROCESS_INPUT"] = false
#			elif ev.button_index == 4 or ev.button_index == 5:
#				currents["MAP_PROCESS_INPUT"] = false

	if nodeName == "gui":
		if ev.type == InputEvent.MOUSE_BUTTON:
			if ev.button_index == 1:
				if ev.pressed:
					currents["MAP_PROCESS_INPUT"] = false
					currents["GUI_PROCESS_INPUT"] = true
					currents["MAP_DRAG"] = false
					currents["MOUSE_DRAG"] = false
				else:
					currents["MAP_PROCESS_INPUT"] = true
					currents["GUI_PROCESS_INPUT"] = false
			elif ev.button_index == 4 or ev.button_index == 5:
				currents["MAP_PROCESS_INPUT"] = false
	

#	references["map"].set_process_input(currents["MAP_PROCESS_INPUT"])
#	print("type : "+ str(nodeName) + " MAP_PROCESS_INPUT : " + str(currents["MAP_PROCESS_INPUT"]) + " GUI_PROCESS_INPUT : " + str(currents["GUI_PROCESS_INPUT"]) + " MOUSE_DRAG: "+ str(currents["MOUSE_DRAG"]) + " | MAP_DRAG : "+ str(currents["MAP_DRAG"]))
	
	if currents["MAP_PROCESS_INPUT"] and not currents["GUI_PROCESS_INPUT"] and nodeName == "map":
		self.handleMapInput(ev)

	if nodeName == "map":
		if ev.type == InputEvent.MOUSE_BUTTON:
			if ev.button_index == 1:
				if not ev.pressed:
					currents["MAP_PROCESS_INPUT"] = true
					currents["GUI_PROCESS_INPUT"] = false
	