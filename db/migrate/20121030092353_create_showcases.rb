class CreateShowcases < ActiveRecord::Migration
  def change
    create_table :showcases do |t|
      t.string :title
      t.text :description
      t.string :state

      t.timestamps
    end
  end
end
