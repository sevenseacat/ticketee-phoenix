defmodule Ticketee.FeatureCase do
  use ExUnit.CaseTemplate
  use Hound.Helpers
  #import Hound.RequestUtils

  hound_session

  using do
    quote do
      import Ticketee.FeatureCase

      # We duplicate this so we can use them both in this file, and in the files we use this FeatureCase in
      use Hound.Helpers

      # To make routing helpers available to tests
      import Ticketee.Router.Helpers
      use Phoenix.ConnTest
    end
  end
end
