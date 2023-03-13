INSERT INTO dev.album (id, title, released_date, created_at, updated_at)
VALUES (1, 'Discovery', '2001-03-12 16:16:02', '2023-03-12 16:16:10', null);
INSERT INTO dev.album (id, title, released_date, created_at, updated_at)
VALUES (2, 'Get Rich or Die Tryin', '2003-03-12 16:18:29', '2023-03-12 16:18:35', null);

INSERT INTO dev.artist (id, name, firstname, created_at, updated_at)
VALUES (1, 'Daft', 'Punk', '2023-03-12 16:15:08', null);
INSERT INTO dev.artist (id, name, firstname, created_at, updated_at)
VALUES (2, '100%', 'Tech', '2023-03-12 16:15:18', null);
INSERT INTO dev.artist (id, name, firstname, created_at, updated_at)
VALUES (3, '50', 'Cent', '2023-03-12 16:17:51', null);

INSERT INTO dev.artist_has_album (artist_id, album_id)
VALUES (1, 1);
INSERT INTO dev.artist_has_album (artist_id, album_id)
VALUES (3, 2);

INSERT INTO dev.user (id, name, firstname, email, password, created_at, updated_at)
VALUES (1, 'Dupond', 'Georges', 'dupond.georges@gmail.com', 'password', '2023-03-12 16:14:13', null);
INSERT INTO dev.user (id, name, firstname, email, password, created_at, updated_at)
VALUES (2, 'Durant', 'Marc', 'durant@marc.fr', 'password', '2023-03-12 16:14:36', null);

INSERT INTO dev.track (id, title, album_id, nb_views, created_at, updated_at)
VALUES (1, 'One more time', 1, 15259853, '2023-03-12 16:16:29', null);
INSERT INTO dev.track (id, title, album_id, nb_views, created_at, updated_at)
VALUES (2, 'Harder, Better, Faster, Stronger', 1, 898785555, '2023-03-12 16:16:57', null);
INSERT INTO dev.track (id, title, album_id, nb_views, created_at, updated_at)
VALUES (3, 'In da club', 2, 874569, '2023-03-12 16:19:07', null);

INSERT INTO dev.podcast (id, title, description, created_at, updated_at)
VALUES (1, 'Technologie', 'Que de la tech', '2023-03-12 16:19:57', null);

INSERT INTO dev.playlist (id, title, description, is_public, user_id, created_at, updated_at)
VALUES (1, 'Que du fun', 'My playlist à moi', 1, 2, '2023-03-12 16:20:44', null);

INSERT INTO dev.playlist_has_track (playlist_id, track_id)
VALUES (1, 1);
INSERT INTO dev.playlist_has_track (playlist_id, track_id)
VALUES (1, 3);

INSERT INTO dev.artist_has_podcast (artist_id, podcast_id)
VALUES (2, 1);

# NOTIF
INSERT INTO dev.notification_content_type (name, created_at)
VALUES ('Album', '2023-03-12 16:19:57');
INSERT INTO dev.notification_content_type (name, created_at)
VALUES ('Track', '2023-03-12 16:19:57');
INSERT INTO dev.notification_content_type (name, created_at)
VALUES ('Podcast', '2023-03-12 16:19:57');
INSERT INTO dev.notification_content_type (name, created_at)
VALUES ('Playlist', '2023-03-12 16:19:57');

INSERT INTO dev.notification (notification_content_type_id, type, description, validated_at, created_at)
VALUES (1, 'new content', 'Listen this new album', '2023-03-19 23:59:59', '2022-12-12 23:59:59');

INSERT INTO dev.notification (notification_content_type_id, type, validated_at, created_at)
VALUES (4, 'sharing', '2023-02-01 23:59:59', '2023-01-01 23:59:59');

INSERT INTO dev.notification (notification_content_type_id, type, description, validated_at, created_at)
VALUES (2, 'recommendation','Ecoute ce nouveau son, ca devrait te plaire', '2023-04-19 23:59:59', '2023-02-25 23:59:59');

INSERT INTO dev.notification (notification_content_type_id, type, description, validated_at, created_at)
VALUES (3, 'update', 'Nouveau podcast a écouter', '2023-04-28 23:59:59', '2023-02-12 23:59:59');

INSERT INTO dev.user_notification (user_id, notification_id, is_read)
VALUES (1, 1, 0);

INSERT INTO dev.user_notification (user_id, notification_id, is_read)
VALUES (1, 2, 1);

INSERT INTO dev.user_notification (user_id, notification_id, is_read)
VALUES (1, 3, 0);

INSERT INTO dev.user_notification (user_id, notification_id, is_read)
VALUES (1, 4, 0);

INSERT INTO dev.album_notification(notification_id, notification_content_type_id, album_id)
VALUES (1, 1, 1);

INSERT INTO dev.playlist_notification (notification_id, notification_content_type_id, playlist_id)
VALUES (2, 4, 1);

INSERT INTO dev.track_notification (notification_id, notification_content_type_id, track_id)
VALUES (3, 2, 1);

INSERT INTO dev.podcast_notification (notification_id, notification_content_type_id, podcast_id)
VALUES (4, 3, 1);
