extends CharacterBody2D

var hitpoints = 3
const SPEED = 300.0
const JUMP_VELOCITY = -500.0
var move = 1
var damage = 1
var knockback = 150.0
var knockbacked = 0
var dir = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = get_node("PlayerSprite/AnimationPlayer")

func _physics_process(delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction == -1:
		dir = 1
	elif direction == 1:
		dir = -1
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if knockbacked == 1:
		if not is_on_floor():
			velocity.y += gravity * delta
		
		

	if move == 1 and knockbacked == 0:
		# Handle Jump.
		if Input.is_action_pressed("ui_jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func _process(delta):
	if knockbacked == 1:
		anim.play("hurt")
		await get_tree().create_timer(0.2).timeout
		if is_on_floor():
			anim.play("recover")
			velocity.x = 0
			knockbacked = 0
			await get_tree().create_timer(0.5).timeout
			anim.play("recover")
			damage = 1
			move = 1
		
	if move == 1 and knockbacked == 0:
		if Input.is_action_pressed("ui_jump"):
			anim.play("jump")


			# Get the input direction and handle the movement/deceleration.
			# As good practice, you should replace UI actions with custom gameplay actions.
		var direction = Input.get_axis("ui_left", "ui_right")
		
		if direction == -1:
			get_node("PlayerSprite").flip_h = true
		elif direction == 1:
			get_node("PlayerSprite").flip_h = false
		if direction:
			if velocity.y == 0:
				anim.play("walk")
					
		else:
			if velocity.y == 0:
				anim.play("idle")
		if velocity.y > 0:
			anim.play("fall")





func _on_damage_body_entered(body):
	if body.is_in_group("Enemies"):
		velocity.y = JUMP_VELOCITY
		velocity.x = (knockback * dir)
		damage = 0
		move = 0
		knockbacked = 1

