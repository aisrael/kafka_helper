# KafkaHelper

A thin, but opinionated wrapper around [KafkaEx](https://github.com/kafkaex/kafka_ex) and [MsgPax](https://github.com/lexmag/msgpax) (via [msgpax_helper](https://github.com/aisrael/msgpax_helper)).

## Installation

Until this library is published [in Hex](https://hex.pm/docs/publish), you can install it from Github by adding `kafka_helper` to your list of dependencies in `mix.exs` as follows:

```elixir
def deps do
  [
    {:kafka_helper, github: "aisrael/kafka_helper"}
  ]
end
```

## Usage

To use this library, simply call `Kafka.publish(data, topic, key)`. This will pack the value of `data` using `MessagePack` (a wrapper around `MsgPax` that can supports Elixir `Date` and `NaiveDateTime`), then craft the `KafkaEx.Protocol.Produce.Request` with a single `KafkaEx.Protocol.Produce.Message` and send that to `KafkaEx.produce/2`

(With `Logging` set to `:debug`:)

```
iex> Kafka.publish("data", "test")
[debug] Elixir.Kafka.send([164 | "data"], "test", nil)
[debug] KafkaEx.produce(%KafkaEx.Protocol.Produce.Request{compression: :none, messages: [%KafkaEx.Protocol.Produce.Message{key: nil, value: [164 | "data"]}], partition: nil, required_acks: 0, timeout: 0, topic: "test"})
[debug] KafkaEx.produce(request) returned :ok
:ok

iex> Kafka.publish("data", "test", "key")
[debug] Elixir.Kafka.send([164 | "data"], "test", "key")
[debug] KafkaEx.produce(%KafkaEx.Protocol.Produce.Request{compression: :none, messages: [%KafkaEx.Protocol.Produce.Message{key: "key", value: [164 | "data"]}], partition: nil, required_acks: 0, timeout: 0, topic: "test"})
[debug] KafkaEx.produce(request) returned :ok
:ok
```
