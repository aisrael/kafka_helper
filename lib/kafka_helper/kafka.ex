defmodule Kafka do
  @moduledoc """
  Provides a thin wrapper around KafkaEx and MessagePack to pack and publish data
  to Kafka. Implements the `KafkaHelper` behaviour.
  """
  alias KafkaEx.Protocol.Produce.{Message, Request}

  require Logger

  @behaviour KafkaHelper

  @doc """
  Pack the the given data using MessagePack and publish to the given Kafka topic, with an optional key.
  """
  @spec publish(data :: any(), topic :: String.t(), key :: String.t() | nil) ::
          :ok | {:error, any}
  def publish(data, topic, key \\ nil) when is_binary(topic) do
    with {:ok, packed} <- MessagePack.pack(data) do
      send(packed, topic, key)
    end
  end

  @spec send(packed :: binary, topic :: String.t(), key :: String.t()) :: :ok | {:error, any}
  defp send(packed, topic, key) do
    Logger.debug(~s[#{__MODULE__}.send(#{inspect(packed)}, "#{topic}", #{inspect(key)})])

    message = %Message{
      key: key,
      value: packed
    }

    request = %Request{
      topic: topic,
      messages: [message]
    }

    Logger.debug("KafkaEx.produce(#{inspect(request)})")

    result = KafkaEx.produce(request)

    Logger.debug(fn ->
      case result do
        :ok -> "KafkaEx.produce(request) returned :ok"
        {:error, reason} -> "KafkaEx.produce(request) returned error: #{reason}"
      end
    end)

    result
  end
end
