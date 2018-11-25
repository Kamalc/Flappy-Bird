extends Area2D


func _ready():
	pass
func _on_body_entered(other_body):
	if other_body.is_in_group(game.group_bird):
		game.current_score+=1
		game.count_egg+=1
		get_node("point").play()
		get_node("Timer").start()
	pass


func _on_Timer_timeout():
	get_node("point").stop()
	pass
