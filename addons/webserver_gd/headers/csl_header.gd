class_name CSLHeader # Comma Separated List
extends Resource

var value: PoolStringArray

func _init(http: String) -> void:
	value = http.split(',')


func _to_string() -> String:
	return value.join(', ')
