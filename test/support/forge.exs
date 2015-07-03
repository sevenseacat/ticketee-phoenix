defmodule Forge do
  use Blacksmith

  @save_one_function &Forge.save/2
  @save_all_function &Forge.save_all/2

  register :project, __struct__: Ticketee.Project, title: "Example Project"
  register :ticket,  __struct__: Ticketee.Ticket, title: "Example Ticket",
    description: "A sample description", project_id: nil

  def save(repo, map) do
    repo.insert!(map)
  end

  def save_all(repo, list) do
    Enum.map(list, &repo.insert!/1)
  end
end
