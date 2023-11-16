USE video_sharing;
//c)
// 7. Permitir a pesquisa de todos os vídeos de determinado autor;
SELECT * FROM video
WHERE author='schiese0';

// 8. Permitir a pesquisa de comentários por utilizador, ordenado inversamente pela data;
SELECT * FROM comment_by_user
WHERE author='cpond9'
ORDER BY timestamp DESC;

// 9. Permitir a pesquisa de comentários por vídeos, ordenado inversamente pela data;
SELECT * FROM comment
WHERE video_name='Superheroes'
ORDER BY timestamp DESC;

// 10. Permitir a pesquisa do rating médio de um vídeo e quantas vezes foi votado;
SELECT avg(value) AS average_rating, count(*) AS num_votes
FROM rating
WHERE video_name='Superheroes';

//d)

// 1. Os últimos 3 comentários introduzidos para um vídeo;
SELECT * FROM comment
WHERE video_name='Superheroes'
ORDER BY timestamp DESC
LIMIT 3;

// 2. Lista das tags de determinado vídeo;
SELECT tags FROM video_by_name
WHERE name='Superheroes';

//3. Todos os vídeos com a tag Aveiro;
// A non-frozen collection (like a list) cannot be a primary key (and we need to specify the partition key in the query), so the only way that it could be possible is by copying it to a temporary table with a frozen list (if that exists)

// 4. Os últimos 5 eventos de determinado vídeo realizados por um utilizador;
SELECT * FROM event
WHERE username='cpond9'
AND video_name='Superheroes'
ORDER BY timestamp DESC
LIMIT 5;

// 5. Vídeos partilhados por determinado utilizador (maria1987, por exemplo) num determinado período de tempo (Agosto de 2017, por exemplo);
// It is possible, but requires ALLOW FILTERING
SELECT * FROM video
WHERE author='schiese0'
AND upload_date>='2010-01-01 00:00:00+0200'
AND upload_date<='2023-12-31 23:59:59+0200'
ALLOW FILTERING;

// 6. Os últimos 10 vídeos, ordenado inversamente pela data da partilhada;
// Impossible, because, while we can retrieve all records of a table, we can't order without specifying a partition key

// 7. Todos os seguidores (followers) de determinado vídeo;
SELECT followers FROM follower
WHERE video_name='Superheroes';

// 8. Todos os comentários (dos vídeos) que determinado utilizador está a seguir (following);
// We can't do it as-is, but it is possible if we associate followers to users instead and use multiple queries
SELECT videos FROM user_following WHERE username='cpond9';
//For each element in the returned list:
SELECT * FROM comment WHERE video_name='Superheroes';

// 9. Os 5 vídeos com maior rating;
// it's not possible (unless we create a temporary table, but, at that point, it's prefereable to order in the client side), because we can't order by aggregates

// 10. Uma query que retorne todos os vídeos e que mostre claramente a forma pela qual estão ordenados;
// Unless I missed something, we can't just add fields during the SELECT, so it's impossible

// 11. Lista com as Tags existentes e o número de vídeos catalogados com cada uma delas;
// This is impossible without altering the current schema by using a "tag" table
CREATE TABLE tag(
    tag text,
    movies int
);

// 12. Get the max, min and average and number of ratings of every (rated) video
SELECT video_name, count(*) AS total_ratings, min(value) AS worst_rating,avg(value) as average_rating, max(value) AS best_rating
FROM rating
GROUP BY video_name;
/*
Results:
[
  {
    "video_name": "Frenchmen (Le coeur des hommes)",
    "total_ratings": 3,
    "worst_rating": 2,
    "average_rating": 3,
    "best_rating": 5
  },
  {
    "video_name": "Superheroes",
    "total_ratings": 4,
    "worst_rating": 2,
    "average_rating": 3,
    "best_rating": 5
  },
  {
    "video_name": "Around the World",
    "total_ratings": 4,
    "worst_rating": 1,
    "average_rating": 2,
    "best_rating": 4
  }
]
 */

// For each video, for each user, count the number of events
SELECT video_name,username,count(event_name) AS num_events FROM event
GROUP BY video_name,username;
/*
 [
  {
    "video_name": "Around the World",
    "username": "mgrunbaum8",
    "num_events": 3
  },
  {
    "video_name": "Frenchmen (Le coeur des hommes)",
    "username": "mnicklinsong",
    "num_events": 1
  },
  {
    "video_name": "Around the World",
    "username": "mnicklinsong",
    "num_events": 2
  },
  {
    "video_name": "Around the World",
    "username": "cpond9",
    "num_events": 1
  },
  {
    "video_name": "Superheroes",
    "username": "mnicklinsong",
    "num_events": 3
  },
  {
    "video_name": "Frenchmen (Le coeur des hommes)",
    "username": "cpond9",
    "num_events": 3
  },
  {
    "video_name": "Superheroes",
    "username": "cpond9",
    "num_events": 2
  },
  {
    "video_name": "Frenchmen (Le coeur des hommes)",
    "username": "mgrunbaum8",
    "num_events": 3
  },
  {
    "video_name": "Superheroes",
    "username": "mgrunbaum8",
    "num_events": 2
  }
]
 */

