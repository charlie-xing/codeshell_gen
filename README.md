# codeshell_gen

Generate text using LLMs with customizable prompts FOR CODESHELL LLM, base gen.nvim.

![gen_nvim](https://github.com/David-Kunz/gen.nvim/assets/1009936/79f17157-9327-484a-811b-2d71ceb8fbe3)

## Video

[![Local LLMs in Neovim: gen.nvim](https://user-images.githubusercontent.com/1009936/273126287-7b5f2b40-c678-47c5-8f21-edf9516f6034.jpg)](https://youtu.be/FIZt7MinpMY?si=KChSuJJDyrcTdYiM)

## Requires

- [llama_cpp_for_codeshell](https://github.com/WisdomShell/llama_cpp_for_codeshell) with an appropriate model, e.g. 
- [Curl](https://curl.se/)

## Install

Install with your favorite plugin manager, e.g. [lazy.nvim](https://github.com/folke/lazy.nvim)

Example with Lazy

```lua
-- Minimal configuration
{ "charlie-xing/codeshell_gen" },

```

```lua

-- Custom Parameters (with defaults)
{
    "charlie-xing/codeshell_gen",
    opts = {
        model = "codeshell", -- The default model to use.
        display_mode = "float", -- The display mode. Can be "float" or "split".
        show_prompt = false, -- Shows the Prompt submitted to Ollama.
        show_model = false, -- Displays which model you are using at the beginning of your chat session.
        no_auto_close = false, -- Never closes the window automatically.
        command = "curl --silent --no-buffer -X POST http://localhost:8080/completion -d $body",
        model_options = {
            n_predict = 8192,
            temperature = 0.1,
            repetition_penalty = 1.2,
            top_k = 40,
            top_p = 0.95,
            stream = true,
            stop = {"|<end>|", "|end|", "<|endoftext|>", "## human"}
        },
        -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
        -- This can also be a lua function returning a command string, with options as the input parameter.
        -- The executed command must return a JSON object with { response, context }
        -- (context property is optional).
        list_models = '<omitted lua function>', -- Retrieves a list of model names
        debug = false -- Prints errors and the command which is run.
    }
},
```

Here are all [available models](https://ollama.ai/library).

Alternatively, you can call the `setup` function:

```lua
require('gen').setup({
  -- same as above
})
```

## Usage

Use command `Gen` to generate text based on predefined and customizable prompts.

Example key maps:

```lua
vim.keymap.set({ 'n', 'v' }, '<leader>]', ':Gen<CR>')
```

You can also directly invoke it with one of the [predefined prompts](./lua/gen/prompts.lua):

```lua
vim.keymap.set('v', '<leader>]', ':Gen Enhance_Grammar_Spelling<CR>')
```

Once a conversation is started, the whole context is sent to the LLM. That allows you to ask follow-up questions with

```lua
:Gen Chat
```

and once the window is closed, you start with a fresh conversation.

You can select a model from a list of all installed models with

```lua
require('gen').select_model()
```

## Custom Prompts

All prompts are defined in `require('gen').prompts`, you can enhance or modify them.

Example:

```lua
require('gen').prompts['Elaborate_Text'] = {
  prompt = "Elaborate the following text:\n$text",
  replace = true
}
require('gen').prompts['Fix_Code'] = {
  prompt = "Fix the following code. Only ouput the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
  replace = true,
  extract = "```$filetype\n(.-)```"
}
```

You can use the following properties per prompt:

- `prompt`: (string | function) Prompt either as a string or a function which should return a string. The result can use the following placeholders:
  - `$text`: Visually selected text
  - `$filetype`: Filetype of the buffer (e.g. `javascript`)
  - `$input`: Additional user input
  - `$register`: Value of the unnamed register (yanked text)
- `replace`: `true` if the selected text shall be replaced with the generated output
- `extract`: Regular expression used to extract the generated result
- `model`: The model to use, e.g. `zephyr`, default: `mistral`

## Tip

User selections can be delegated to [Telescope](https://github.com/nvim-telescope/telescope.nvim) with [telescope-ui-select](https://github.com/nvim-telescope/telescope-ui-select.nvim).
