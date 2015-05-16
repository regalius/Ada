var references={
	"player": "",
	"camera":"",
	"animation":"",
	"mapRoot":"",
	"map":"",
	"rootNode":""
}

func init(root):
	self.initReferences(root)
	references["rootNode"].set_process_input(true)
	pass
	
func initReferences(root):
	references["rootNode"] = root
	references["mapRoot"] = root.get_node("world_root/map_root")
	references["map"] = references["mapRoot"].get_node("ground")
	references["player"] = references["mapRoot"].get_node("object/Player")
	references["camera"] = references["player"].get_node("camera")
	references["animation"] = references["player"].get_node("animation")
	pass

func _input(ev):
	if(ev.type == InputEvent.MOUSE_BUTTON):
		if ev.button_index == 1:
			var transform = references["rootNode"].get_viewport_transform().affine_inverse().xform(ev.pos)
			var clickTile = references["map"].world_to_map(transform)
			var worldCoordinate = references["map"].map_to_world( clickTile, false )
			references["player"].moveTo({x=clickTile.x,y=clickTile.y,z=0,direction="front"})
			print(str(clickTile.x)+" " + str(clickTile.y))
		elif ev.button_index == 4:
			references["mapRoot"].zoom("in")
		elif ev.button_index == 5:
			references["mapRoot"].zoom("out")