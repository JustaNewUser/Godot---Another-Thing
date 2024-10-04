extends Node2D


var Enemy1 = preload("res://Scenes/slime.tscn")


func _on_spawn_timer_timeout():
	var CherryTemp = Enemy1.instantiate()
	var rng = RandomNumberGenerator.new()
	var ranint = rng.randi_range(0, 1000)
	CherryTemp.position = Vector2(ranint, 0)
	add_child(CherryTemp)
