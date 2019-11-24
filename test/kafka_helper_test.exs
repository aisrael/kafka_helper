defmodule KafkaHelperTest do
  use ExUnit.Case
  doctest KafkaHelper

  test "greets the world" do
    assert KafkaHelper.hello() == :world
  end
end
