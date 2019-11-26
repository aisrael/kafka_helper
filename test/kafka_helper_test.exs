defmodule UsesKafkaHelper do
  def send_foo do
    kafka_helper = Application.get_env(:my_app, :kafka_helper)
    kafka_helper.publish(%{foo: "bar"}, "test-topic", nil)
  end
end

defmodule KafkaHelperTest do
  use ExUnit.Case
  doctest KafkaHelper

  setup do
    # Can also be placed in test_helper.exs
    Mox.defmock(MockKafkaHelper, for: KafkaHelper)
    Application.put_env(:my_app, :kafka_helper, MockKafkaHelper)
    Mox.verify_on_exit!()
    :ok
  end

  test "it can be mocked" do
    import Mox

    MockKafkaHelper
    |> expect(:publish, fn data, topic, _key when is_map(data) ->
      assert %{foo: foo} = data
      assert foo == "bar"
      assert topic == "test-topic"
    end)

    UsesKafkaHelper.send_foo()
  end
end
