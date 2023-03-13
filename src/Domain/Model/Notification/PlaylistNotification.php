<?php

declare(strict_types=1);

namespace App\Domain\Model\Notification;

use App\Domain\Model\Content\Playlist;
use App\Domain\Model\Content\User;


final class PlaylistNotification extends Notification
{

    private ?Playlist $playlist;

    public function createFromArray(array $data): ?INotification
    {
        parent::createFromArray($data);

        if (
            $data['playlist_title']
            && $data['playlist_user_name']
            && $data['playlist_user_firstname']
        ) {
            $user = new User(
                $data['playlist_user_name'],
                $data['playlist_user_firstname']
            );

            $playlist = new Playlist(
                $data['playlist_title'],
                $user,
                $data['playlist_description'],
                $data['playlist_is_public']
            );

            $this->playlist = $playlist;
        }

        return $this;
    }

    public function toArray(INotification $notification): array
    {
        $notification = parent::toArray($notification);

        $notification['notif_content_type'] = 'playlist';
        $notification['playlist_title']     = $this->playlist->getTitle();
        $notification['playlist_user']      =
            $this->playlist->getUser()->getFirstName()." ".$this->playlist->getUser()->getFirstName();

        $notification['description'] = $this->playlist->getDescription();
        $notification['is_public']   = $this->playlist->getIsPublic();

        return $notification;
    }

}
