class RestrictMovieDeletionOnBookmarks < ActiveRecord::Migration[8.1]
  def up
    remove_foreign_key :bookmarks, :movies
    add_foreign_key :bookmarks, :movies
  end

  def down
    remove_foreign_key :bookmarks, :movies
    add_foreign_key :bookmarks, :movies, on_delete: :cascade
  end
end
