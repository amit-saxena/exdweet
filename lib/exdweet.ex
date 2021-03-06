defmodule ExDweet do
  @moduledoc """
  Elixir client for Dweet.io
  The ExDweet module can be used for Dweeting and Getting Dweets.

  Check feature details for currently supported features.

    iex> IexDweet.start
    iex> IexDweet.dweet "ExDweet_DemoThing",%{key1: "value1", key2: "value2",key3: "value3"}
    %{:ok,
          %{"by" => "dweeting", "the" => "dweet", "this" => "succeeded",
              "with" => %{"content" => %{"key1" => "value1", "key2" => "value2",
              "key3" => "value3"}, "created" => "2015-10-26T14:12:52.705Z",
              "thing" => "ExDweet_DemoThing"}}}

    Check dweet/5 and  get/5 for more details how to dweet and get dweet
  """
  use ExDweet.Import
end
