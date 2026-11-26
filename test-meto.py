import ollama

# Definimos la pregunta que le haremos a nuestro modelo local
pregunta = "Hola, preséntate brevemente y dime cuál es tu función."

print("Consultando a meto1.0:4b...\n")

# Llamamos al modelo local usando la librería oficial
respuesta = ollama.chat(
    model="meto1.0:4b",
    messages=[
        {"role": "user", "content": pregunta},
    ],
)

# Imprimimos únicamente el texto de la respuesta
print("Respuesta del modelo:")
print(respuesta["message"]["content"])
