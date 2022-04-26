class AddInvitedToUsers < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!
  def change
    add_column :users, :invitation_token, :string
    add_column :users, :invitation_sent_at, :datetime
    add_column :users, :invitation_accepted_at, :datetime
    add_reference :users, :invited_by, references: :users, index: {algorithm: :concurrently}
  end
end
