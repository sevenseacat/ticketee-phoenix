defmodule Ticketee.ProjectControllerTest do
  use Ticketee.ConnCase

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "handles a missing project correctly", %{conn: conn} do
    conn = get conn, project_path(conn, :show, -1)
    assert redirected_to(conn) == project_path(conn, :index)
    assert get_flash(conn, :error) == "The project you were looking for could not be found."
  end
end
