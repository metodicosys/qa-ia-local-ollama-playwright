# 🚀 Ingeniería de QA con IA Local, Agentes Autónomos y Playwright MCP

Este repositorio documenta el flujo completo para implementar **Modelos de Lenguaje Locales (LLMs)** y **Agentes Autónomos** en el ciclo de vida de pruebas de software (STLC) sin depender de suscripciones en la nube ni exponer datos confidenciales a terceros.

---

## 📋 Contenido del Repositorio

* **`01_Automatizacion_QA_Agentes_Playwright_MCP.pptx`**: Guía de diseño de pruebas BDD, uso de contexto (CAG/RAG), configuración de Playwright MCP Server en VS Code y ejecución de pruebas E2E en pipelines CI/CD con GitHub Actions.
* **`02_Manual_Ollama_Local_API_Promptfoo.pptx`**: Manual práctico de instalación y gestión de Ollama por CLI, creación del modelo personalizado `meto1.0:4b` (`Modelfile`), consumo vía API REST (Python/Postman) y evaluación de calidad con Promptfoo.
* **`Modelfile`**: Receta de personalización sobre `qwen3.5:4b` para crear el asistente técnico local `meto1.0:4b`.
* **`test-meto.py`**: Script de ejemplo en Python utilizando el SDK oficial de Ollama.
* **`promptfooconfig.yaml`**: Suite de pruebas funcionales y de rendimiento para auditar las respuestas del modelo local.

---

## 🛠️ Requisitos Previos

* **Sistema Operativo:** Windows 10/11, macOS o Linux (mínimo 8 GB - 16 GB de RAM recomendados para modelos 4B).
* **[Ollama](https://ollama.com/)**: Motor de ejecución de LLMs en local.
* **[Visual Studio Code](https://code.visualstudio.com/)**: Editor principal con soporte para MCP y extensiones de IA.
* **[Python 3.10+](https://www.python.org/)**: Para scripts de integración y pruebas programáticas.
* **[Node.js 18+](https://nodejs.org/)**: Requerido para ejecutar `npx` con **Playwright MCP** y **Promptfoo**.

---

## ⚡ Guía Rápida de Implementación

### 1. Descargar el modelo base y crear `meto1.0:4b`

Descarga el modelo base desde la terminal y compila tu versión personalizada usando el `Modelfile`:

```bash
# Descargar modelo base
ollama pull qwen3.5:4b

# Crear modelo personalizado
ollama create meto1.0:4b -f ./Modelfile

# Verificar modelos disponibles
ollama list
```

Ejemplo de estructura del `Modelfile`:

```dockerfile
FROM qwen3.5:4b
PARAMETER temperature 0.7
SYSTEM """
Eres un asistente experto en programación y QA. Responde siempre en español, de forma directa y con ejemplos claros.
"""
```

---

### 2. Consumo vía API Local (Python y cURL)

Ollama expone automáticamente un servidor REST en `http://localhost:11434`.

**Desde Python:**

```bash
pip install ollama
python test-meto.py
```

**Desde Terminal / Postman (`POST http://localhost:11434/api/generate`):**

```bash
curl http://localhost:11434/api/generate -d '{
  "model": "meto1.0:4b",
  "prompt": "Hola, preséntate brevemente y dime cómo puedes ayudarme.",
  "stream": false
}'
```

---

### 3. Integración en Visual Studio Code

Puedes conectar `meto1.0:4b` en VS Code mediante dos alternativas:

1. **Extensión Continue (100% Open-Source y sin cuentas):**
   * Instala **Continue** desde el Marketplace (`Ctrl + Shift + X`).
   * Selecciona la pestaña **Local** → `+ Add Chat model` → Provider: `Ollama` → Model: `meto1.0:4b`.
   * Cambia el modo de `Agent` a `Chat` para interactuar fluido con modelos de 4B.
2. **Chat Nativo de VS Code (BYOK):**
   * Presiona `Ctrl + Shift + P` y ejecuta `Chat: Manage Language Models`.
   * Agrega el proveedor `Ollama` apuntando a `http://localhost:11434` y habilita `meto1.0:4b`.

---

### 4. Configuración de Playwright MCP Server

Para dotar al agente de capacidades de navegación real y generación de código E2E bajo el patrón **Page Object Model (POM)**:

1. Presiona `Ctrl + Shift + P` en VS Code y selecciona `MCP: Add Server...` (o `MCP: Browse MCP Servers`).
2. Configura el archivo global `mcp-config.json`:

```json
{
  "mcpServers": {
    "playwright": {
      "command": "npx",
      "args": [
        "@playwright/mcp@latest"
      ]
    }
  }
}
```

---

### 5. Evaluación de Calidad del Modelo con Promptfoo

Para validar que el modelo local cumple reglas de formato y tiempos de respuesta sin saturar la memoria RAM, ejecuta las pruebas de forma secuencial (`-j 1`):

```bash
# Ejecutar evaluación sin concurrencia paralela
npx promptfoo@latest eval -j 1

# Abrir dashboard visual de resultados en el navegador (http://localhost:15500)
npx promptfoo@latest view
```

---

## 🗺️ Roadmap / Próximos Pasos

* **Evaluación Semántica y RAG:** Implementación de métricas de fidelidad y relevancia con **DeepEval** y **Ragas**.
* **Seguridad en IA (Red Teaming):** Pruebas de resistencia contra *Prompt Injection* y *Jailbreaking* utilizando **Promptfoo**, **Garak** y **PyRIT**.
* **CI/CD:** Ejecución automatizada de suites Playwright en **GitHub Actions** con generación de reportes descargables.

---

## 🤝 Contribuciones y Contacto

Si este material te resultó útil para implementar IA local en tus flujos de QA o desarrollo, ¡no dudes en dejar una ⭐ en el repositorio o compartir tus mejoras mediante un Pull Request!
