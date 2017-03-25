defmodule StripeCallbacks.Repo.Migrations.AddResponses do
  use Ecto.Migration

  def change do
    create table(:responses) do
      add :data, :map
      add :response_status, :string
      add :status_code, :integer
      add :token_id, references(:tokens)
      timestamps()
    end
  end
end
