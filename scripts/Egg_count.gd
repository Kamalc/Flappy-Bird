extends Label

func _ready():
	pass
func _process(delta):
	set_text(str(game.count_egg))
