extends Node

const group_obs ="obstacles"
const group_ground ="ground"
const group_bird="bird"
var current_score =0 setget _set_current_score
var best_score =0 setget _set_best_score
signal current_score_changed
signal best_score_changed
var sound_on =true
var bird_sound_on =false
var count_egg=3
func _ready():
	pass
func _set_best_score(new_value):
	best_score=new_value
	emit_signal("best_score_changed")
	pass
func _set_current_score(new_value):
	current_score=new_value
	emit_signal("current_score_changed")
	pass