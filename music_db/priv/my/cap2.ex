# query written using keyword syntax
q = from t in "tracks",
  join: a in "albums", on: t.album_id == a.id,
  where: t.duration > 900,
  select: [a.title, t.id, t.title]


# query written using macro syntax
q = "tracks"
|> join(:inner, [t], a in "albums", on: t.album_id == a.id)
|> where([t, a], t.duration > 900)
|> select([t, a], [t.id, t.title, a.title])


query = from "artists", select: [:name]

# Sectin --> Refining Our Results with where
q = from "artists",
 where: [name: "Bill Evans"],
 select: [:id, :name]

 # name from user input
 q = from a in "artists",
 where: a.name == ^artist_name,
 select: [:id, :name]

 # Sectin --> Dynamic Values and Their Types
artist_id = 1
q = from "artists", where: [id: ^artist_id], select: [:name]

artist_id = "1"
q = from "artists", where: [id: type(^artist_id, :integer)], select: [:name]

# Sectin --> Query Bindings

q = from "artists", # --> wrong way
 where: name == "Bill Evans",
 select: [:id, :name]

q = from a in "artists", # --> right way
where: a.name == "Bill Evans",
select: [:id, :name]

# Sectin --> Query Expressions

# like statemtns

q = from a in "artists", where: like(a.name, "Miles%"), select: [:id, :name]

# checking for null
q = from a in "artists", where: is_nil(a.name), select: [:id, :name]

# checking for not null
q = from a in "artists", where: not is_nil(a.name), select: [:id, :name]

# date comparison - this finds artists added more than 1 year ago
q = from a in "artists", where: a.inserted_at < ago(1, "year"), select: [:id, :name]

# Sectin --> Ordering and Grouping

q = from a in "artists", select: [a.name], order_by: a.name # order by default in ascending

q = from a in "artists", select: [a.name], order_by: [desc: a.name] # order in desc

q = from t in "tracks", select: [t.album_id, t.title, t.index], order_by: [t.album_id, t.index]

q = from t in "tracks", select: [t.album_id, sum(t.duration)], group_by: t.album_id

q = from t in "tracks", select: [t.album_id, sum(t.duration)], group_by: t.album_id, having: sum(t.duration) > 3600 # 'having' expression

# Section -->  Working with Joins

q = from t in "tracks",
  join: a in "albums",
  on: t.album_id == a.id,
  where: t.duration > 900,
  select: %{album: a.title, track: t.title}

q = from t in "tracks",
    join: a in "albums",
    on: t.album_id == a.id,
    join: ar in "artists",
    on: a.artist_id == ar.id,
    where: t.duration > 900,
    select: %{album: a.title, track: t.title, artist: ar.name}

# Section --> Composing Queries [pagina 32 no livro]
