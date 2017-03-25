defmodule StripeCallbacks.Token do
  use Ecto.Schema
  import Ecto.Changeset

  alias StripeCallbacks.{Token,Repo}

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

  def create(data) do
    data
    |> store
  end

  def store(data), do: store(data, "pending")
  def store(data, token_status) do
    %Token{}
    |> Token.changeset(%{data: data, token_status: token_status})
    |> Repo.insert
  end

end
