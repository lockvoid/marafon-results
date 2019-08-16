class CreateMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :members do |t|
      t.string :chronotrack_id
      t.string :chronotrack_tag
      t.string :chronotrack_bib
      t.string :chronotrack_event_id
      t.string :name

      t.timestamps
    end

    add_index :members, :chronotrack_id
    add_index :members, :chronotrack_event_id
    add_index :members, :chronotrack_tag
    add_index :members, :chronotrack_bib
  end
end
