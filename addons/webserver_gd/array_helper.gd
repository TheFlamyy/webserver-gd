class_name WebArrayHelper
extends Resource

static func to_array(string_array: PoolStringArray) -> Array:
	var array: Array = []
	for string in string_array:
		array.append(string)
	return array
