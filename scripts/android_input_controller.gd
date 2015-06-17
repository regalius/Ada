
#const MAX_ZOOM = 1
#const MIN_ZOOM = 10
#const ZOOM_SPEED = .1

var cam_zoom = 10
var min_cam_zoom = 1
var max_cam_zoom = 10

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
	
#	references["asd"] = root.get_node("gui_layer/canvas_item/gui_root/gameui_root/top/Label")
#	references["asd2"] = root.get_node("gui_layer/canvas_item/gui_root/gameui_root/right/top_right/Label")
	
	pass

func initCurrents():
	currents["MAP_DRAG"]=false
	currents["MOTION_DRAG"]=false
	currents["ZOOM_DRAG"]=false
	currents["CAMERA_SLIDING"]=false
	currents["slideVector"]=Vector2()
	currents["MAP_PROCESS_INPUT"]=true
	currents["GUI_PROCESS_INPUT"]=false
	currents["ZOOM_TAP"] = true
	currents["NEW_ZOOM_DIST"] = 0.0
	currents["OLD_ZOOM_DIST"] = 0.0
	currents["ZOOM_DIRECTION"] = 0.0
	currents["TOUCHPOS1"] = Vector2(0,0)
	currents["TOUCHPOS2"] = Vector2(0,0)

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
				
			currents["MOTION_DRAG"] = ev.pressed

	if ev.type == InputEvent.SCREEN_DRAG:
		if ev.index == 0:
			currents["TOUCHPOS1"] = Vector2(ev.x,ev.y)
			currents["MOTION_DRAG"] = true
			currents["ZOOM_DRAG"] = false
		if ev.index == 1:
			currents["TOUCHPOS2"] = Vector2(ev.x,ev.y)
			currents["MOTION_DRAG"] = false
			currents["ZOOM_DRAG"] = true
			
		if currents["ZOOM_DRAG"]:
			if currents["ZOOM_TAP"] == true:
				currents["ZOOM_TAP"] = false
				currents["OLD_ZOOM_DIST"] = currents["TOUCHPOS1"].distance_to(currents["TOUCHPOS2"])
				references["camera"].setPositionFromScreen((currents["TOUCHPOS1"]+currents["TOUCHPOS2"])/2)
#				references["asd2"].set_text(str(references["mapRoot"].get_viewport_transform().affine_inverse().xform((currents["TOUCHPOS1"]+currents["TOUCHPOS2"])/2)))
			currents["NEW_ZOOM_DIST"] = currents["TOUCHPOS1"].distance_to(currents["TOUCHPOS2"])
			currents["ZOOM_DIRECTION"] = currents["OLD_ZOOM_DIST"] - currents["NEW_ZOOM_DIST"]
#			references["asd"].set_text("cz: " + str(cam_zoom) + " zm: "+ str(currents["ZOOM_DIRECTION"])+ " ozd: " + str(currents["OLD_ZOOM_DIST"])+ " nzd: "+ str(currents["NEW_ZOOM_DIST"])+"/n")
			if currents["ZOOM_DIRECTION"] > 0:
				references["camera"].zoom("out")
			if currents["ZOOM_DIRECTION"] < 0:
				references["camera"].zoom("in")
			currents["OLD_ZOOM_DIST"] = currents["TOUCHPOS1"].distance_to(currents["TOUCHPOS2"])
	elif ev.type == InputEvent.MOUSE_MOTION:
#		print("x "+ str(ev.relative_x)+ " y "+ str(ev.relative_y))
		if references["mapRoot"].isEditorMode():
			references["selector"].setPosition(ev.pos)
		if currents["MAP_DRAG"] and currents["MOTION_DRAG"]:
			references["camera"].move(Vector2(ev.relative_x,ev.relative_y),true)
		elif currents["MOTION_DRAG"] and (abs(ev.relative_x) > 1 or abs(ev.relative_y) > 1) :
			currents["MAP_DRAG"]=true
	else:
		currents["ZOOM_TAP"] = true
#	references["asd2"].set_text("MOTION: "+ str(currents["MOTION_DRAG"])+ " zoom: "+ str(currents["ZOOM_DRAG"]))

#	elif ev.type == InputEvent.MOTION_MOTION:
#		print("x "+ str(ev.relative_x)+ " y "+ str(ev.relative_y))
#		if references["mapRoot"].isEditorMode():
#			references["selector"].setPosition(ev.pos)
#		if currents["MAP_DRAG"] and currents["MOTION_DRAG"]:
#			references["camera"].move(Vector2(ev.relative_x,ev.relative_y))
#		elif currents["MOTION_DRAG"] and (abs(ev.relative_x) > 1 or abs(ev.relative_y) > 1) :
#			currents["MAP_DRAG"]=true

func _input(ev, node, nodeName):
	
#	currents["MAP_PROCESS_INPUT"] = true
#	if ev.type == InputEvent.MOTION_BUTTON and nodeName != "map":
#		if ev.type == InputEvent.MOTION_BUTTON:
#			if ev.button_index == 1:
#				if ev.pressed:
#					currents["MAP_PROCESS_INPUT"] = false
#					currents["GUI_PROCESS_INPUT"] = true
#					currents["MAP_DRAG"] = false
#					currents["MOTION_DRAG"] = false
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
					currents["MOTION_DRAG"] = false
				else:
					currents["MAP_PROCESS_INPUT"] = true
					currents["GUI_PROCESS_INPUT"] = false
			elif ev.button_index == 4 or ev.button_index == 5:
				currents["MAP_PROCESS_INPUT"] = false
	
#	references["map"].set_process_input(currents["MAP_PROCESS_INPUT"])
#	print("type : "+ str(nodeName) + " MAP_PROCESS_INPUT : " + str(currents["MAP_PROCESS_INPUT"]) + " GUI_PROCESS_INPUT : " + str(currents["GUI_PROCESS_INPUT"]) + " MOTION_DRAG: "+ str(currents["MOTION_DRAG"]) + " | MAP_DRAG : "+ str(currents["MAP_DRAG"]))
	
	if currents["MAP_PROCESS_INPUT"] and not currents["GUI_PROCESS_INPUT"] and nodeName == "map":
		self.handleMapInput(ev)

	if nodeName == "map":
		if ev.type == InputEvent.MOUSE_BUTTON:
			if ev.button_index == 1:
				if not ev.pressed:
					currents["MAP_PROCESS_INPUT"] = true
					currents["GUI_PROCESS_INPUT"] = false
	