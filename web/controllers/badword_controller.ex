defmodule Workshop.BadwordController do
  use Workshop.Web, :controller

  alias Workshop.Badword

  def index(conn, _params) do
    badwords = Repo.all(Badword)
    render(conn, "index.html", badwords: badwords)
  end

  def new(conn, _params) do
    changeset = Badword.changeset(%Badword{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"badword" => badword_params}) do
    changeset = Badword.changeset(%Badword{}, badword_params)

    case Repo.insert(changeset) do
      {:ok, badword} ->
        conn
        |> put_flash(:info, "Badword created successfully.")
        |> redirect(to: badword_path(conn, :show, badword))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    badword = Repo.get!(Badword, id)
    render(conn, "show.html", badword: badword)
  end

  def edit(conn, %{"id" => id}) do
    badword = Repo.get!(Badword, id)
    changeset = Badword.changeset(badword)
    render(conn, "edit.html", badword: badword, changeset: changeset)
  end

  def update(conn, %{"id" => id, "badword" => badword_params}) do
    badword = Repo.get!(Badword, id)
    changeset = Badword.changeset(badword, badword_params)

    case Repo.update(changeset) do
      {:ok, badword} ->
        conn
        |> put_flash(:info, "Badword updated successfully.")
        |> redirect(to: badword_path(conn, :show, badword))
      {:error, changeset} ->
        render(conn, "edit.html", badword: badword, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    badword = Repo.get!(Badword, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(badword)

    conn
    |> put_flash(:info, "Badword deleted successfully.")
    |> redirect(to: badword_path(conn, :index))
  end
end
