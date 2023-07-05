class ChangeUserIdToUuid < ActiveRecord::Migration[7.0]
    def up
      # Add UUID columns
      add_column :users,    :uuid, :uuid, null: false, default: -> { "gen_random_uuid()" }
      # add_column :comments, :uuid, :uuid, null: false, default: -> { "gen_random_uuid()" }

      # Add UUID columns for associations
      # add_column :comments, :user_uuid, :uuid

      # Populate UUID columns for associations
      # execute <<-SQL
      #   UPDATE comments SET user_uuid = users.uuid
      #   FROM users WHERE comments.user_id = users.id;
      # SQL

      # Change null
      # change_column_null :comments, :user_uuid, false

      # Migrate UUID to ID for associations
      # remove_column :comments, :user_id
      # rename_column :comments, :user_uuid, :user_id

      # Add indexes for associations
      # add_index :comments, :user_id

      # Add foreign keys
      # add_foreign_key :comments, :users

      # Migrate primary keys from UUIDs to IDs
      remove_column :users,    :id
      # remove_column :comments, :id
      rename_column :users,    :uuid, :id
      # rename_column :comments, :uuid, :id
      execute "ALTER TABLE users    ADD PRIMARY KEY (id);"
      # execute "ALTER TABLE comments ADD PRIMARY KEY (id);"

      # Add indexes for ordering by date
      add_index :users,    :created_at
      # add_index :comments, :created_at
    end

    def down
      raise ActiveRecord::IrreversibleMigration
    end
  end

  #change id to uuid = create new column uuid ==> delete column id ==> rename uuid to id
  # A possible way to migrate these tables to UUIDs is:
  #   Add UUID columns to tables
  #   Migrate associations
  #   Drop ID columns, rename UUID to ID and use them as primary keys

  # run before db:migarte
  # sudo -u postgres psql
  # \l
  # \c database_name
  # CREATE EXTENSION IF NOT EXISTS pgcrypto;
  # CREATE EXTENSION "uuid-ossp"


