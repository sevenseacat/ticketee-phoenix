defmodule Ticketee.TicketController do
  use Ticketee.Web, :controller
  alias Ticketee.Ticket

  plug :scrub_params, "ticket" when action in [:create, :update]
  plug :load_project when action in [:new, :create]
  plug :load_ticket when action in [:show, :edit, :update, :delete]

  def new(conn, _) do
    changeset = Ticket.changeset(%Ticket{})
    render conn, :new, changeset: changeset
  end

  def create(conn, %{"project_id" => project_id, "ticket" => ticket_params}) do
    changeset = Ticket.changeset(%Ticket{}, Map.merge(ticket_params, %{"project_id" => project_id}))
    case Repo.insert(changeset) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Ticket created successfully.")
        |> redirect to: project_path(conn, :show, conn.assigns[:project])
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Ticket could not be created.")
        |> render :new, changeset: changeset
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
    case Repo.update(changeset) do
      {:ok, ticket} ->
        conn
        |> put_flash(:info, "Ticket updated successfully.")
        |> redirect to: ticket_path(conn, :show, ticket)
      {:error, changeset} ->
        project = Repo.one! assoc(conn.assigns[:ticket], :project)
        conn
        |> put_flash(:error, "Ticket could not be updated.")
        |> render :edit, changeset: changeset, project: project
    end
  end

  def delete(conn, _) do
    case Repo.delete(conn.assigns[:ticket]) do
      {:ok, ticket} ->
        conn
        |> put_flash(:info, "Ticket deleted successfully.")
        |> redirect to: project_path(conn, :show, ticket.project_id)
      {:error, ticket} ->
        conn
        |> put_flash(:error, "Ticket could not be deleted.")
        |> redirect to: ticket_path(conn, :show, ticket)
    end
  end

  defp load_project(conn, _) do
    case Repo.get(Ticketee.Project, conn.params["project_id"]) do
      nil ->
        conn
        |> put_flash(:error, "The project you were looking for could not be found.")
        |> redirect(to: project_path(conn, :index))
        |> halt
      project ->
        assign(conn, :project, project)
    end
  end

  defp load_ticket(conn, _) do
    case Repo.get(Ticket, conn.params["id"]) do
      nil ->
        conn
        |> put_flash(:error, "The ticket you were looking for could not be found.")
        |> redirect(to: project_path(conn, :index))
        |> halt
      ticket ->
        assign(conn, :ticket, ticket)
    end
  end
end
