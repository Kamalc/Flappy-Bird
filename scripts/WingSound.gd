extends CheckBox

func _ready():
	pressed=game.bird_sound_on
	pass

func _process(delta):
	game.bird_sound_on =is_pressed()
	pass
