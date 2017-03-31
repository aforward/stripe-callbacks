defmodule StripeCallbacks do
  @moduledoc """
  A projec to store Stripe tokens (StripeCallbacks.Token)
  generated from your client code (i.e. browser talking
  direclty to Stripe), as well as the callbacks (aka
  StripeCallbacks.Response) when applying those
  """

  @doc """
    Process data returned from the client, it should contain the
    stripe response, as well information related to the charge
    (aka invoice) you sent to stripe.

  ## Examples

      iex> StripeCallbacks.process(%{
      ...>    "stripe" => %{"id" => "“pk_abc_123”"},
      ...>    "invoice" => %{
      ...>      "amount" => 2000,
      ...>      "currency" => "cad",
      ...>      "description" => "3 wozzle”"}})
      ...> |> elem(0)
      :ok
  """
  defdelegate process(data), to: StripeCallbacks.Worker

end
