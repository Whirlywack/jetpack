# Player.gd
# Basic player script for movement, energy, and state logic (scaffold)
extends CharacterBody2D

# Movement parameters
var speed := 200.0
var jump_force := -400.0
var gravity := 900.0

# Energy system (placeholder)
var max_energy := 100
var energy := 100

# State
enum PlayerState { IDLE, MOVING, JUMPING, FALLING }
var state := PlayerState.IDLE

func _ready():
    pass # TODO: Initialize player

func _physics_process(delta):
    # 1. Apply Gravity (Affects vertical component of velocity)
    if not is_on_floor():
        self.velocity.y += gravity * delta

    # 2. Handle Jump Input
    if Input.is_action_just_pressed("ui_accept") and is_on_floor():
        self.velocity.y = jump_force

    # 3. Set Horizontal Velocity
    self.velocity.x = speed

    # 4. Execute Movement & Collision Response
    move_and_slide()

    # 5. Update State Machine
    if is_on_floor():
        if self.velocity.x != 0:
            state = PlayerState.MOVING
        else:
            state = PlayerState.IDLE
    else:
        if self.velocity.y < 0:
            state = PlayerState.JUMPING
        elif self.velocity.y > 0:
            state = PlayerState.FALLING
