class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :genre
      t.string :author
      t.string :comment

      t.timestamps
    end
  end
end
