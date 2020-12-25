class_name RetryAfterHeader
extends Resource

var date: DateHeader = null
var seconds: NumberHeader = null

func _init(http: String) -> void:
	var regex: RegEx = RegEx.new()
	regex.compile("[A-z]{3},\\s\\d*\\s[A-z]{3}\\s\\d*\\s(\\d*:?)*\\s.*")
	var result: RegExMatch = regex.search(http)
	if result:
		date = DateHeader.new(http)
	else:
		seconds = NumberHeader.new(http)


func _to_string() -> String:
	if seconds:
		return str(seconds)
	if date:
		return str(date)
	return ''
