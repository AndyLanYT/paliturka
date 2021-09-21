class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.references :user, foreign_key: { on_delete: :cascade }, null: false
      t.references :post, foreign_key: { on_delete: :cascade }, null: false

      t.timestamps
    end
  end
end
