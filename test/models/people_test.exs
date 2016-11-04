defmodule EctoTuplesExample.PeopleTest do
  use EctoTuplesExample.ModelCase

  alias EctoTuplesExample.People

  setup do
    Repo.insert_all(People, [
      %{id: 1, first_name: "Jean"},
      %{id: 2, first_name: "Marc"},
      %{id: 3, first_name: "Luc"},
    ])
    :ok
  end
  test "with list of tuples" do
    array = [{1, "Jean"}, {2, "Marc"}]
    from(x in People,
    where: fragment("(?, ?)", x.id, x.first_name) in ^array)
    |> Repo.all()
    assert true
  end
  test "with list of typed tuples" do
    array = [{{1, :integer}, {"Jean", :string}}, {{2, :integer}, {"Marc", :string}}]
    from(x in People,
    where: fragment("(?, ?)", x.id, x.first_name) in ^array)
    |> Repo.all()
    assert true
  end
  test "with list of lists" do
    array = [[1, "Jean"], [2, "Marc"]]
    from(x in People,
    where: fragment("(?, ?)", x.id, x.first_name) in ^array)
    |> Repo.all()
    assert true
  end
  test "with list of typed lists" do
    array = [[{1, :integer}, {"Jean", :string}], [{2, :integer}, {"Marc", :string}]]
    from(x in People,
    where: fragment("(?, ?)", x.id, x.first_name) in ^array)
    |> Repo.all()
    assert true
  end
end
