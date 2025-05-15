# Player.gd
# Implements player movement, multi-boost jumps, and energy system.
extends CharacterBody2D

signal energy_updated(current_energy_value, max_energy_value)

# Movement Parameters
@export var speed := 200.0
@export var jump_force := -400.0  # Initial jump force from the ground
@export var gravity := 900.0

# Air Boost & Energy System (based on specs)
@export var max_air_boosts := 3
@export var boost_force := -300.0  # Upward force for each air boost
@export var max_energy := 100.0
@export var energy_per_boost := 25.0
@export var passive_energy_regen_rate := 5.0  # Energy per second, always active

var current_energy := 100.0
var air_boosts_remaining := 0

# State Management
enum PlayerState { IDLE, MOVING, JUMPING, FALLING }
var current_player_state := PlayerState.IDLE

func _ready():
	current_energy = max_energy
	# Initialize air_boosts_remaining; if player can start in air, ensure this is set.
	# For typical ground start, it will be correctly set upon first landing.
	if is_on_floor():
		air_boosts_remaining = max_air_boosts
	else:
		# If starting in air somehow, might need a different initial value or rely on first landing.
		air_boosts_remaining = max_air_boosts 
	emit_signal("energy_updated", current_energy, max_energy)

func _physics_process(delta):
	var desired_velocity = velocity

	# --- Energy Management ---
	# Passive Energy Regeneration
	if current_energy < max_energy:
		current_energy += passive_energy_regen_rate * delta
		current_energy = min(current_energy, max_energy) # Clamp to max
		emit_signal("energy_updated", current_energy, max_energy)

	# --- Vertical Movement (Gravity, Jump, Boosts) ---
	if not is_on_floor():
		desired_velocity.y += gravity * delta
	else:
		# Reset air boosts when on the ground and not already full (e.g., just landed)
		if air_boosts_remaining < max_air_boosts:
			air_boosts_remaining = max_air_boosts
			# print("Landed, boosts reset to: ", air_boosts_remaining)

	# Handle Jump / Air Boost Input
	if Input.is_action_just_pressed("ui_accept"): # "ui_accept" is usually Spacebar or A button
		if is_on_floor():
			desired_velocity.y = jump_force
			current_player_state = PlayerState.JUMPING
			# print("Initial jump! Velocity.y: ", desired_velocity.y)
		elif air_boosts_remaining > 0 and current_energy >= energy_per_boost:
			desired_velocity.y = boost_force # Apply a fresh boost impulse
			current_energy -= energy_per_boost
			emit_signal("energy_updated", current_energy, max_energy)
			air_boosts_remaining -= 1
			current_player_state = PlayerState.JUMPING # Treat boosts as part of jumping motion
			# print("Air boost! Remaining: ", air_boosts_remaining, " Energy: ", current_energy, " Velocity.y: ", desired_velocity.y)
		# else:
			# Optional: print reason for not boosting (for debugging)
			# if air_boosts_remaining <= 0:
				# print("Cannot boost: No air boosts remaining.")
			# if current_energy < energy_per_boost:
				# print("Cannot boost: Not enough energy. Have: ", current_energy, " Need: ", energy_per_boost)

	# --- Horizontal Movement ---
	# Continuous forward auto-scroll as per specs
	desired_velocity.x = speed

	# --- Apply Movement & Update State ---
	velocity = desired_velocity
	move_and_slide()

	# Update player state based on movement and floor status
	var _previous_state = current_player_state
	if is_on_floor():
		if velocity.x != 0:
			current_player_state = PlayerState.MOVING
		else:
			current_player_state = PlayerState.IDLE
	else: # In the air
		# If we were JUMPING and upward velocity has diminished or reversed, we are now FALLING
		if current_player_state == PlayerState.JUMPING and velocity.y >= 0: 
			current_player_state = PlayerState.FALLING
		# If not jumping and Y velocity is positive, definitely falling
		elif current_player_state != PlayerState.JUMPING and velocity.y > 0:
			current_player_state = PlayerState.FALLING
		# If Y velocity is negative and not already jumping, it implies a new jump/boost started
		# This case is handled by input processing setting state to JUMPING directly.

	# Optional: Print state changes for debugging
	# if current_player_state != _previous_state:
		# print("State changed from ", PlayerState.keys()[_previous_state], " to ", PlayerState.keys()[current_player_state])

	# Optional: Print values for debugging
	# print_debug_info()

func print_debug_info():
	print("Energy: %d/%d | Boosts Left: %d | State: %s | OnFloor: %s | Vel.Y: %.0f" % \
		[current_energy, max_energy, air_boosts_remaining, PlayerState.keys()[current_player_state], is_on_floor(), velocity.y])

# Getter methods for MainGameScene to access energy values
func get_current_energy() -> float:
	return current_energy

func get_max_energy() -> float:
	return max_energy
