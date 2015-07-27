defmodule Ticketee.ProjectController do
  use Ticketee.Web, :controller
  alias Ticketee.Project

  plug :scrub_params, "project" when action in [:create, :update]
  plug :load_project when action in [:edit, :update, :show, :delete]

  def index(conn, _) do
    projects = Repo.all(Project)
    render conn, :index, projects: projects
  end

  def new(conn, _) do
    changeset = Project.changeset(%Project{})
    render conn, :new, changeset: changeset
  end

  def create(conn, %{"project" => project_params}) do
    changeset = Project.changeset(%Project{}, project_params)
    case Repo.insert(changeset) do
      {:ok, project} ->
        conn
        |> put_flash(:info, "Project created successfully.")
        |> redirect to: project_path(conn, :show, project)
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Project could not be created.")
        |> render :new, changeset: changeset
    end
  end

  def show(conn, _) do
    tickets = Repo.all assoc(conn.assigns[:project], :tickets)
    render conn, :show, tickets: tickets
  end

  def edit(conn, _) do
    changeset = Project.changeset(conn.assigns[:project])
    render conn, :edit, changeset: changeset
  end

  def update(conn, %{"project" => project_params}) do
    changeset = Project.changeset(conn.assigns[:project], project_params)
    case Repo.update(changeset) do
      {:ok, project} ->
        conn
        |> put_flash(:info, "Project updated successfully.")
        |> redirect to: project_path(conn, :show, project)
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Project could not be updated.")
        |> render :edit, changeset: changeset
    end
  end

  def delete(conn, _) do
    case Repo.delete(conn.assigns[:project]) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Project deleted successfully.")
        |> redirect to: project_path(conn, :index)
      {:error, project} ->
        conn
        |> put_flash(:error, "Project could not be deleted.")
        |> redirect to: project_path(conn, :show, project)
    end
  end

  defp load_project(conn, _) do
    case Repo.get(Project, conn.params["id"]) do
      nil ->
        conn
        |> put_flash(:error, "The project you were looking for could not be found.")
        |> redirect(to: project_path(conn, :index))
        |> halt
      project ->
        assign(conn, :project, project)
    end
  end
end
