# yagp.nvim
Yet Another Gemini Plugin for neovim.

Demo: https://youtu.be/68tBPBT9WdI

## What does this plugin do?

Yagp adds the Google's Gemini API to your neovim configuration. So, a chatbot in neovim and the output goes into a new buffer called yagpchat.

## Backstory

I tried out two plugins for using Gemini API (Google's bard) but I didn't like those because there wasn't a way to save the conversation or have a easy way to copy paste without accidentally losing it. Buffer pop ups (hope thats what it is called) also make it difficult to look at what is written in the background.
I sat down and wrote this plugin then. In your codebase(or a separate buffer), you write the prompt (no need to save it) and visual select the prompt and the code you want to associate with the prompt and use the function `use_gemini()` (I don't know how to save it as a user command and let it access the range). This sends the prompt to gemini and puts the results into at the end of a buffer called `yagpchat`. You can copy paste from there.
I am open to all suggestions, refactors and better ways to program cause the codebase is pretty bad and I never wrote lua code before this.


## Setup
Add `export GEMINI_API_KEY="YOUR_API_KEY"` to your `.bashrc` or `.zshrc` and source it again

For packer.nvim, add:
```
use {
    "airpods69/yagp.nvim"
    requires = { 
        {'nvim-lua/plenary.nvim'} 
    }
}
```

To use this, Write your prompt over the top of the code you wish to use the prompt for. Visual select the prompt and the code and use `:'<'>lua use_gemini()` to use the function. It will `vsplit` a buffer named `yagpchat` and append your chat to it with the response from Gemini API.


### TO DO
- [ ] Proper buffer talking without saving it accidentally.
- [ ] Add context based answers from the lua backend
- [ ] Add a way to install using packer.nvim (Or lazy.nvim, whichever you like)
