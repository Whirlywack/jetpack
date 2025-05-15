extends ParallaxLayer

# Match player speed (from Player.gd)
var player_speed = 200.0
# Parallax factor - background moves slower than foreground
var parallax_factor = 0.5
# Calculated background speed
var scroll_speed = player_speed * parallax_factor
# Track motion offset
var current_offset = Vector2.ZERO

func _physics_process(delta: float) -> void:
    # Move the layer to create scrolling effect
    # Since our player is moving right/forward, the background should move left
    # Background moves slower than player for parallax effect
    current_offset.x -= scroll_speed * delta
    set_motion_offset(current_offset)
