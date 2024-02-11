extends CharacterBody2D

enum PlayerMoveStates {IDLE = 1, WALKING, DASHING, AIR}
enum PlayerFaceStates {RIGHT = 1, LEFT = -1}
var currentMoveState

const SPEED = 400.0
const JUMP_VELOCITY = -500.0
const dashSpeed = 1300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var canDash = true
var facingDirection = PlayerFaceStates.RIGHT

func _ready():
	currentMoveState = PlayerMoveStates.IDLE


func _physics_process(delta):
	
	print(currentMoveState)
	match currentMoveState:
		PlayerMoveStates.IDLE:
			if !is_on_floor():
				currentMoveState = PlayerMoveStates.AIR
				return
			
			canDash = true
			

			checkJump()
			checkDash()
			checkLateralMove()

		PlayerMoveStates.WALKING:
			if !is_on_floor():
				currentMoveState = PlayerMoveStates.AIR
				return
			
			if is_zero_approx(velocity.x):
				currentMoveState = PlayerMoveStates.IDLE
				return
			
			checkJump()
			checkDash()
			checkLateralMove()
			
			
			
		PlayerMoveStates.DASHING:
			
			velocity.x = dashSpeed * facingDirection
			velocity.y = 0
			if is_on_floor():
				checkJump()
		
		PlayerMoveStates.AIR:
			if is_on_floor():
				currentMoveState = PlayerMoveStates.IDLE
				return
				
				
			checkDash()
			checkLateralMove()
			
			
			if velocity.y < 0:
				velocity.y += gravity * delta
			else:
				velocity.y += 2 * gravity * delta
			
	move_and_slide()

func checkJump():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += JUMP_VELOCITY
		currentMoveState = PlayerMoveStates.AIR


func checkLateralMove():
	

	
	var direction = Input.get_axis("left", "right")
	if direction > 0:
		facingDirection = PlayerFaceStates.RIGHT
		
	elif direction < 0:
		facingDirection = PlayerFaceStates.LEFT
	
	if direction:
		velocity.x = direction * SPEED
		if is_on_floor():
			currentMoveState = PlayerMoveStates.WALKING
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)


func checkDash():
	if Input.is_action_just_pressed("dash") and canDash:
		canDash = false
		get_tree().create_timer(0.15).timeout.connect(finishDash)
		currentMoveState = PlayerMoveStates.DASHING

func finishDash():
	currentMoveState = PlayerMoveStates.IDLE
