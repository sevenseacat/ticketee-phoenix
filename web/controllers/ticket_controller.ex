defmodule Ticketee.TicketController do
  use Ticketee.Web, :controller
  alias Ticketee.Ticket

  plug :scrub_params, "ticket" when action in [:create, :update]
  plug :load_project when action in [:new, :create]
  plug :load_ticket when action in [:show, :edit, :update, :delete]
  plug :action

  def new(conn, _) do
    changeset = Ticket.changeset(%Ticket{})
    render conn, :new, changeset: changeset
  end

  def create(conn, %{"project_id" => project_id, "ticket" => ticket_params}) do
    changeset = Ticket.changeset(%Ticket{}, Map.merge(ticket_params, %{"project_id" => project_id}))
    if changeset.valid? do
      Repo.insert(changeset)
      conn  |> put_flash(:info, "Ticket created successfully.")
            |> redirect to: project_path(conn, :show, conn.assigns[:project])
    else
      render conn, :new, changeset: changeset
    end
  end

  def show(conn, _) do
    project = Repo.one! assoc(conn.assigns[:ticket], :project)
    render conn, :show, project: project
  end

  def edit(conn, _) do
    changeset = Ticket.changeset(conn.assigns[:ticket])
    project = Repo.one! assoc(conn.assigns[:ticket], :project)
    render conn, :edit, changeset: changeset, project: project
  end

  def update(conn, %{"ticket" => ticket_params}) do
    changeset = Ticket.changeset(conn.assigns[:ticket], ticket_params)
    if changeset.valid? do
      Repo.update(changeset)
      conn  |> put_flash(:info, "Ticket updated successfully.")
            |> redirect to: project_path(conn, :show, conn.assigns[:ticket].project_id)
    else
      render conn, :edit, changeset: changeset
    end
  end

  def delete(conn, _) do
    Repo.delete conn.assigns[:ticket]
    conn  |> put_flash(:info, "Ticket deleted successfully.")
          |> redirect to: project_path(conn, :show, conn.assigns[:ticket].project_id)
  end

  defp load_project(conn, _) do
    case Repo.get(Ticketee.Project, conn.params["project_id"]) do
      nil ->
        conn  |> put_flash(:error, "The project you were looking for could not be found.")
              |> redirect(to: project_path(conn, :index))   |> halt
      project ->
        assign(conn, :project, project)
    end
  end

  defp load_ticket(conn, _) do
    case Repo.get(Ticket, conn.params["id"]) do
      nil ->
        conn  |> put_flash(:error, "The ticket you were looking for could not be found.")
              |> redirect(to: project_path(conn, :index))   |> halt
      ticket ->
        assign(conn, :ticket, ticket)
    end
  end
end
