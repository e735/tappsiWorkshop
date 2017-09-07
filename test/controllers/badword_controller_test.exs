defmodule Workshop.BadwordControllerTest do
  use Workshop.ConnCase

  alias Workshop.Badword
  @valid_attrs %{palabra: "some palabra"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, badword_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing badwords"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, badword_path(conn, :new)
    assert html_response(conn, 200) =~ "New badword"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, badword_path(conn, :create), badword: @valid_attrs
    badword = Repo.get_by!(Badword, @valid_attrs)
    assert redirected_to(conn) == badword_path(conn, :show, badword.id)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, badword_path(conn, :create), badword: @invalid_attrs
    assert html_response(conn, 200) =~ "New badword"
  end

  test "shows chosen resource", %{conn: conn} do
    badword = Repo.insert! %Badword{}
    conn = get conn, badword_path(conn, :show, badword)
    assert html_response(conn, 200) =~ "Show badword"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, badword_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    badword = Repo.insert! %Badword{}
    conn = get conn, badword_path(conn, :edit, badword)
    assert html_response(conn, 200) =~ "Edit badword"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    badword = Repo.insert! %Badword{}
    conn = put conn, badword_path(conn, :update, badword), badword: @valid_attrs
    assert redirected_to(conn) == badword_path(conn, :show, badword)
    assert Repo.get_by(Badword, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    badword = Repo.insert! %Badword{}
    conn = put conn, badword_path(conn, :update, badword), badword: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit badword"
  end

  test "deletes chosen resource", %{conn: conn} do
    badword = Repo.insert! %Badword{}
    conn = delete conn, badword_path(conn, :delete, badword)
    assert redirected_to(conn) == badword_path(conn, :index)
    refute Repo.get(Badword, badword.id)
  end
end
