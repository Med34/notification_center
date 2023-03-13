<?php

declare(strict_types=1);

namespace App\Domain\Factory;

use App\Domain\Model\Notification\AlbumNotification;
use App\Domain\Model\Notification\INotification;
use App\Domain\Model\Notification\NotificationType;
use App\Domain\Model\Notification\PlaylistNotification;
use App\Domain\Model\Notification\PodcastNotification;
use App\Domain\Model\Notification\TrackNotification;


final class NotificationFactory
{

    public static function createFromArray(array $data): ?INotification
    {
        $notification = null;

        $notificationType = $data['notification_content_type_name'];

        switch ($notificationType) {
            case NotificationType::PODCAST_TYPE:
                $notification = (new PodcastNotification)->createFromArray($data);
                break;
            case NotificationType::ALBUM_TYPE:
                $notification = (new AlbumNotification)->createFromArray($data);
                break;
            case NotificationType::PLAYLIST_TYPE:
                $notification = (new PlaylistNotification)->createFromArray($data);
                break;
            case NotificationType::TRACK_TYPE:
                $notification = (new TrackNotification)->createFromArray($data);
                break;
        }

        return $notification;
    }

}
