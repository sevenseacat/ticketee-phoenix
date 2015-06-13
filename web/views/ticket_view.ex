defmodule Ticketee.TicketView do
  use Ticketee.Web, :view

  def page_title(:show, assigns), do: "#{assigns[:ticket].title} | #{assigns[:project].title}"
  def page_title(action, assigns) when action in [:new, :create], do: "Create Ticket | #{assigns[:project].title}"
  def page_title(action, assigns) when action in [:edit, :update], do: "Edit Ticket | #{assigns[:project].title}"
  def page_title(_, _),           do: "Tickets"

  def submit_label(model) do
    case model.id do
      nil -> "Create Ticket"
      _   -> "Update Ticket"
    end
  end
end
