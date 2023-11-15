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
