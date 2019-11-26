defmodule KafkaHelper do
  @moduledoc """
  Defines a behaviour with a single `publish/3` function that will be implemented
  by `KafkaHelper.Kafka` and can be mocked during tests.
  """
  @callback publish(data :: any(), topic :: String.t(), key :: String.t() | nil) ::
              :ok | {:error, any}
end
