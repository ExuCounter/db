defmodule DB do
  def execute(sql) do
    sql |> tokenize |> build_parse_tree() |> to_ast()
  end

  def build_parse_tree(tokens) do
    {:ok, parse_tree} = :parser.parse(tokens)

    parse_tree
  end

  def tokenize(sql) do
    {:ok, tokens, _} = :lexer.string(sql)

    tokens
  end

  def to_ast({:select, columns, table}) do
    %{
      type: :select,
      columns: normalize_columns(columns),
      from: table
    }
  end

  def to_ast({:select, columns, table, {:where, condition}}) do
    %{
      type: :select,
      columns: normalize_columns(columns),
      from: table,
      where: to_ast(condition)
    }
  end

  def to_ast({:eq, left, right}) do
    %{op: :eq, left: left, right: right}
  end

  def to_ast({:and_op, left, right}) do
    %{op: :and, left: to_ast(left), right: to_ast(right)}
  end

  def to_ast({:or_op, left, right}) do
    %{op: :or, left: to_ast(left), right: to_ast(right)}
  end

  defp normalize_columns(:all), do: :all
  defp normalize_columns(columns) when is_list(columns), do: columns
end
