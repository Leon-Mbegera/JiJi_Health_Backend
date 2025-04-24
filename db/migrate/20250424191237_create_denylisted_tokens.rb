class CreateDenylistedTokens < ActiveRecord::Migration[8.0]
  def change
    create_table :denylisted_tokens do |t|
      t.string :token

      t.timestamps
    end
    add_index :denylisted_tokens, :token
  end
end
