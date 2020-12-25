class_name ContentRangeHeader
extends Resource

var unit: String = ''
var first: int = 0
var last: int = 0
var total: int = 0

func _init(http: String) -> void:
	var spaced: PoolStringArray = http.split(' ')
	unit = spaced[0]
	var slashed: PoolStringArray = spaced[1].split('/')
	total = int(slashed[1])
	var ranges: PoolStringArray = slashed[0].split('-')
	first = int(ranges[0])
	last = int(ranges[1])


func _to_string() -> String:
	return "%s %s-%s/%s" % [unit, str(first), str(last), str(total)]
