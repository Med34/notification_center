<?php

declare(strict_types=1);

namespace App\Infrastructure\Repository;

use App\Application\Repository\NotificationRepositoryInterface;
use App\Domain\Model\Notification\UserNotification;
use Doctrine\DBAL\Connection;
use Doctrine\DBAL\Exception;

final class NotificationRepository implements NotificationRepositoryInterface
{

    public function __construct(
        private readonly Connection $connection,
    ) {
    }

    public function getByUser(int $userId): ?UserNotification
    {
        $sql = "
        SELECT un.id,
               nct.name                  AS notification_content_type_name,
               n.type                    AS notification_type,
               n.description             AS notification_description,
               n.created_at              AS notification_created_at,
               n.validated_at            AS notification_validated_at,
               un.is_read                AS is_read,
               album.title               AS album_title,
               album.released_date       AS album_released_date,
               artist.name               AS album_artist_name,
               artist.firstname          AS album_artist_firstname,
               playlist.title            AS playlist_title,
               playlist.description      AS playlist_description,
               playlist.is_public        AS playlist_is_public,
               user.name                 AS playlist_user_name,
               user.firstname            AS playlist_user_firstname,
               podcast.title             AS podcast_title,
               podcast.description       AS podcast_description,
               art_pod.name              AS podcast_artist_name,
               art_pod.firstname         AS podcast_artist_firstname,
               track.title               AS track_title,
               track.nb_views            AS track_nb_views,
               album_track.title         AS track_album_title,
               album_track.released_date as track_album_released_date,
               art_track.name            AS track_album_artist_name,
               art_track.firstname       AS track_album_artist_firstname
        FROM user_notification un
                 INNER JOIN notification n ON un.notification_id = n.id
                 INNER JOIN notification_content_type nct ON n.notification_content_type_id = nct.notification_content_type_id
        
                 LEFT JOIN album_notification an ON n.id = an.notification_id
                 LEFT JOIN album ON an.album_id = album.id
                 LEFT JOIN artist_has_album ON album.id = artist_has_album.album_id
                 LEFT JOIN artist ON artist_has_album.artist_id = artist.id
        
                 LEFT JOIN playlist_notification pn ON n.id = pn.notification_id
                 LEFT JOIN playlist ON pn.playlist_id = playlist.id
                 LEFT JOIN user ON playlist.user_id = user.id
        
                 LEFT JOIN podcast_notification pod_n ON n.id = pod_n.notification_id
                 LEFT JOIN podcast ON pod_n.podcast_id = podcast.id
                 LEFT JOIN artist_has_podcast ON podcast.id = artist_has_podcast.podcast_id
                 LEFT JOIN artist art_pod ON artist_has_podcast.artist_id = art_pod.id
        
                 LEFT JOIN track_notification tn ON n.id = tn.notification_id
                 LEFT JOIN track ON tn.track_id = track.id
                 LEFT JOIN album album_track ON album_track.id = track.album_id
                 LEFT JOIN artist art_track ON art_track.id = album_track.id
        WHERE un.user_id = :userId
        ORDER BY n.created_at DESC
        ";

        try {
            $stmt = $this->connection->prepare($sql);
            $stmt->bindValue('userId', $userId);
            $result = $stmt->executeQuery()->fetchAllAssociative();
        } catch (Exception) {
            return null;
        }

        return UserNotification::fromArray($result);
    }

}
