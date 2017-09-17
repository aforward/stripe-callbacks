defmodule StripeCallbacks.Repo do
  use Ecto.Repo, otp_app: :stripe_callbacks
  use FnExpr

  def init(_, config) do
    config
    |> DeferredConfig.transform_cfg
    |> invoke({:ok, &1})
  end

end