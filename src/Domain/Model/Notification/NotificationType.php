<?php

declare(strict_types=1);

namespace App\Domain\Model\Notification;

final class NotificationType
{

    public const
        PODCAST_TYPE = 'Podcast',
        PLAYLIST_TYPE = 'Playlist',
        ALBUM_TYPE = 'Album',
        TRACK_TYPE = 'Track';

}
