class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.integer :author_id
      t.boolean :publication_status
      t.integer :cuurent_revision_id

      t.timestamps
    end
  end
end
