defmodule Ticketee.ProjectController do
  use Ticketee.Web, :controller
  alias Ticketee.Project

  plug :scrub_params, "project" when action in [:create, :update]
  plug :load_project when action in [:edit, :update, :show, :destroy]
  plug :action

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
    if changeset.valid? do
      id = Repo.insert(changeset)
      conn  |> put_flash(:info, "Project created successfully.")
            |> redirect to: project_path(conn, :show, id)
    else
      render conn, :new, changeset: changeset
    end
  end

  def show(conn, _) do
    render conn, :show
  end

  def edit(conn, %{"id" => id}) do
    changeset = Project.changeset(conn.assigns[:project])
    render conn, :edit, changeset: changeset
  end

  def update(conn, %{"id" => id, "project" => project_params}) do
    changeset = Project.changeset(conn.assigns[:project], project_params)
    if changeset.valid? do
      Repo.update(changeset)
      conn  |> put_flash(:info, "Project updated succesfully.")
            |> redirect to: project_path(conn, :show, conn.assigns[:project])
    else
      render conn, :edit, changeset: changeset
    end
  end

  def delete(conn, _) do
    Repo.delete(conn.assigns[:project])
    conn  |> put_flash(:info, "Project deleted successfully")
          |> redirect to: project_path(conn, :index)
  end

  defp load_project(conn, _) do
    case Repo.get(Project, conn.params["id"]) do
      nil ->
        conn  |> put_flash(:error, "The project you were looking for could not be found.")
              |> redirect(to: project_path(conn, :index))   |> halt
      project ->
        assign(conn, :project, project)
    end
  end
end
