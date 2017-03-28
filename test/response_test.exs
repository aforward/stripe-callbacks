defmodule StripeCallbacks.ResponseTest do
  use ExUnit.Case, async: true

  alias StripeCallbacks.{Response,Token,Repo}
  doctest StripeCallbacks.Response

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  test "changeset with valid attributes" do
    changeset = Response.changeset(%Response{}, %{})
    assert changeset.valid?
  end

  test "create (200)" do
    {:ok, token} = Token.create(%{b: 2})
    {:ok, response} = Response.create(token, %{a: 1}, 200)
    assert response.data == %{a: 1}
    assert response.response_status == "success"
    assert response.token_id == token.id
    assert response.status_code == 200
  end

  test "create (not 200)" do
    {:ok, token} = Token.create(%{b: 2})
    {:ok, response} = Response.create(token, %{a: 2}, 355)
    assert response.data == %{a: 2}
    assert response.response_status == "failure"
    assert response.token_id == token.id
    assert response.status_code == 355
  end

  test "create (error)" do
    {:ok, token} = Token.create(%{b: 2})
    {:ok, response} = Response.create(token, %{a: 2}, :error)
    assert response.data == %{a: 2}
    assert response.response_status == "error"
    assert response.token_id == token.id
    assert response.status_code == -1
  end

end