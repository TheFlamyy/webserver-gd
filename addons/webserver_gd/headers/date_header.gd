class_name DateHeader
extends Resource

const _weekday = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
const _month = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]

var date: Dictionary

static func to_http_date(date: Dictionary) -> String:
	if date.empty():
		return ''
	var weekday: String = _weekday[date.weekday - 1]
	var day: String = str(date.day).pad_zeros(2)
	var month: String = _month[date.month - 1]
	
	var hour: String = str(date.hour).pad_zeros(2)
	var minute: String = str(date.minute).pad_zeros(2)
	var second: String = str(date.second).pad_zeros(2)
	return "%s, %s %s %s %s:%s:%s GMT" % [weekday, day, month, str(date.year), hour, minute, second]# TODO GMT


static func from_http_date(http: String) -> Dictionary:
	var args: PoolStringArray = http.replace(',', '').split(' ')
	var time: PoolStringArray = args[4].split(':')
	return {
		"weekday": _weekday.find(args[0]) + 1,
		"day": int(args[1]),
		"month": _month.find(args[2]) + 1,
		"year": int(args[3]),
		"hour": int(time[0]),
		"minute": int(time[1]),
		"second": int(time[2])
	}


func _init(http: String = "Mon, 01 Jan 1990 00:00:00 GMT") -> void:
	date = from_http_date(http)


func _to_string() -> String:
	return to_http_date(date)
