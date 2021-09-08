class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :body
      t.references :user, foreign_key: { on_delete: :cascade }, null: false
      t.references :post, foreign_key: { on_delete: :cascade }, null: false

      t.timestamps
    end
  end
end
