# frozen_string_literal: true

Sequel.migration do
  up do
    create_table :users do
      primary_key :id
      column :login, String
      column :password, String
      column :role, String
    end
  end

  down do
    alter_table :users do
      drop_column :login
      drop_column :password
      drop_column :role
    end
  end
end
