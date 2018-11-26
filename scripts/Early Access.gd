extends Label

func _ready():
	set_text("Kamal.Saad")
	get_node("Timer").start()
	pass

func _on_Timer_timeout():
	if get_text()=="Kamal.Saad":
		set_text("Early Access")
	else :set_text("Kamal.Saad")
	pass 

