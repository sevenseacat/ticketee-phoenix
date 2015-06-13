defmodule Ticketee.TicketController do
  use Ticketee.Web, :controller
  alias Ticketee.Ticket

  plug :scrub_params, "ticket" when action in [:create]
  plug :load_project when action in [:new, :create]
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

  def show(conn, %{"id" => id}) do
    ticket = Repo.get!(Ticket, id)
    project = Repo.one! assoc(ticket, :project)
    render conn, :show, ticket: ticket, project: project
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
end
