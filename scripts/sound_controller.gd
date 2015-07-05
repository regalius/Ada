
var curSample= {}

var musicReferences= {
						"mainMenuMusic" : "res://assets/music/mainmenu.ogg",
						"ingameMusic" : "res://assets/music/ingame.ogg"
					}

var references = {
	"streamPlayer" : "",
	"samplePlayer" : "",
	"rootNode" : ""
}
var currents ={
	"music":""
}

func init(root):
	initReferences(root)

func initReferences(root):
	references["rootNode"] = root
	references["streamPlayer"] = root.get_node("StreamPlayer")
	references["samplePlayer"] = root.get_node("SamplePlayer")
	
func playMusic(title):
	if title != currents["music"]:
		self.stopMusic()
		var stream = load(musicReferences[title])
		print(title)
		references["streamPlayer"].set_stream(stream)
		references["streamPlayer"].set_loop(true)
		references["streamPlayer"].play()
		currents["music"] = title
	
func stopMusic():
	references["streamPlayer"].stop()

func muteMusic(mute):
	if mute:
		references["streamPlayer"].set_volume(0)
	else:
		references["streamPlayer"].set_volume(1)
		
func playSFX(title, unique):
	if references["rootNode"].getSettings("SOUND_ENABLED") == "On":
		self.stopSFX(title)
		curSample[title] = 0
		curSample[title] = references["samplePlayer"].play(title, unique)

func stopSFX(title):
	if curSample.has(title):
		references["samplePlayer"].stop(curSample[title])
	pass