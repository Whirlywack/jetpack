# main.gd - Project entry point
# Loads the main menu scene on startup
extends Node

func _ready():
    var main_menu_scene = load("res://res/ui/MainMenu.tscn")
    var main_menu = main_menu_scene.instantiate()
    add_child(main_menu)
