extends TextureButton
var bird
func _ready():
	bird=utils.get_main_node().get_node("bird")
	pass
func _on_pressed():
	if bird:
		bird.set_state(bird.state_flapping)
	get_parent().get_node("texture_button").hide()

func _on_flap_pressed():
	if bird.get_state()==0:
		_on_pressed()
	elif bird.get_state()!=1:
#		print(bird.get_position().x)
		game.current_score=0
		bird.get_tree().reload_current_scene()
