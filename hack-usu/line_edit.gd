extends LineEdit

@onready var text_label = get_node("../Label2")
var http_request: HTTPRequest
var api_key = "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"  # Replace with your actual API key
var url = "https://api-inference.huggingface.co/models/meta-llama/Llama-3.2-3B-Instruct"  # Replace with your chosen model endpoint
# Called when the node enters the scene tree for the first time.

func _ready():
	text_label.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_text_submitted(new_text: String) -> void:
	hide()
	text_label.show()
	# Create and add the HTTPRequest node
	http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", Callable(self, "_on_request_completed"))
	
	# Prepare your prompt and JSON data
	var prompt = new_text
	print(prompt)
	var data = {
		"inputs": prompt
	}
	# Set up the request headers
	var headers = [
		"Authorization: Bearer " + api_key,
		"Content-Type: application/json"
	]
	# Convert the data dictionary to a JSON string
	var json_data = JSON.stringify(data)
	# The signature for HTTPRequest.request() in Godot 4 is:
	# request(url: String, custom_headers: Array, method: int, request_data: String, timeout_sec: float = 10.0, ssl_validate_domain: bool = true)
	# Use HTTPClient.METHOD_POST (an integer constant) for the method parameter.
	var error = http_request.request(url, headers, HTTPClient.METHOD_POST, json_data)
	
	if error != OK:
		print("Failed to send request, error code: ", error)
	
func _on_request_completed(result: int, response_code: int, headers: Array, body: PackedByteArray) -> void:
	if response_code == 200:
		var json = JSON.new()
		var err = json.parse(body.get_string_from_utf8())
		if err == OK:
			var response = json.get_data()
			if response is Array and response.size() > 0:
				var generated_text = response[0].get("generated_text", "No generated text")
				print("Generated text: ", generated_text)
				LLM_resources.llm_response1=generated_text
			else:
				print("Unexpected response structure: ", response)
		else:
			print("Error parsing JSON, error code: ", err)
	else:
		print("HTTP error code: ", response_code)
