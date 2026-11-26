class AddCascadeAndUniqueIndexToBookmarks < ActiveRecord::Migration[8.1]
  def change
    remove_foreign_key :bookmarks, :lists
    add_foreign_key :bookmarks, :lists, on_delete: :cascade

    add_index :bookmarks, [ :movie_id, :list_id ], unique: true
  end
end
