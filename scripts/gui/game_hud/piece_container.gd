
extends Control

export var containerTitle = ""
export var containerLink = ""

var references = {
	"pieceContainer":"",
	"titleLbl":"",
	"pieceContainerScroll":"",
	"gameUIRoot":"",
	"rootNode":"",
}

var actionArray = ["","","","","","","","","",""]

func _ready():
	# Initialization here
	self.init("","")
	pass


func init(title, link):
	self.initReferences()
	self.reset()
	if containerTitle =="":
		self.setTitle(title)
	else :
		self.setTitle(containerTitle)

	if containerLink =="":
		self.setLink(link)
	else :
		self.setLink(containerLink)

func initReferences():
	references["pieceContainer"] = self.get_node("container_root/container")
	references["titleLbl"] = self.get_node("label_root/title_lbl")
	references["rootNode"] = self.get_node("/root").get_child(self.get_node("/root").get_child_count()-1)
	references["gameUIRoot"] = references["rootNode"].get_node("gui_layer/canvas_item/gui_root/gui_container/gameui_root")
#	references["pieceContainerScroll"] = references["gameUIRoot"].get_node("right/piececontainer_scroll")
	
func reset():
	for piece in references["pieceContainer"].get_children():
		piece.setAction("")
		
	actionArray=["","","","","","","","","",""]

func setTitle(title):
	containerTitle = title
	references["titleLbl"].set_text(title)
	
func setLink(link):
	containerLink = link
	self.set_name(link)

func setActionArray(value, index):
	actionArray[index] = value
	
func getTitle():
	return containerTitle

func getLink():
	return containerLink
	
func getActionArray():
	return actionArray

func getPieceContainer():
	return references["pieceContainer"]

#func _input_event(event):
#	references["pieceContainerScroll"]._input_event(event)