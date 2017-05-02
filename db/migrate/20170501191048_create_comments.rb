class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.belongs_to :user
      t.belongs_to :ad
      t.belongs_to :event
      t.text :comment
    end
  end
end
