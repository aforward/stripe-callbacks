defmodule StripeCallbacks.TokenTest do
  use ExUnit.Case, async: true

  alias StripeCallbacks.{Token,Repo}
  doctest StripeCallbacks.Token

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  test "changeset with valid attributes" do
    changeset = Token.changeset(%Token{}, %{})
    assert changeset.valid?
  end

  test "store" do
    {:ok, token} = Token.store(%{a: 1}, "processed")
    assert token.data == %{a: 1}
    assert token.token_status == "processed"
  end

  test "store (default status)" do
    {:ok, token} = Token.store(%{a: 2})
    assert token.data == %{a: 2}
    assert token.token_status == "pending"
  end

end

