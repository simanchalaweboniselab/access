class CreateHomes < ActiveRecord::Migration
  def change
    create_table :homes do |t|
      t.string :token, :null => false
      t.string :username

      t.timestamps
    end
  end
end
