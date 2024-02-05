local curl = require('plenary.curl')

local function ask_gemini(text)
    local API_KEY = os.getenv("GEMINI_API_KEY")
    local url = "https://generativelanguage.googleapis.com/v1/models/gemini-pro:generateContent?key=" .. API_KEY
    local headers = { ["Content-Type"] = "application/json", }

	local preprompt = "You are an expert at programming and a very helpful AI. \z 
						Your name is Gemini. The user will ask you queries and the first few lines in comments will be the instructions. \z 
						These instructions can vary from programming languages. \r"
	
	local prompt = preprompt .. text

	local body = {
		contents = {
			{
				role = "user",
				parts = {
					text = prompt
				}
			}
		},
		safety_settings = {
			{
				category = "HARM_CATEGORY_SEXUALLY_EXPLICIT",
				threshold = "BLOCK_NONE"
			},
			{
				category = "HARM_CATEGORY_HATE_SPEECH",
				threshold = "BLOCK_NONE"
			},
			{
				category = "HARM_CATEGORY_HARASSMENT",
				threshold = "BLOCK_NONE"
			},
			{
				category = "HARM_CATEGORY_DANGEROUS_CONTENT",
				threshold = "BLOCK_NONE"
			}
		}
	}
	-- body = string.format(body, text)
	body = vim.json.encode(body)

	local response = {}

    local response = curl.post(url, {
		body = body,
        headers = headers,
    })

    if response.status ~= 200 then
		print("We entered")
        error("Request failed" .. respcode)
    end

	local response_json = vim.json.decode(response.body)
	local response_text = response_json["candidates"][1]["content"]["parts"][1]["text"]

    return response_text
end

return {
	ask_gemini = ask_gemini
}
