defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(str) do
    str
    |> String.split("\n")
    |> Enum.map(&process_line/1)
    |> Enum.join()
    |> patch()
  end

  defp process_line(line) do
    cond do
      String.starts_with?(line, "#") ->
        line
        |> parse_header()
        |> gen_header()
      String.starts_with?(line, "*") ->
        gen_list(line)
      true ->
        gen_paragraph(line)
    end
  end

  defp parse_header(line) do
    [h | t] = String.split(line)
    {
      String.length(h),
      Enum.join(t, " "),
    }
  end

  defp gen_header({level, content}) do
    "<h#{level}>#{content}</h#{level}>"
  end

  defp gen_list(line) do
    content = String.trim_leading(line, "* ")
    "<li>#{process_content(content)}</li>"
  end

  defp gen_paragraph(line) do
    "<p>#{process_content(line)}</p>"
  end

  defp process_content(content) do
    content
    |> String.split(" ")
    |> Enum.map(&process_word/1)
    |> Enum.join(" ")
  end

  defp process_word(word) do
    word
    |> handle_prefix()
    |> handle_suffix()
  end

  defp handle_prefix(word) do
    cond do
      String.starts_with?(word, "__") ->
        "<strong>#{String.slice(word, 2..-1)}"

      String.starts_with?(word, "_") ->
        "<em>#{String.slice(word, 1..-1)}"

      true ->
        word
    end
  end

  defp handle_suffix(word) do
    cond do
      String.ends_with?(word, "__") ->
        "#{String.slice(word, 0..-3)}</strong>"

      String.ends_with?(word, "_") ->
        "#{String.slice(word, 0..-2)}</em>"

      true ->
        word
    end
  end

  defp patch(str) do
    str
    |> String.replace("<li>", "<ul><li>", global: false)
    |> String.replace_suffix("</li>", "</li></ul>")
  end
end
