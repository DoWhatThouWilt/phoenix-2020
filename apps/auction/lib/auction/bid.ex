defmodule Auction.Bid do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bids" do
    field :amount, :integer
    belongs_to :item, Auction.Item
    belongs_to :user, Auction.User
    timestamps()
  end

  def changeset(bid, params \\ %{}, high_bid \\ 0) do
    bid
    |> cast(params, [:amount, :user_id, :item_id])
    |> validate_required([:amount, :user_id, :item_id])
    |> validate_number(:amount, greater_than: high_bid, message: "Your bid must be greater than the highest bidder's.")
    |> assoc_constraint(:item)
    |> assoc_constraint(:user)
  end
end
