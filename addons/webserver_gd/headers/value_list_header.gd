class_name ValueListHeader
extends Resource

var values: Dictionary = {}

func _init(http: String) -> void:
	var spliced: PoolStringArray = http.split(',')
	for s in spliced:
		var args: PoolStringArray = s.split(';')
		var key: String = args[0]
		var val: float = -1.0
		if args.size() > 1:
			val = float(args[1])
		values[key] = val


func _to_string() -> String:
	var http: String = ''
	for key in values:
		var val: float = values[key]
		if val < 0:
			http += "%s, " % key
		else:
			http += "%s; q=%s, " % [key, val]
	return http
