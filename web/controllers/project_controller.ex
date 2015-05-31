defmodule Ticketee.ProjectController do
  use Ticketee.Web, :controller
  alias Ticketee.Project

  plug :action
  plug :scrub_params, :project when action in [:create, :update]

  def index(conn, _) do
    render conn, :index
  end

  def new(conn, _) do
    changeset = Project.changeset(%Project{})
    render conn, :new, changeset: changeset
  end

  def create(conn, %{"project" => project_params}) do
    changeset = Project.changeset(%Project{}, project_params)
    if changeset.valid? do
      id = Repo.insert(changeset)
      conn
      |> put_flash(:info, "Project created successfully.")
      |> redirect to: project_path(conn, :show, id)
    else
      render conn, :new, changeset: changeset
    end
  end

  def show(conn, %{"id" => id}) do
    project = Repo.get(Project, id)
    render conn, :show, project: project
  end
end
