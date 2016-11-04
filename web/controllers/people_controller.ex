defmodule EctoTuplesExample.PeopleController do
  use EctoTuplesExample.Web, :controller

  alias EctoTuplesExample.People

  def index(conn, _params) do
    people = Repo.all(People)
    render(conn, "index.html", people: people)
  end

  def new(conn, _params) do
    changeset = People.changeset(%People{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"people" => people_params}) do
    changeset = People.changeset(%People{}, people_params)

    case Repo.insert(changeset) do
      {:ok, _people} ->
        conn
        |> put_flash(:info, "People created successfully.")
        |> redirect(to: people_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    people = Repo.get!(People, id)
    render(conn, "show.html", people: people)
  end

  def edit(conn, %{"id" => id}) do
    people = Repo.get!(People, id)
    changeset = People.changeset(people)
    render(conn, "edit.html", people: people, changeset: changeset)
  end

  def update(conn, %{"id" => id, "people" => people_params}) do
    people = Repo.get!(People, id)
    changeset = People.changeset(people, people_params)

    case Repo.update(changeset) do
      {:ok, people} ->
        conn
        |> put_flash(:info, "People updated successfully.")
        |> redirect(to: people_path(conn, :show, people))
      {:error, changeset} ->
        render(conn, "edit.html", people: people, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    people = Repo.get!(People, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(people)

    conn
    |> put_flash(:info, "People deleted successfully.")
    |> redirect(to: people_path(conn, :index))
  end
end
