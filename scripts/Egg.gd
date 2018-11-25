extends RigidBody2D
onready var camera = utils.get_main_node().get_node("camera")
var egg_types = ["white_egg", "green_egg"]
func _ready():
	var anime= egg_types[randi()%egg_types.size()]
	if(anime=="green_egg"):
		$AnimatedSprite.apply_scale (Vector2(1.40,1.40))
	$AnimatedSprite.animation = anime
	pass

func _process(delta):
	if get_position().x<camera.get_total_pos().x:
		queue_free()
	pass