# MainMenu.gd
# Handles the Start Game button to load the MainGameScene
extends Control

func _ready():
    var btn = $StartButton
    btn.pressed.connect(_on_start_button_pressed)

func _on_start_button_pressed():
    var main_game_scene = load("res://res/main/MainGameScene.tscn")
    get_tree().change_scene_to_packed(main_game_scene)
