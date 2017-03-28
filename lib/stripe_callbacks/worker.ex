defmodule StripeCallbacks.Worker do
  use GenServer

  ### Public API

  def start_link() do
    {:ok, _pid} = GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def process(data) do
    GenServer.call(StripeCallbacks.Worker, {:process, data})
  end

  ### Server Callbacks

  def init() do
    {:ok, {}}
  end

  def handle_call({:process, data}, _from, state) do
    answer = StripeCallbacks.Token.process(data)
    {:reply, answer, state}
  end

end
