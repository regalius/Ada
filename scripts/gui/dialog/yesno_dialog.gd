
extends "../../abstract_dialog.gd"

var dialogType = {
	"quit":{
		"titleLbl":TranslationServer.tr("QUIT_DIALOG_TITLE"),
		"textLbl":TranslationServer.tr("QUIT_DIALOG_LBL"),
		"accept":"quitGame",
		"refuse": "closeDialog"
	},
	"levelMenu":{
		"titleLbl":TranslationServer.tr("LEVEL_DIALOG_TITLE"),
		"textLbl":TranslationServer.tr("LEVEL_DIALOG_LBL"),
		"accept":"quitLevel",
		"refuse": "closeDialog"
	},
	"loadMap":{
		"titleLbl":TranslationServer.tr("LOAD_MAP_DIALOG_TITLE"),
		"textLbl":TranslationServer.tr("LOAD_MAP_DIALOG_LBL"),
		"accept":"loadMap",
		"refuse": "closeDialog"
	},
	"saveMap":{
		"titleLbl":TranslationServer.tr("SAVE_MAP_DIALOG_TITLE"),
		"textLbl":TranslationServer.tr("SAVE_MAP_DIALOG_LBL"),
		"accept":"saveMap",
		"refuse": "closeDialog"
	},
	"playMap":{
		"titleLbl":TranslationServer.tr("SAVE_MAP_DIALOG_TITLE"),
		"textLbl":TranslationServer.tr("SAVE_MAP_DIALOG_LBL"),
		"accept":"playMap",
		"refuse": "confirmPlayWithoutSave"
	},
	"playWithoutSave":{
		"titleLbl":TranslationServer.tr("PLAY_WITHOUT_SAVE_DIALOG_TITLE"),
		"textLbl":TranslationServer.tr("PLAY_WITHOUT_SAVE_DIALOG_TITLE"),
		"accept":"playWithoutSave",
		"refuse": "closeDialog"
	},
	"previewMode":{
		"titleLbl":TranslationServer.tr("PREVIEW_DIALOG_TITLE"),
		"textLbl":TranslationServer.tr("PREVIEW_DIALOG_LBL"),
		"accept":"quitPreviewMode",
		"refuse": "closeDialog"
	},
	"editorMode":{
		"titleLbl":TranslationServer.tr("EDITOR_DIALOG_TITLE"),
		"textLbl":TranslationServer.tr("EDITOR_DIALOG_LBL"),
		"accept":"quitEditorMode",
		"refuse": "closeDialog"
	},
	"restart":{
		"titleLbl":TranslationServer.tr("RESTART_DIALOG_TITLE"),
		"textLbl":TranslationServer.tr("RESTART_DIALOG_LBL"),
		"accept":"restartGame",
		"refuse": "closeDialog"
	}
}

func init():
	.init()
	self.initCurrents()

func initReferences():
	.initReferences()
	references["yesBtn"] = self.get_node("dialogbtn_container/dialog_btn/yes_btn")
	references["noBtn"] = self.get_node("dialogbtn_container/dialog_btn/no_btn")
	references["textLbl"] = self.get_node("dialog_lbl")
	references["titleLbl"] = self.get_node("dialog_title")
	
func initCurrents():
	currents={
		"dialogType":""
	}
	
func enterDialog(sender, parameter):
	.enterDialog(sender,parameter)
	self.setDialogType(parameter[0])

func setDialogType(type):
	if type != currents["dialogType"]:
		currents["dialogType"] = type
		references["textLbl"].set_text(dialogType[type].textLbl)
		references["titleLbl"].set_text(dialogType[type].titleLbl)
		references["yesBtn"].disconnect("pressed", self, "doAction")
		references["yesBtn"].connect("pressed", self, "doAction",[dialogType[type].accept])
		
		references["noBtn"].disconnect("pressed", self, "doAction")
		references["noBtn"].connect("pressed", self, "doAction",[dialogType[type].refuse])

func doAction(action):
	references["guiRoot"].showDialog(false,"","yesno","")
	if action == "quitLevel":
		references["rootNode"].quitLevel("")
	elif action == "quitGame":
		references["rootNode"].quitGame()
	elif action == "restartGame":
		references["rootNode"].restartGame()
	elif action == "quitPreviewMode":
		references["rootNode"].quitPreviewMode()
	elif action == "quitEditorMode":
		references["rootNode"].quitEditor()
	elif action == "loadMap":
		currents["sender"].loadMap(true,"")
	elif action == "saveMap":
		currents["sender"].saveMap(true,"")
	elif action == "playMap":
		currents["sender"].playMap(true,"")
	elif action == "confirmPlayWithoutSave":
		currents["sender"].playWithoutSave(false)
	elif action == "playWithoutSave":
		currents["sender"].playWithoutSave(true)
	