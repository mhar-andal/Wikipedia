class CreateRevisions < ActiveRecord::Migration[5.0]
  def change
    create_table :revisions do |t|
      t.string :title
      t.text :paragraph
      t.string :image_url
      t.boolean :publication_status, default: :false
      t.references :revisionable, polymorphic: true

      t.timestamps
    end
  end
end
