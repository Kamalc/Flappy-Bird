extends RigidBody2D
var state = FlayingState.new(self)
const state_flaying=0
const state_flapping=1
const state_hit=2
const state_grounded=3
signal state_changed
var hud
var button 
const Egg = preload("res://scenes/Egg.tscn")
func _ready():
	get_node("anime").play("Flying")
	hud = utils.get_main_node().get_node("hud")
	add_to_group(game.group_bird)
	connect("body_entered",self,"_on_body_entered")
	pass
func _physics_process(delta):
	if(game.bird_sound_on==false):
		get_node("wing").stop()
		get_node("waak").stop()
		get_node("swooing").stop()
	elif (get_node("wing").is_playing()==false) and (get_state()==1):
		 get_node("wing").play()
		 get_node("swooing").play()
		 get_node("waak").play()
	state.update(delta)
func _on_body_entered(other_body):
	if state.has_method("_on_body_entered"):
		state._on_body_entered(other_body)
	pass

func _input(event):
	state.input(event)

func set_state(new_state):
	state.exit()
	if new_state== state_flaying :
		 state = FlayingState.new(self)
	elif new_state== state_flapping:
		 state = FlappingState.new(self)
	elif new_state== state_hit:
		 state = HitState.new(self)
	elif new_state== state_grounded:
		 state = GroundState.new(self)
	emit_signal("state_changed",self)
	pass

func get_state():
	if state is FlayingState :
		return state_flaying
	elif state is HitState :
		return state_hit
	elif state is GroundState :
		return state_grounded
	elif state is FlappingState :
		return state_flapping
	pass
#-------------------------------------->
class FlayingState:
	var bird
	var prev_gravity
	func _init(bird):
		self.bird=bird
		prev_gravity=bird.get_gravity_scale()
		bird.set_gravity_scale(0)
		bird.set_linear_velocity(Vector2(200, bird.get_linear_velocity().y))
		pass
	func update(delta):
		pass
	func input(event):
		pass
	func exit():
		bird.set_gravity_scale(prev_gravity)
		pass

#-------------------------------------->
class HitState:
	var bird
	func _init(bird):
		self.bird=bird
		bird.set_linear_velocity(Vector2(0,0))
		var other_body = bird.get_colliding_bodies()[0]
		bird.add_collision_exception_with(other_body)
		bird.get_node("anime").play("Hit")
		bird.hud.get_node("texture_button").set_process_input(false)
		bird.get_node("Hit").play()
		bird.get_node("Timer_Hit").start()
		bird.hud.get_node("flap").hide()
		pass
	func update(delta):
		pass
	func input(event):
		pass
	func exit():
		pass
	func _on_body_entered(other_body):
		if other_body.is_in_group(game.group_ground):
			bird.set_state(bird.state_grounded)
		pass

#-------------------------------------->
class GroundState:
	var bird
	func _init(bird):
		self.bird=bird
		bird.set_linear_velocity(Vector2(0,0))
		bird .set_angular_velocity(0)
		bird.get_node("anime").play("Hit")
		bird.hud.get_node("texture_button").set_process_input(false)
		bird.get_node("Timer").start()
		bird.get_node("Hit").play()
		bird.get_node("Timer_Hit").start()
		bird.hud.get_node("flap").hide()
		pass
	func update(delta):
		pass
	func input(event):
		pass
	func exit():
		pass


#-------------------------------------->
class FlappingState:
	var bird
	func _init(bird):
		self.bird=bird
		bird.get_node("wing").play()
		bird.get_node("waak").play()
		flap()
		pass
	func update(delta):
		#print(bird.get_linear_velocity().x)
		pass
	func input(event):
		if event.is_action_pressed("flap"):
			flap()
		if event.is_action_pressed("Egg"):
			egged()
		pass
	func exit():
		bird.get_node("anime").stop()
		bird.get_node("wing").stop()
		bird.get_node("waak").stop()
		pass
	func flap():
		bird.get_node("anime").play("Flapping")
		bird.set_linear_velocity(Vector2(bird.get_linear_velocity().x, -200))
		bird.get_node("swooing").play()
		bird.get_node("Timer_swooing").start()
		
	func _on_body_entered(other_body):
		if other_body.is_in_group(game.group_obs):
			bird.set_state(bird.state_hit)
		elif other_body.is_in_group(game.group_ground):
			bird.set_state(bird.state_grounded)
		pass
	func egged():
		if game.count_egg > 0:
			var egg = Egg.instance()
			egg.set_position(Vector2(bird.get_position().x-25,bird.get_position().y+25))
			bird.get_parent().get_node("container").call_deferred("add_child", egg)
			game.count_egg-=1


func _on_Timer_timeout():
	hud.get_node("texture_button").show()
	hud.get_node("texture_button").set_process_input(true)
	hud.get_node("flap").show()
	pass


func _on_Timer_Hit_timeout():
	get_node("Hit").stop()
	pass # replace with function body


func _on_Timer_swooing_timeout():
	get_node("swooing").stop()
	pass # replace with function body
func _on_flap_pressed():
	if(get_state()==1):
		state.flap()
#		print("hi")
	pass


func _on_Egg_pressed():
	if(get_state()==1):
		state.egged()
	pass # replace with function body
