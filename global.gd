#extends Node

#var currentScene

#func _ready():
#   currentScene = get_tree().get_root().get_child(get_tree().get_root().get_child_count() -1)

# create a function to switch between scenes 
#func restartGame():
	#clean up the current scene
#	currentScene.queue_free()
	#load the file passed in as the param "scene"
#	var s = ResourceLoader.load("res://main.scn")
	#create an instance of our scene
#	currentScene = s.instance()
	# add scene to root
#	get_tree().get_root().add_child(currentScene)


extends Node

var currentScene
var loader
var wait_frames
var time_max = 100 # msec

func _ready():
	currentScene = get_tree().get_root().get_child(get_tree().get_root().get_child_count() -1)
	
func startGame():
	self.goToScene("res://main.scn")

func restartGame():
	currentScene.queue_free()
	var s = ResourceLoader.load("res://preloader.scn")
	currentScene = s.instance()
	get_tree().get_root().add_child(currentScene)
	
func goToScene(path): 
	loader = ResourceLoader.load_interactive(path)
	if loader == null: 
		return
	set_process(true)
	wait_frames = 1 

func updateProgress():
	var progress = float(loader.get_stage()) / loader.get_stage_count()
	currentScene.updateProgress(progress)

func queueNewScene(scene_resource):
	currentScene.queueNewScene(scene_resource)

func setNewScene(scene_resource):
	currentScene.queue_free()
	currentScene = scene_resource.instance()
	get_node("/root").add_child(currentScene)

func _process(delta):
	if loader == null:
		set_process(false)
		return
		
	if wait_frames > 0:
		wait_frames -= 1
		return

	var t = OS.get_ticks_msec()
	while OS.get_ticks_msec() < t + time_max: 
		var err = loader.poll()
		if err == ERR_FILE_EOF: 
			var resource = loader.get_resource()
			loader = null
			queueNewScene(resource)
			break
		elif err == OK:
			updateProgress()
		else: 
			loader = null
			break