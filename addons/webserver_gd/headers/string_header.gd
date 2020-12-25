class_name StringHeader
extends Resource

var value: String

func _init(http: String) -> void:
	value = http

func _to_string() -> String:
	return value
