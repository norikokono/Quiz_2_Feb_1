class CreateJoins < ActiveRecord::Migration[6.1]
  def change
    create_table :joins do |t|
      t.references :user, foreign_key: true
      t.references :idea, foreign_key: true   
      
      t.timestamps
    end
  end
end
