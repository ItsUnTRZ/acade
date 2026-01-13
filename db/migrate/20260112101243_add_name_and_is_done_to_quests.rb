class AddNameAndIsDoneToQuests < ActiveRecord::Migration[8.1]
  def change
    add_column :quests, :name, :string
    add_column :quests, :is_done, :boolean, default: false, null: false
  end
end
