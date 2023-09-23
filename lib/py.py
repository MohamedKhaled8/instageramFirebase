import openai

# Set up your OpenAI API key
api_key = '@betting-api/1xbet'
openai.api_key = api_key

# Function to get a prediction from the chatbot
def get_prediction(prompt):
    response = openai.Completion.create(
        engine="davinci",
        prompt=prompt,
        max_tokens=50  # Adjust as needed
    )
    return response.choices[0].text.strip()

# Example usage:
user_input = "What's your prediction for the next Aviator game?"
prediction = get_prediction(user_input)
print(f"Predicted outcome: {prediction}")
