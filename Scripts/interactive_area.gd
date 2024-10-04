extends Area2D
class_name InteractionArea

@export var action := "Interact"

var interact_action: Callable = func():
	pass



func _on_body_entered(body):
	if body.is_in_group("player"):
		InteractionManager.add_area(self)



func _on_body_exited(body):
	if body.is_in_group("player"):
		InteractionManager.remove_area(self)
