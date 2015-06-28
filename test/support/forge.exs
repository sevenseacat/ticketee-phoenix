defmodule Forge do
  use Blacksmith
  alias Ticketee.Project

  @save_one_function &Forge.save/2
  @save_all_function &Forge.save_all/2

  register :project, __struct__: Project, title: "Example Project"

  def save(repo, map) do
    repo.insert!(map)
  end

  def save_all(repo, list) do
    Enum.map(list, &repo.insert!/1)
  end
end
