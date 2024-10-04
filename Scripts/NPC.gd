extends Sprite2D

@onready var interactive_area = $InteractiveArea

func _ready():
	interactive_area.interact_action = Callable(self, "_test_interact")
	
	

func _test_interact():
	print("TEST")
