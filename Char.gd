extends KinematicBody2D
var velocity = Vector2.ZERO
var fast_fell = false
export(int) var JUMP_FORCE = -300
export(int) var JUMP_RELEASE_FORCE = -60
export(int) var MAX_SPEED = 100
export(int) var ACCELERATION = 10
export(int) var FRICTION = 30
export(int) var ADDITIONAL_FALL_GRAVITY = 40
export(int) var GRAVITY = 20

func _physics_process(_delta):
	apply_gravity()
	var input = Vector2.ZERO
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if input.x == 0:
		apply_friction()
	else:
		apply_acceleration(input.x)
	if is_on_floor():
		fast_fell = false
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = JUMP_FORCE
	else:
		if Input.is_action_just_released("ui_up") and velocity.y < JUMP_RELEASE_FORCE:
			velocity.y = JUMP_RELEASE_FORCE
		if velocity.y > 10 and not fast_fell:
			velocity.y += ADDITIONAL_FALL_GRAVITY
		fast_fell = true
	velocity = move_and_slide(velocity, Vector2.UP)

func apply_gravity():
		velocity.y += GRAVITY

func apply_friction():
	velocity.x = move_toward(velocity.x, 0, FRICTION )
	
func apply_acceleration(ammount):
	velocity.x = move_toward(velocity.x, MAX_SPEED*ammount, ACCELERATION)
	
