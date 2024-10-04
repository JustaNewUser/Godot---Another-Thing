extends CharacterBody2D

var SPEED = 50
const JUMP_VELOCITY = -400.0
var player
var chase = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	get_node("AnimatedSprite2D").play("Idle")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if chase == true:
		get_node("AnimatedSprite2D").play("Move")
		if self.get_parent().get_parent().get_name() == "Level":
			player = self.get_parent().get_parent().get_parent().get_node("PlayerBody")
		else:
			player = $"../../PlayerBody"
		var direction = (player.position - self.position).normalized()
		if direction.x > 0:
			get_node("AnimatedSprite2D").flip_h = false
		else:
			get_node("AnimatedSprite2D").flip_h = true

		velocity.x = direction.x * SPEED
	else:
		get_node("AnimatedSprite2D").play("Idle")
		velocity.x = 0

	move_and_slide()


func _on_reach_body_entered(body):
	if body.name == "PlayerBody":
		chase = true





func _on_reach_body_exited(body):
	if body.name == "PlayerBody":
		chase = false



func _on_death_hitbox_body_entered(body):
	if body.name == "PlayerBody":
		chase = false
		self.queue_free()



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
		

