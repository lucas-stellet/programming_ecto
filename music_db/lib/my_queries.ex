defmodule MusicDB.MyQueries do
  import Ecto.Query

  def albums_by_artist(artist_name) do
    from(a in "albums",
      join: ar in "artists",
      on: ar.id == a.artist_id,
      where: ar.name == ^artist_name
    )
  end

  def with_tracks_longer_than(query, duration) do
    from(a in query,
      join: t in "tracks",
      on: t.album_id == a.id,
      where: t.duration > ^duration,
      distinct: true
    )
  end

  def by_artist(query, artist_name) do
    from(a in query,
      join: ar in "artists",
      on: a.artist_id == ar.id,
      where: ar.name == ^artist_name
    )
  end

  def title_only(query) do
    from(a in query, select: a.title)
  end
end
