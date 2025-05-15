extends CanvasLayer

# Reference to the ProgressBar node, will be set in _ready
@onready var energy_bar: ProgressBar

func _ready():
    # We'll need to ensure the ProgressBar node is actually named "EnergyBar" in HUD.tscn
    # or adjust this path accordingly.
    energy_bar = get_node_or_null("EnergyBar")
    if energy_bar == null:
        print_rich("[color=red][b]ERROR:[/b] HUD.gd could not find EnergyBar node. Make sure it exists in HUD.tscn and is named correctly.[/color]")

# Function to be called by the Player's signal
func update_energy_display(current_value: float, max_value: float):
    if energy_bar:
        energy_bar.max_value = max_value
        energy_bar.value = current_value
    # else:
        # print_rich("[color=yellow]Warning:[/color] EnergyBar node not found in HUD, cannot update display.")

# Example of how to initialize or test the bar if player is not ready yet
# Called by Player in its _ready function after emitting initial energy
func set_initial_energy(current_value: float, max_value: float):
    if energy_bar:
        energy_bar.max_value = max_value
        energy_bar.value = current_value
    # else:
        # print_rich("[color=yellow]Warning:[/color] EnergyBar node not found in HUD, cannot set initial energy display.")
