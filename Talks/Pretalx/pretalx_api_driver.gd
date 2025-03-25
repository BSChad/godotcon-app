class_name PretalxAPIDriver
extends Node


@export var api_key: String
@export var httpclient: HTTPRequest

const pretalx_base_uri := "https://talks.godotengine.org"
# TODO: Make this talks when schedule released
const talks_uri := "/api/events/godotcon-us-2025/submissions"


func get_talks(handler: Callable):
	var handler_callable := Callable.create(self, "handle_request_completed")
	handler_callable.bind(handler)
	var headers = [
		"User-Agent: Pirulo/1.0 (Godot)",
		"Accept: application/json, text/javascript",
		"Authorization: Token " + api_key
	]
	httpclient.request_completed.connect(handle_request_completed.bind(handler))
	httpclient.request(pretalx_base_uri + talks_uri, headers)

func handle_request_completed(result, _response_code, _headers, body, callback):
	if result != HTTPRequest.Result.RESULT_SUCCESS:
		return []
	
	var results := []
	var json := JSON.new()
	var error = json.parse(body.get_string_from_utf8())
	
	if error == 0 and json.data != null:
		for i in json.data["results"].size():
			var talk := Talk.new(json.data["results"][i])
			results.push_back(talk)
	callback.call(results)
