extends Node
const scn_ground = preload("res://scenes/obstacles.tscn")
const obstacles_width =50
const offset_y=250
const offset_x=250
const ground_height =300
const amount_to_fill_view =4
func _ready():
	pass
func _on_bird_state_changed(bird):
#	print(bird.get_state())
	if bird.get_state()==bird.state_flapping:
		start()
	pass
func start():
	go_init_pos()
	for i in range(amount_to_fill_view):
		spawn_and_move()
	pass
func spawn_and_move():
	spawn_obstacles()
	go_nxt_pos()
func spawn_obstacles():
	var new_ground =scn_ground.instance()
	new_ground.set_position(get_position())
	new_ground.connect("tree_exited",self,"spawn_and_move")
	get_node("container").call_deferred("add_child", new_ground)
	pass

func go_init_pos():
	randomize()
	var init_pos =Vector2()
	init_pos.x=get_viewport().size.x + obstacles_width/2
	init_pos.y=rand_range(65,225)
	var camera =utils.get_main_node().get_node("camera")
	if camera:
		init_pos.x+=camera.get_total_pos().x
	set_position(init_pos)
	
func go_nxt_pos():
	randomize()
	var nxt_pos =get_position()
	nxt_pos.x+=offset_x + obstacles_width
	nxt_pos.y=rand_range(65,225)
	set_position(nxt_pos)
	