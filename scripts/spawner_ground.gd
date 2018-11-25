extends Node2D
const scn_ground = preload("res://scenes/ground.tscn")
var bird
const ground_width =1024
const amount_to_fill_view =2
func _ready():
	bird =utils.get_main_node().get_node("bird")
	for i in range(amount_to_fill_view):
		spawn_and_move()
	pass
func spawn_and_move():
	spawn_ground()
	go_next_pos()

func spawn_ground():
	var new_ground =scn_ground.instance()
	new_ground.set_position(get_position())
	new_ground.connect("tree_exited",self,"spawn_and_move")
	get_node("container").call_deferred("add_child", new_ground)
	pass

func go_next_pos():
	set_position(get_position()+Vector2(ground_width,0))
	pass
