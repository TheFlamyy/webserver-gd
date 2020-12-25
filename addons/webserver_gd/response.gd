class_name WebResponse
extends Resource

const STATUS_CODE: Dictionary = {
	100: "CONTINUE",
	101: "SWITCHING PROTOCOLS",
	200: "OK",
	201: "CREATED",
	202: "ACCEPTED",
	203: "NON-AUTHORATIVE INFORMATION",
	204: "NO CONTENT",
	205: "RESET CONTENT",
	206: "PARTIAL CONTENT",
	300: "MULTIPLE CHOICES",
	301: "MOVED PERMANENTLY",
	302: "FOUND",
	303: "SEE OTHER",
	304: "NOT MODIFIED",
	305: "USE PROXY",
	306: "UNUSED",
	307: "TEMPORARY REDIRECT",
	400: "BAD REQUEST",
	401: "UNAUTHORIZED",
	402: "PAYMENT REQUIRED",
	403: "FORBIDDEN",
	404: "NOT FOUND",
	405: "METHOD NOT ALLOWED",
	406: "NOT ACCEPTABLE",
	407: "PROXY AUTHENTICATION REQUIRED",
	408: "REQUEST TIMEOUT",
	409: "CONFLICT",
	410: "GONE",
	411: "LENGTH REQUIRED",
	412: "PRECONDITION FAILED",
	413: "REQUEST ENTITY TOO LARGE",
	414: "REQUEST-URL TOO LONG",
	415: "UNSUPPORTED MEDIA TYPE",
	416: "REQUESTED RANGE NOT SATISFIABLE",
	417: "EXPECTION FAILED",
	500: "INTERNAL SERVER ERROR",
	501: "NOT IMPLEMENTED",
	502: "BAD GATEWAY",
	503: "SERVICE UNAVAILABLE",
	504: "GATEWAY TIMEOUT",
	505: "HTTP VERSION NOT SUPPORTED"
}

var version: String
var status_code: int
var headers: WebHeaders = WebHeaders.new()
var body: String = ""

func _init(ver: String, code: int) -> void:
	version = ver
	status_code = code

func to_data() -> PoolByteArray:
	var string: String = "%s %s %s\r\n" % [version, str(status_code), STATUS_CODE[status_code]]
	string += "%s\r\n" % str(headers)
	string += '\r\n'
	string += body
	print(string)
	return string.to_utf8()
