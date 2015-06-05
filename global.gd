extends Node

var currentScene

func _ready():
   currentScene = get_tree().get_root().get_child(get_tree().get_root().get_child_count() -1)

# create a function to switch between scenes 
func restartGame():
	#clean up the current scene
	currentScene.queue_free()
	#load the file passed in as the param "scene"
	var s = ResourceLoader.load("res://main.scn")
	#create an instance of our scene
	currentScene = s.instance()
	# add scene to root
	get_tree().get_root().add_child(currentScene)
