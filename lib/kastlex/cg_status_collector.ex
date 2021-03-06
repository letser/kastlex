defmodule Kastlex.CgStatusCollector do
  require Logger
  require Record
  import Record, only: [defrecord: 2, extract: 2]
  defrecord :kafka_message,
             extract(:kafka_message, from_lib: "brod/include/brod.hrl")

  @behaviour :brod_topic_subscriber

  @topic "__consumer_offsets"

  def start_link(options) do
    client = options.brod_client_id
    consumer_config = [{:begin_offset, :earliest}]
    ## start a topic subscriber which will spawn one consumer process
    ## for each partition, and subscribe to all partition consumers
    :brod_topic_subscriber.start_link(client, @topic, _partitions = :all,
                                      consumer_config, __MODULE__, nil)
  end

  def init(@topic, _) do
    {:ok, [], %{}}
  end

  def handle_message(_partition, msg, state) do
    key_bin = kafka_message(msg, :key)
    value_bin = kafka_message(msg, :value)
    {tag, key, value} = :kpro_consumer_group.decode(key_bin, value_bin)
    case tag do
      :offset -> Kastlex.CgCache.commited_offset(key, value)
      :group -> Kastlex.CgCache.new_cg_status(key, value)
    end
    {:ok, :ack, state}
  end

end

