extends CheckBox

func _ready():
	pressed=game.sound_on
	pass

func _process(delta):
	game.sound_on =is_pressed()
	
	pass
