return {
  'yacineMTB/dingllm.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local system_prompt =
      'You should replace the code that you are sent, only following the comments. Do not talk at all. Only output valid code. Do not provide any backticks that surround the code. Never ever output backticks like this ```. Any comment that is asking you for something should be removed after you satisfy them. Other comments should left alone. Do not output backticks'
    local helpful_prompt = 'You are a helpful assistant. What I have sent are my notes so far. You are very curt, yet helpful.'
    local dingllm = require 'dingllm'

    local function groq_replace()
      dingllm.invoke_llm_and_stream_into_editor({
        url = 'https://api.groq.com/openai/v1/chat/completions',
        model = 'llama3.1-70b-versatile',
        api_key_name = 'GROQ_API_KEY',
        system_prompt = system_prompt,
        replace = true,
      }, dingllm.make_openai_spec_curl_args, dingllm.handle_openai_spec_data)
    end

    local function groq_help()
      dingllm.invoke_llm_and_stream_into_editor({
        url = 'https://api.groq.com/openai/v1/chat/completions',
        model = 'llama3-70b-8192',
        api_key_name = 'GROQ_API_KEY',
        system_prompt = helpful_prompt,
        replace = false,
      }, dingllm.make_openai_spec_curl_args, dingllm.handle_openai_spec_data)
    end

    local function openai_replace()
      dingllm.invoke_llm_and_stream_into_editor({
        url = 'https://api.openai.com/v1/chat/completions',
        model = 'gpt-4o',
        api_key_name = 'OPENAI_API_KEY',
        system_prompt = system_prompt,
        replace = true,
      }, dingllm.make_openai_spec_curl_args, dingllm.handle_openai_spec_data)
    end

    local function openai_help()
      dingllm.invoke_llm_and_stream_into_editor({
        url = 'https://api.openai.com/v1/chat/completions',
        model = 'gpt-4o',
        api_key_name = 'OPENAI_API_KEY',
        system_prompt = helpful_prompt,
        replace = false,
      }, dingllm.make_openai_spec_curl_args, dingllm.handle_openai_spec_data)
    end

    local function anthropic_help()
      dingllm.invoke_llm_and_stream_into_editor({
        url = 'https://api.anthropic.com/v1/messages',
        model = 'claude-3-5-sonnet-20240620',
        api_key_name = 'ANTHROPIC_API_KEY',
        system_prompt = helpful_prompt,
        replace = false,
      }, dingllm.make_anthropic_spec_curl_args, dingllm.handle_anthropic_spec_data)
    end

    local function anthropic_replace()
      dingllm.invoke_llm_and_stream_into_editor({
        url = 'https://api.anthropic.com/v1/messages',
        model = 'claude-3-5-sonnet-20240620',
        api_key_name = 'ANTHROPIC_API_KEY',
        system_prompt = system_prompt,
        replace = true,
      }, dingllm.make_anthropic_spec_curl_args, dingllm.handle_anthropic_spec_data)
    end

    vim.keymap.set({ 'n', 'v' }, '<leader>ck', groq_replace, { desc = 'llm groq' })
    vim.keymap.set({ 'n', 'v' }, '<leader>cK', groq_help, { desc = 'llm groq_help' })
    vim.keymap.set({ 'n', 'v' }, '<leader>cL', openai_help, { desc = 'llm openai_help' })
    vim.keymap.set({ 'n', 'v' }, '<leader>cl', openai_replace, { desc = 'llm openai' })
    vim.keymap.set({ 'n', 'v' }, '<leader>cI', anthropic_help, { desc = 'llm anthropic_help' })
    vim.keymap.set({ 'n', 'v' }, '<leader>ci', anthropic_replace, { desc = 'llm anthropic' })
  end,
}
