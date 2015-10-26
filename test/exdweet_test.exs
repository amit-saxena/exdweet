defmodule ExDweetTest do
  use ExUnit.Case

  setup_all do
    {:ok, _} = ExDweet.start
    :ok
  end

  test "publish dweet - Default" do
    assert_result ExDweet.dweet "ExDweet_TestThing",%{:key1 => "value1", :key2 => "value2", :key3 => "value3"}
  end

  test "publish dweet - On http" do
    assert_result ExDweet.dweet "ExDweet_TestThing",%{:key1 => "value1", :key2 => "value2", :key3 => "value3"},
                      :default, :post, :http
  end

  test "publish dweet - Publish JSON values" do
    {:ok, result} = ExDweet.dweet "ExDweet_TestThing","\{ \"key1\":\"value1\", \"key2\":\"value2\", \"key3\":\"value3\"\}",
                      :json, :post
    assert is_binary result
  end

  test "publish dweet - Publish JSON values via query string" do
    {:error, reason} = ExDweet.dweet "ExDweet_TestThing","\{ \"key1\":\"value1\", \"key2\":\"value2\", \"key3\":\"value3\"\}",
                      :json, :query
    assert is_binary reason
  end

  test "get dweet - Default" do
    assert_result ExDweet.get "ExDweet_TestThing"
  end

  test "get dweet - Return all dweet " do
    assert_result ExDweet.get "ExDweet_TestThing", :all
  end

  test "get dweet - Return data in JSON " do
    {:ok, result} = ExDweet.get "ExDweet_TestThing", :latest, :json
    assert is_binary result
  end

  defp assert_result({:ok, result}) do
    assert is_map result
    assert result["this"] == "succeeded"
  end
end
