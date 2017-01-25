class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.integer :author_id
      t.string :publication_status
      t.integer :current_revision_id

      t.timestamps
    end
  end
end
