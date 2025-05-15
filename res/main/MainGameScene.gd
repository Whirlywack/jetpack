extends Node2D

# References to be set in _ready
@onready var player_node: CharacterBody2D
@onready var hud_node: CanvasLayer

func _ready():
    # Get references to the Player and HUD nodes
    # Ensure your Player node is named "Player" and HUD node is named "HUD" in MainGameScene.tscn
    player_node = get_node_or_null("Player")
    hud_node = get_node_or_null("HUD")

    if player_node and hud_node:
        # Connect the player's energy_updated signal to the HUD's update_energy_display function
        # Make sure 'update_energy_display' is the correct function name in HUD.gd
        if player_node.has_signal("energy_updated") and hud_node.has_method("update_energy_display"):
            player_node.energy_updated.connect(hud_node.update_energy_display)
            print_rich("[color=green]Successfully connected Player's energy_updated to HUD.update_energy_display[/color]")
            
            # Emit initial energy state from player to HUD if player has the method (it does because we added it)
            if player_node.has_method("get_current_energy") and player_node.has_method("get_max_energy"):
                 var initial_energy = player_node.get_current_energy()
                 var max_energy_val = player_node.get_max_energy()
                 if hud_node.has_method("set_initial_energy"):
                    hud_node.set_initial_energy(initial_energy, max_energy_val)
                 else:
                    # Fallback if set_initial_energy isn't on HUD, directly update (though set_initial_energy is better)
                    hud_node.update_energy_display(initial_energy, max_energy_val)
            elif player_node.current_energy != null and player_node.max_energy != null : # Direct access if methods not present (less ideal)
                 if hud_node.has_method("set_initial_energy"):
                    hud_node.set_initial_energy(player_node.current_energy, player_node.max_energy)
                 else:
                    hud_node.update_energy_display(player_node.current_energy, player_node.max_energy)

        else:
            if not player_node.has_signal("energy_updated"):
                print_rich("[color=red][b]ERROR:[/b] Player node does not have signal 'energy_updated'.[/color]")
            if not hud_node.has_method("update_energy_display"):
                print_rich("[color=red][b]ERROR:[/b] HUD node does not have method 'update_energy_display'. Check HUD.gd.[/color]")
    else:
        if not player_node:
            print_rich("[color=red][b]ERROR:[/b] Player node not found in MainGameScene. Check name or path.[/color]")
        if not hud_node:
            print_rich("[color=red][b]ERROR:[/b] HUD node not found in MainGameScene. Make sure to instance HUD.tscn and name it 'HUD'.[/color]")

# We need to add these getter methods to Player.gd for robust connection
