defmodule Ticketee.FormView do
  import Phoenix.HTML.Tag

  def error(f, field, opts \\ []) do
    if has_error(f, field) do
      content_tag :div, opts do
        content_tag :p, class: "help-block" do
          f.errors[field]
        end
      end
    end
  end

  def has_error(f, field) do
    f.errors[field]
  end
end
