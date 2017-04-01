defmodule StripeCallbacks.Token do
  use Ecto.Schema
  import Ecto.Changeset

  alias StripeCallbacks.{Token,Response,Repo}

  @derive {Poison.Encoder, only: [:data, :token_status]}
  schema "tokens" do
    field :data, :map
    field :token_status, :string
    timestamps()
  end

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, [:data, :token_status])
  end

  def process(data) do
    data
    |> create
    |> post_to_api
    |> analyze_response
  end

  def update(token, token_status) do
    token
    |> changeset(%{token_status: token_status})
    |> Repo.update
  end

  def create(data), do: create(data, "pending")
  def create(data, token_status) do
    %Token{}
    |> Token.changeset(%{data: data, token_status: token_status})
    |> Repo.insert
  end

  def post_to_api({:ok, %Token{data: %{"stripe" => stripe, "invoice" => invoice}} = token}) do
    data = %{
      amount: invoice["amount"],
      currency: invoice["currency"],
      description: invoice["description"],
      source: stripe["id"],
    }

    {_, response} = case StripePost.charge(data) do
      {:error, {k, v}} ->
        Response.create(token, %{reason: "{#{k}, #{v}}"}, :error)
      {:error, reason} ->
        Response.create(token, %{reason: reason}, :error)
      {status_code, body} ->
        Response.create(token, body, status_code)
    end
    {token, response}
  end
  def post_to_api(resp), do: resp

  defp analyze_response({token, %Response{status_code: 200}}), do: update(token, "processed")
  defp analyze_response({token, %Response{status_code: -1}}), do: update(token, "error")
  defp analyze_response({token, %Response{status_code: _status}}), do: update(token, "invalid")
  defp analyze_response(resp), do: resp


end
