class_name WarningHeader
extends Resource

var warn_code: int
var warn_agent: String
var warn_text: String
var warn_date: Dictionary

func _init(http: String) -> void:
	var spliced: PoolStringArray = http.split(' ')
	warn_code = int(spliced[0])
	warn_agent = spliced[1]
	warn_text = spliced[2]
	warn_date = DateHeader.from_http_date(spliced[3])


func _to_string() -> String:
	return "%s %s %s %s" % [str(warn_code), warn_agent, warn_text, DateHeader.to_http_date(warn_date)]
