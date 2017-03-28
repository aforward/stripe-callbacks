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

  test "create" do
    {:ok, token} = Token.create(%{a: 1}, "processed")
    assert token.data == %{a: 1}
    assert token.token_status == "processed"
  end

  test "create (default status)" do
    {:ok, token} = Token.create(%{a: 2})
    assert token.data == %{a: 2}
    assert token.token_status == "pending"
  end

  test "update" do
    {:ok, token} = Token.create(%{a: 1})
    {:ok, updated} = Token.update(token, "error")
    assert updated.data == %{a: 1}
    assert updated.token_status == "error"
  end

end

