class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
			t.references :user, null: false
			t.string :title, null: false
			t.text :content, null: false
			t.string :img
      t.timestamps
    end
  end
end
