
var references = {
	"streamPlayer" : "",
	"samplePlayer" : "",
	"rootNode" : ""
}

func init(root):
	initReferences(root)

func initReferences(root):
	references["rootNode"] = root
	references["streamPlayer"] = root.get_node("StreamPlayer")
	references["samplePlayer"] = root.get_node("SamplePlayer")
	
func playMusic(path):
	self.stopMusic()
	var stream = load(path)
	references["streamPlayer"].set_stream(stream)
	references["streamPlayer"].set_loop(true)
	references["streamPlayer"].play()

func stopMusic():
	references["streamPlayer"].stop()

func muteMusic(mute):
	if mute:
		references["streamPlayer"].set_volume(0)
	else:
		references["streamPlayer"].set_volume(1)
		
func playSFX(title, unique):
	if(references["rootNode"].getSettings("SOUND_ENABLED")):
		references["samplePlayer"].play(title, unique)