extends AudioStreamPlayer2D
onready var bird = utils.get_main_node().get_node("bird")
func _ready():
	play()
	_physics_process(true)
	pass

func _physics_process(delta):
	set_position(Vector2(bird.get_position().x +500,get_position().y))
	if(game.sound_on==false):
		stop()
	elif is_playing()==false :play()
	pass
func get_total_pos():
	return get_position()+get_offset()

