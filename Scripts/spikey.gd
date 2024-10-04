extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	get_node("AnimatedSprite2D").play("Blink")
	
func _physics_process(delta):


	move_and_slide()


func _on_player_kill_body_entered(body):
	if body.name == "PlayerBody":
		if body.hitpoints <= 1:
			body.queue_free()
			await get_tree().create_timer(3).timeout
			get_tree().paused = true
			if self.get_parent().get_parent().get_name() == "Level":
				self.get_parent().get_parent().get_parent().get_node("Game Over Screen").show()
			else:
				$"../../Game Over Screen".show()
		else: 
			body.hitpoints -= 1
		
