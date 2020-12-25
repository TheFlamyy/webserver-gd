tool
extends EditorPlugin

func _enter_tree() -> void:
	add_autoload_singleton("Webserver", "res://addons/webserver_gd/webserver.gd")


func _exit_tree() -> void:
	remove_autoload_singleton("Webserver")
