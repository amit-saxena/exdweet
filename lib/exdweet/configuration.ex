defmodule ExDweet.Configuration do
  @moduledoc false
  defmacro url_dweet do
    "://dweet.io/dweet/for/"
  end
  defmacro url_latest do
    "://dweet.io/get/latest/dweet/for/"
  end
  defmacro url_all do
    "://dweet.io/get/dweets/for/"
  end
end
