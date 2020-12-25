class_name NumberHeader
extends Resource

var value: int

func _init(http: String) -> void:
	value = int(http)

func _to_string() -> String:
	return str(value)
