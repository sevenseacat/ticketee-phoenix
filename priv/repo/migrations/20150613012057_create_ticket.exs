defmodule Ticketee.Repo.Migrations.CreateTicket do
  use Ecto.Migration

  def change do
    create table(:tickets) do
      add :title, :string
      add :description, :text
      add :project_id, :integer

      timestamps
    end

  end
end
