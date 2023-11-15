USE video_sharing;

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
