# Prompt: Context Backup

Your task is to create a "context snapshot" of our current session so you can quickly restore your understanding in the future.

Analyze the conversation and your current knowledge base. Then, generate a concise, well-structured markdown document that summarizes the key information.

The summary must include:

1. **Core Topic(s):** A brief overview of the main subject(s) of the session (e.g., "Refactoring the authentication service," "Implementing the Model Context Protocol").
2. **Key Concepts & Decisions:** List the critical concepts, architectural decisions, and user preferences that have been established.
3. **Important Artifacts:** Reference key file paths, generated documents, or specific code locations that are central to the context.
4. **External References:** If we discussed or used external documentation (via URLs or other files), link to them instead of repeating their content.
5. **Goal:** The final output should be a self-contained "bootstrap" document. When you read it in a future session, it should be sufficient to restore your working context to a level equivalent to or greater than its current state.

Generate the content for this context snapshot and write it to the `~/workspace/contexts/<context-name>.md`.
