class_name RangeHeader
extends Resource

var unit: String = ''
var ranges: Array = []

func _init(http: String) -> void:
	var spliced: PoolStringArray = http.split('=')
	unit = spliced[0]
	for string in spliced[1].split(','):
		var r: PoolStringArray = string.split('-')
		var current: Array = [-1, -1]
		if !r[0].empty():
			current[0] = int(r[0])
		if !r[1].empty():
			current[1] = int(r[1])
		ranges.append(current)


func _to_string() -> String:
	var string: String = '%s=' % unit
	for r in ranges:
		if r[0] >= 0:
			string += str(r[0])
		
		string += '-'
		
		if r[1] >= 0:
			string += str(r[1])
		
		string += ','
	return string.trim_suffix(',')
