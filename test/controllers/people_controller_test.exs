defmodule EctoTuplesExample.PeopleControllerTest do
  use EctoTuplesExample.ConnCase

  alias EctoTuplesExample.People
  @valid_attrs %{first_name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, people_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing people"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, people_path(conn, :new)
    assert html_response(conn, 200) =~ "New people"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, people_path(conn, :create), people: @valid_attrs
    assert redirected_to(conn) == people_path(conn, :index)
    assert Repo.get_by(People, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, people_path(conn, :create), people: @invalid_attrs
    assert html_response(conn, 200) =~ "New people"
  end

  test "shows chosen resource", %{conn: conn} do
    people = Repo.insert! %People{}
    conn = get conn, people_path(conn, :show, people)
    assert html_response(conn, 200) =~ "Show people"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, people_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    people = Repo.insert! %People{}
    conn = get conn, people_path(conn, :edit, people)
    assert html_response(conn, 200) =~ "Edit people"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    people = Repo.insert! %People{}
    conn = put conn, people_path(conn, :update, people), people: @valid_attrs
    assert redirected_to(conn) == people_path(conn, :show, people)
    assert Repo.get_by(People, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    people = Repo.insert! %People{}
    conn = put conn, people_path(conn, :update, people), people: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit people"
  end

  test "deletes chosen resource", %{conn: conn} do
    people = Repo.insert! %People{}
    conn = delete conn, people_path(conn, :delete, people)
    assert redirected_to(conn) == people_path(conn, :index)
    refute Repo.get(People, people.id)
  end
end
