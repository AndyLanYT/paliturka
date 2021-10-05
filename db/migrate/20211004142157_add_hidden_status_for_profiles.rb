class AddHiddenStatusForProfiles < ActiveRecord::Migration[6.1]
  def change
    add_column :profiles, :hidden, :boolean, default: false
  end
end
