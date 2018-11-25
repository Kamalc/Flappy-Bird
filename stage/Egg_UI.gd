extends TextureButton

func _ready():
	
	pass
func _process(delta):
	disabled=(game.count_egg==0)
	