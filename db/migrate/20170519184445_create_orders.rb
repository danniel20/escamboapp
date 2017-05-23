class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :ad, index: true, foreign_key: true
      t.integer :status, default: 0
      #t.references :buyer, index: true, foreign_key: true
      t.integer :buyer_id, index: true

      t.timestamps null: false
    end

    add_foreign_key :orders, :members, column: :buyer_id, primary_key: "id"
  end
end
