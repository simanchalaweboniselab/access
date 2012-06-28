class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :token, :null => false
      t.string :username

      t.timestamps
    end
  end
end
