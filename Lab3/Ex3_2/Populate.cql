USE video_sharing;

//user
BEGIN BATCH
insert into user (username, email, register_date) values ('schiese0', 'abuckland0@flavors.me', '2004-07-25 21:49:02');
insert into user (username, email, register_date) values ('dcordrey1', 'sbernlin1@ifeng.com', '2000-09-13 07:18:09');
insert into user (username, email, register_date) values ('gaskham2', 'rrooms2@google.com.hk', '2018-11-10 13:42:09');
insert into user (username, email, register_date) values ('bbettanay3', 'arebichon3@google.com.br', '2003-03-26 18:30:59');
insert into user (username, email, register_date) values ('amaus4', 'wpeck4@ezinearticles.com', '2014-11-23 23:56:19');
insert into user (username, email, register_date) values ('rtatton5', 'rspilstead5@guardian.co.uk', '2000-10-06 09:35:11');
insert into user (username, email, register_date) values ('alanyon6', 'ggherardini6@imageshack.us', '2020-04-21 01:36:38');
insert into user (username, email, register_date) values ('wrussilll7', 'acleife7@addthis.com', '2000-04-05 03:50:40');
insert into user (username, email, register_date) values ('mgrunbaum8', 'zgiovannetti8@arizona.edu', '2022-03-18 17:13:07');
insert into user (username, email, register_date) values ('cpond9', 'gstonier9@yellowpages.com', '2000-02-23 15:41:05');
insert into user (username, email, register_date) values ('zsywella', 'nwindousa@soundcloud.com', '2003-06-22 23:53:14');
insert into user (username, email, register_date) values ('aburnsydeb', 'gbanhamb@china.com.cn', '2003-11-17 04:18:56');
insert into user (username, email, register_date) values ('vtustinc', 'onibleyc@usgs.gov', '2006-08-16 10:11:00');
insert into user (username, email, register_date) values ('rpreskettd', 'tmccurtind@apache.org', '2021-12-11 09:32:18');
insert into user (username, email, register_date) values ('semonse', 'aoutridgee@yale.edu', '2007-08-25 18:33:37');
insert into user (username, email, register_date) values ('cjudef', 'rganderf@exblog.jp', '2003-05-30 11:30:23');
insert into user (username, email, register_date) values ('mnicklinsong', 'tdanilovitchg@thetimes.co.uk', '2001-03-03 13:27:05');
insert into user (username, email, register_date) values ('etrevainh', 'kaubrayh@1688.com', '2020-02-29 06:11:25');
insert into user (username, email, register_date) values ('mgrindlayi', 'gtoyei@furl.net', '2003-07-27 21:43:30');
insert into user (username, email, register_date) values ('wparrotj', 'mearthfieldj@jugem.jp', '2018-01-08 10:09:08');
APPLY BATCH;

//video
BEGIN BATCH
insert into video (author, name, description, tags, upload_date, duration) values ('schiese0', 'Around the World', 'ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque ultrices phasellus id sapien in sapien', ['Crime|Thriller','Drama','Crime|Horror|Mystery','Drama|Thriller'], '2007-06-06 04:33:01', 297);
insert into video (author, name, description, tags, upload_date, duration) values ('schiese0', 'Frenchmen (Le coeur des hommes)', 'magna ac consequat metus sapien ut nunc vestibulum ante ipsum primis in faucibus', ['Drama|Romance','Comedy|Western','Action|Thriller','Adventure|Drama','Comedy','Comedy'], '2012-06-25 10:05:03', 2535);
insert into video (author, name, description, tags, upload_date, duration) values ('gaskham2', 'Superheroes', 'pede lobortis ligula sit amet eleifend pede libero quis orci nullam molestie nibh in lectus pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate luctus', ['Comedy|Drama|Musical'], '2009-10-19 14:38:50', 565);
insert into video (author, name, description, tags, upload_date, duration) values ('schiese0', 'Forever Strong', 'id justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor', ['Drama|Western','Action|Adventure|Crime|Drama|Thriller|War'], '2006-03-25 12:40:09', 2030);
insert into video (author, name, description, tags, upload_date, duration) values ('schiese0', 'Flashback', 'tellus nisi eu orci mauris lacinia sapien quis libero nullam sit amet turpis elementum ligula', ['Adventure|Animation|Comedy','Comedy'], '2003-03-23 20:21:52', 1177);
insert into video (author, name, description, tags, upload_date, duration) values ('schiese0', 'Welcome to Dongmakgol', 'vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet', ['Drama|Romance|Thriller','Drama','Horror|Sci-Fi','Comedy|Documentary','Adventure|Comedy|Fantasy'], '2002-08-17 12:09:40', 912);
insert into video (author, name, description, tags, upload_date, duration) values ('dcordrey1', 'Fletch Lives', 'donec vitae nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit ac', ['Comedy|Drama','Drama','Action|Crime','Comedy|Drama|Romance','Children|Comedy','Drama','Horror|Thriller','Action|Thriller|War','Action|Drama|War','Comedy|Horror'], '2006-01-22 05:52:38', 2336);
insert into video (author, name, description, tags, upload_date, duration) values ('dcordrey1', 'Ghost and Mrs. Muir, The', 'neque vestibulum eget vulputate ut ultrices vel augue vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices', ['Action|Drama|War','Comedy|Drama|Romance','Documentary'], '2017-06-12 18:25:35', 1555);
insert into video (author, name, description, tags, upload_date, duration) values ('gaskham2', 'Moment of Innocence, A (Nun va Goldoon)', 'ante vel ipsum praesent blandit lacinia erat vestibulum sed magna at nunc commodo placerat praesent blandit nam', ['Drama|Mystery|Thriller'], '2023-08-12 22:18:44', 1455);
insert into video (author, name, description, tags, upload_date, duration) values ('gaskham2', 'Hostile Witness', 'massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est', ['(no genres listed)'], '2022-02-25 00:19:51', 530);
insert into video (author, name, description, tags, upload_date, duration) values ('dcordrey1', 'Vampire Apocalypse', 'convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi vel lectus in quam fringilla', ['Adventure|Comedy|Drama'], '2020-08-12 19:41:20', 582);
insert into video (author, name, description, tags, upload_date, duration) values ('gaskham2', 'Mutant Action (Acción Mutante)', 'porttitor id consequat in consequat ut nulla sed accumsan felis ut at', ['Drama','Mystery|Romance|Sci-Fi','Drama|Romance','Crime|Drama|Thriller','Drama|Romance|War','Comedy|Sci-Fi','Comedy|Crime','Adventure','Documentary|Musical','Action|Crime|Musical|Romance'], '2003-10-20 13:04:22', 2954);
insert into video (author, name, description, tags, upload_date, duration) values ('gaskham2', 'Rails & Ties', 'at dolor quis odio consequat varius integer ac leo pellentesque ultrices mattis odio donec vitae nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla', ['(no genres listed)','Comedy','Documentary'], '2018-12-03 17:37:54', 2224);
insert into video (author, name, description, tags, upload_date, duration) values ('schiese0', 'Holy Girl, The (Niña santa, La)', 'ut dolor morbi vel lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa id lobortis convallis tortor', ['Comedy|Drama|Romance','Comedy','Comedy','Comedy|Drama','Drama|Romance','Drama|Musical|Romance','Drama','Horror|Thriller'], '2001-09-19 01:44:50', 1370);
insert into video (author, name, description, tags, upload_date, duration) values ('schiese0', 'Education of Charlie Banks, The', 'porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit', ['Comedy|Romance','Drama','Children|Comedy|Drama','Drama|Mystery|War','Documentary|Sci-Fi','Drama|Romance','Documentary'], '2017-11-20 06:29:01', 3244);
insert into video (author, name, description, tags, upload_date, duration) values ('schiese0', 'Skin', 'vestibulum sed magna at nunc commodo placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt', ['Action|Horror','Drama','Action|Crime|Thriller','Drama|Thriller','Drama|War','Horror','Comedy|Sci-Fi','Adventure|Comedy','Drama','Crime|Drama|Thriller'], '2019-05-20 22:20:46', 1257);
insert into video (author, name, description, tags, upload_date, duration) values ('schiese0', 'Swamp Shark', 'vestibulum eget vulputate ut ultrices vel augue vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia', ['Adventure|Drama|Romance','Action|Adventure|Drama|Romance|Thriller','Comedy|Romance','Comedy|Musical','Comedy|Musical','Action|Comedy','Drama','Drama|Mystery|Romance|Thriller','Crime|Horror|Mystery|Thriller'], '2001-02-05 05:32:40', 2721);
insert into video (author, name, description, tags, upload_date, duration) values ('gaskham2', 'Black Field', 'morbi porttitor lorem id ligula suspendisse ornare consequat lectus in est risus auctor sed tristique in', ['Drama'], '2006-09-15 18:39:27', 2706);
insert into video (author, name, description, tags, upload_date, duration) values ('gaskham2', 'Shaolin Temple 3: Martial Arts of Shaolin (Nan bei Shao Lin) (Martial Arts of Shaolin)', 'nunc rhoncus dui vel sem sed sagittis nam congue risus semper porta volutpat quam pede lobortis ligula sit amet eleifend pede libero quis', ['Drama|Thriller','(no genres listed)','Action|Sci-Fi|Thriller','Drama','Action|Animation|Comedy|Horror','Drama','Horror','Comedy|Romance','Comedy'], '2019-01-14 09:25:40', 344);
insert into video (author, name, description, tags, upload_date, duration) values ('dcordrey1', 'Girl in Progress', 'morbi a ipsum integer a nibh in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus nec molestie sed', ['Animation|Fantasy','Musical'], '2015-06-18 14:38:52', 1941);
APPLY BATCH;

//comment
BEGIN BATCH
insert into comment (video_name, author, comment, timestamp) values ('Superheroes', 'cpond9', 'sit amet nulla quisque arcu libero rutrum ac lobortis vel dapibus at diam nam tristique tortor', '2008-08-19 12:50:17');
insert into comment (video_name, author, comment, timestamp) values ('Around the World', 'mnicklinsong', 'dolor morbi vel lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet', '2023-09-24 02:15:38');
insert into comment (video_name, author, comment, timestamp) values ('Superheroes', 'mgrunbaum8', 'erat id mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy', '2001-01-16 22:28:02');
insert into comment (video_name, author, comment, timestamp) values ('Around the World', 'mgrunbaum8', 'quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum sed magna at nunc commodo placerat praesent', '2003-03-29 16:51:28');
insert into comment (video_name, author, comment, timestamp) values ('Frenchmen (Le coeur des hommes)', 'cpond9', 'tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis', '2012-01-29 01:53:34');
insert into comment (video_name, author, comment, timestamp) values ('Around the World', 'mgrunbaum8', 'quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id', '2002-12-11 01:50:25');
insert into comment (video_name, author, comment, timestamp) values ('Superheroes', 'cpond9', 'faucibus accumsan odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor', '2001-10-22 01:50:15');
insert into comment (video_name, author, comment, timestamp) values ('Superheroes', 'cpond9', 'donec dapibus duis at velit eu est congue elementum in hac habitasse platea dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum', '2003-11-06 07:01:00');
insert into comment (video_name, author, comment, timestamp) values ('Superheroes', 'cpond9', 'duis bibendum morbi non quam nec dui luctus rutrum nulla tellus in sagittis dui vel nisl duis ac', '2016-10-03 09:19:09');
insert into comment (video_name, author, comment, timestamp) values ('Superheroes', 'mgrunbaum8', 'suscipit ligula in lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus sit amet nulla quisque arcu libero', '2005-02-17 00:26:55');
insert into comment (video_name, author, comment, timestamp) values ('Superheroes', 'mnicklinsong', 'lobortis est phasellus sit amet erat nulla tempus vivamus in', '2004-11-09 10:23:31');
insert into comment (video_name, author, comment, timestamp) values ('Around the World', 'mgrunbaum8', 'nunc nisl duis bibendum felis sed interdum venenatis turpis enim blandit mi in porttitor pede justo eu massa donec dapibus duis at velit eu est congue elementum in', '2019-03-24 05:18:29');
insert into comment (video_name, author, comment, timestamp) values ('Superheroes', 'cpond9', 'feugiat non pretium quis lectus suspendisse potenti in eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa quis', '2005-02-27 01:14:38');
insert into comment (video_name, author, comment, timestamp) values ('Frenchmen (Le coeur des hommes)', 'mnicklinsong', 'turpis enim blandit mi in porttitor pede justo eu massa donec dapibus duis at velit eu est congue elementum in hac habitasse platea dictumst morbi vestibulum velit id pretium', '2016-07-26 02:32:18');
insert into comment (video_name, author, comment, timestamp) values ('Frenchmen (Le coeur des hommes)', 'cpond9', 'nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat', '2009-03-08 07:37:47');
insert into comment (video_name, author, comment, timestamp) values ('Around the World', 'mgrunbaum8', 'sem duis aliquam convallis nunc proin at turpis a pede posuere nonummy integer non velit donec diam neque vestibulum', '2004-04-24 13:52:39');
insert into comment (video_name, author, comment, timestamp) values ('Frenchmen (Le coeur des hommes)', 'mnicklinsong', 'est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien urna', '2011-12-31 02:06:57');
insert into comment (video_name, author, comment, timestamp) values ('Superheroes', 'cpond9', 'arcu sed augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna', '2018-07-17 11:35:05');
insert into comment (video_name, author, comment, timestamp) values ('Superheroes', 'cpond9', 'purus phasellus in felis donec semper sapien a libero nam dui proin', '2020-04-26 07:17:19');
insert into comment (video_name, author, comment, timestamp) values ('Frenchmen (Le coeur des hommes)', 'mgrunbaum8', 'pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus', '2002-12-27 04:54:20');

insert into comment_by_user (video_name, author, comment, timestamp) values ('Superheroes', 'cpond9', 'sit amet nulla quisque arcu libero rutrum ac lobortis vel dapibus at diam nam tristique tortor', '2008-08-19 12:50:17');
insert into comment_by_user (video_name, author, comment, timestamp) values ('Around the World', 'mnicklinsong', 'dolor morbi vel lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet', '2023-09-24 02:15:38');
insert into comment_by_user (video_name, author, comment, timestamp) values ('Superheroes', 'mgrunbaum8', 'erat id mauris vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy', '2001-01-16 22:28:02');
insert into comment_by_user (video_name, author, comment, timestamp) values ('Around the World', 'mgrunbaum8', 'quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum sed magna at nunc commodo placerat praesent', '2003-03-29 16:51:28');
insert into comment_by_user (video_name, author, comment, timestamp) values ('Frenchmen (Le coeur des hommes)', 'cpond9', 'tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis', '2012-01-29 01:53:34');
insert into comment_by_user (video_name, author, comment, timestamp) values ('Around the World', 'mgrunbaum8', 'quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id', '2002-12-11 01:50:25');
insert into comment_by_user (video_name, author, comment, timestamp) values ('Superheroes', 'cpond9', 'faucibus accumsan odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor', '2001-10-22 01:50:15');
insert into comment_by_user (video_name, author, comment, timestamp) values ('Superheroes', 'cpond9', 'donec dapibus duis at velit eu est congue elementum in hac habitasse platea dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum', '2003-11-06 07:01:00');
insert into comment_by_user (video_name, author, comment, timestamp) values ('Superheroes', 'cpond9', 'duis bibendum morbi non quam nec dui luctus rutrum nulla tellus in sagittis dui vel nisl duis ac', '2016-10-03 09:19:09');
insert into comment_by_user (video_name, author, comment, timestamp) values ('Superheroes', 'mgrunbaum8', 'suscipit ligula in lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus sit amet nulla quisque arcu libero', '2005-02-17 00:26:55');
insert into comment_by_user (video_name, author, comment, timestamp) values ('Superheroes', 'mnicklinsong', 'lobortis est phasellus sit amet erat nulla tempus vivamus in', '2004-11-09 10:23:31');
insert into comment_by_user (video_name, author, comment, timestamp) values ('Around the World', 'mgrunbaum8', 'nunc nisl duis bibendum felis sed interdum venenatis turpis enim blandit mi in porttitor pede justo eu massa donec dapibus duis at velit eu est congue elementum in', '2019-03-24 05:18:29');
insert into comment_by_user (video_name, author, comment, timestamp) values ('Superheroes', 'cpond9', 'feugiat non pretium quis lectus suspendisse potenti in eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa quis', '2005-02-27 01:14:38');
insert into comment_by_user (video_name, author, comment, timestamp) values ('Frenchmen (Le coeur des hommes)', 'mnicklinsong', 'turpis enim blandit mi in porttitor pede justo eu massa donec dapibus duis at velit eu est congue elementum in hac habitasse platea dictumst morbi vestibulum velit id pretium', '2016-07-26 02:32:18');
insert into comment_by_user (video_name, author, comment, timestamp) values ('Frenchmen (Le coeur des hommes)', 'cpond9', 'nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat', '2009-03-08 07:37:47');
insert into comment_by_user (video_name, author, comment, timestamp) values ('Around the World', 'mgrunbaum8', 'sem duis aliquam convallis nunc proin at turpis a pede posuere nonummy integer non velit donec diam neque vestibulum', '2004-04-24 13:52:39');
insert into comment_by_user (video_name, author, comment, timestamp) values ('Frenchmen (Le coeur des hommes)', 'mnicklinsong', 'est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien urna', '2011-12-31 02:06:57');
insert into comment_by_user (video_name, author, comment, timestamp) values ('Superheroes', 'cpond9', 'arcu sed augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna', '2018-07-17 11:35:05');
insert into comment_by_user (video_name, author, comment, timestamp) values ('Superheroes', 'cpond9', 'purus phasellus in felis donec semper sapien a libero nam dui proin', '2020-04-26 07:17:19');
insert into comment_by_user (video_name, author, comment, timestamp) values ('Frenchmen (Le coeur des hommes)', 'mgrunbaum8', 'pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus', '2002-12-27 04:54:20');
APPLY BATCH;

BEGIN BATCH
insert into event (video_name, username, timestamp, event_name) values ('Superheroes', 'cpond9', '2001-05-18 06:30:07', 'play');
insert into event (video_name, username, timestamp, event_name) values ('Frenchmen (Le coeur des hommes)', 'mgrunbaum8', '2022-03-11 14:20:10', 'stop');
insert into event (video_name, username, timestamp, event_name) values ('Superheroes', 'mgrunbaum8', '2009-12-07 22:56:36', 'stop');
insert into event (video_name, username, timestamp, event_name) values ('Superheroes', 'mgrunbaum8', '2004-05-09 06:11:41', 'pause');
insert into event (video_name, username, timestamp, event_name) values ('Frenchmen (Le coeur des hommes)', 'cpond9', '2009-06-17 10:46:57', 'play');
insert into event (video_name, username, timestamp, event_name) values ('Superheroes', 'cpond9', '2012-09-21 20:00:51', 'stop');
insert into event (video_name, username, timestamp, event_name) values ('Frenchmen (Le coeur des hommes)', 'cpond9', '2009-04-07 20:04:53', 'pause');
insert into event (video_name, username, timestamp, event_name) values ('Superheroes', 'mnicklinsong', '2014-09-29 23:45:57', 'pause');
insert into event (video_name, username, timestamp, event_name) values ('Around the World', 'mgrunbaum8', '2006-09-27 16:59:16', 'stop');
insert into event (video_name, username, timestamp, event_name) values ('Frenchmen (Le coeur des hommes)', 'mgrunbaum8', '2002-08-19 12:36:16', 'play');
insert into event (video_name, username, timestamp, event_name) values ('Frenchmen (Le coeur des hommes)', 'cpond9', '2017-12-22 09:42:16', 'play');
insert into event (video_name, username, timestamp, event_name) values ('Around the World', 'mnicklinsong', '2017-10-17 14:00:25', 'stop');
insert into event (video_name, username, timestamp, event_name) values ('Around the World', 'mgrunbaum8', '2000-12-17 19:26:16', 'stop');
insert into event (video_name, username, timestamp, event_name) values ('Superheroes', 'mnicklinsong', '2001-12-24 13:26:49', 'play');
insert into event (video_name, username, timestamp, event_name) values ('Superheroes', 'mnicklinsong', '2023-01-15 20:31:34', 'stop');
insert into event (video_name, username, timestamp, event_name) values ('Around the World', 'mgrunbaum8', '2006-11-04 23:38:01', 'pause');
insert into event (video_name, username, timestamp, event_name) values ('Around the World', 'mnicklinsong', '2009-03-30 23:30:17', 'play');
insert into event (video_name, username, timestamp, event_name) values ('Frenchmen (Le coeur des hommes)', 'mgrunbaum8', '2009-11-01 17:17:05', 'play');
insert into event (video_name, username, timestamp, event_name) values ('Frenchmen (Le coeur des hommes)', 'mnicklinsong', '2006-01-31 04:48:30', 'play');
insert into event (video_name, username, timestamp, event_name) values ('Around the World', 'cpond9', '2003-02-25 17:40:51', 'pause');
APPLY BATCH;

BEGIN BATCH
insert into rating (video_name, value) values ('Around the World', 1);
insert into rating (video_name, value) values ('Superheroes', 3);
insert into rating (video_name, value) values ('Superheroes', 5);
insert into rating (video_name, value) values ('Frenchmen (Le coeur des hommes)', 3);
insert into rating (video_name, value) values ('Around the World', 1);
insert into rating (video_name, value) values ('Frenchmen (Le coeur des hommes)', 2);
insert into rating (video_name, value) values ('Around the World', 2);
insert into rating (video_name, value) values ('Around the World', 2);
insert into rating (video_name, value) values ('Superheroes', 3);
insert into rating (video_name, value) values ('Superheroes', 2);
insert into rating (video_name, value) values ('Around the World', 4);
insert into rating (video_name, value) values ('Frenchmen (Le coeur des hommes)', 2);
insert into rating (video_name, value) values ('Around the World', 1);
insert into rating (video_name, value) values ('Around the World', 3);
insert into rating (video_name, value) values ('Around the World', 3);
insert into rating (video_name, value) values ('Around the World', 3);
insert into rating (video_name, value) values ('Around the World', 2);
insert into rating (video_name, value) values ('Around the World', 1);
insert into rating (video_name, value) values ('Superheroes', 4);
insert into rating (video_name, value) values ('Frenchmen (Le coeur des hommes)', 5);
APPLY BATCH;

