defmodule StripeCallbacks.Response do
  use Ecto.Schema
  import Ecto.Changeset

  alias StripeCallbacks.{Response,Token,Repo}

  @derive {Poison.Encoder, only: [:data, :response_status, :status_code]}
  schema "responses" do
    field :data, :map
    field :response_status, :string
    field :status_code, :integer
    belongs_to(:token, Token)
    timestamps()
  end

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, [:data, :response_status, :status_code, :token_id])
  end

  def create(token, data, 200), do: create(token, data, 200, "success")
  def create(token, data, :error), do: create(token, data, -1, "error")
  def create(token, data, status_code), do: create(token, data, status_code, "failure")
  def create(%Token{id: id}, data, status_code, response_status) do
    %Response{}
    |> Response.changeset(%{token_id: id, data: data, status_code: status_code, response_status: response_status})
    |> Repo.insert
  end

end