class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.json :campaigns_list

      t.timestamps
    end

    add_index :users, :name
    add_index :users, :email, unique: true

    # Add generated columns for indexing
    execute <<-SQL
      ALTER TABLE users
      ADD generated_campaign_name VARCHAR(255) GENERATED ALWAYS AS (JSON_UNQUOTE(JSON_EXTRACT(campaigns_list, '$[0].campaign_name'))) STORED;
    SQL

    add_index :users, :generated_campaign_name, type: :fulltext
  end
end
