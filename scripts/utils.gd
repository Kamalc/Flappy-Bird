extends Node

func _ready():
	
	pass
func get_main_node():
	return get_tree().get_root().get_child(get_tree().get_root().get_child_count()-1)
	pass