class_name IfRangeHeader
extends Resource

var tag: ETagHeader = null
var date: DateHeader = null

func _init(http: String) -> void:
	var regex: RegEx = RegEx.new()
	regex.compile("[A-z]{3},\\s\\d*\\s[A-z]{3}\\s\\d*\\s(\\d*:?)*\\s.*")
	var result: RegExMatch = regex.search(http)
	if result:
		date = DateHeader.new(http)
	else:
		tag = ETagHeader.new(http)


func _to_string() -> String:
	if tag:
		return str(tag)
	if date:
		return str(date)
	return ''
