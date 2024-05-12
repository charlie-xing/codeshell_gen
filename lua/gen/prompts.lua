return {
  Generate = { prompt = "$input", replace = true },
  Chat = { prompt = "$input" },
  Summarize = { prompt = "对下列文字进行总结:\n$text" },
  Ask = { prompt = "关于以下文本, $input:\n$text" },
  Format_code = {
    prompt = "Format code in $filetype language style,To ensure readability, each line should have no more than 80 characters:\n$text",
    replace = true,
  },
  Enhance_Grammar_Spelling = {
    prompt =
    "Modify the following text to improve grammar and spelling, just output the final text without additional quotes around it:\n$text",
    replace = true,
  },
  Make_simple = {
    prompt =
    "Modify the following text to make it as simple and concise as possible, just output the final text without additional quotes around it:\n$text",
    replace = true,
  },
  Make_List = {
    prompt = "Render the following text as a markdown list:\n$text",
    replace = true,
  },
  Make_Table = {
    prompt = "Render the following text as a markdown table:\n$text",
    replace = true,
  },
  Review_Code = {
    prompt = "给出下面代码的优化建议:\n```$filetype\n$text\n```",
  },
  Add_Code = {
    prompt =
    "用$filetype语言写代码实现$text所描述的功能, only output the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
    replace = true,
  },
  Tra_En = {
    prompt =
    "Just translate following text to english,only output the final result english text without additional quotes:\n'''$text'''"
  },
  Tra_Cn = {
    prompt = "只完成翻译下面的文字为中文,only output the final text without additional quotes add text around it:\n'''$text'''"
  },
  Tra_jp = {
    prompt = "翻译下面的文字为日文:\n'''$text'''"
  },
  Tra_ru = {
    prompt = "翻译下面的文字为俄文:\n'''$text'''"
  },
  Call_en = {
    prompt = "定义一个$filetype语言的变量:\n'''$text'''"
  },
}
