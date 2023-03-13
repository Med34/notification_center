<?php

declare(strict_types=1);

namespace App\Domain\Model\Notification;

use App\Domain\Model\Content\Album;
use App\Domain\Model\Content\Artist;
use DateTime;


final class AlbumNotification extends Notification
{

    private ?Album $album;

    public function createFromArray(array $data): ?INotification
    {
        parent::createFromArray($data);

        if (
            $data['album_title']
            && $data['album_released_date']
        ) {
            $album = new Album(
                $data['album_title'],
                new DateTime($data['album_released_date'])
            );

            if (
                $data['album_artist_name']
                && $data['album_artist_firstname']
            ) {
                $artist = new Artist($data['album_artist_name'], $data['album_artist_firstname']);
                $album->addArtist($artist);
            }

            $this->album = $album;
        }

        return $this;
    }

    public function toArray(INotification $notification): array
    {
        $notification = parent::toArray($notification);

        $notification['notif_content_type']  = 'album';
        $notification['album_title']         = $this->album->getTitle();
        $notification['album_released_date'] = $this->album->getReleasedDate();

        $notification['album_artists'] = [];

        foreach ($this->album->getArtists() as $artist) {
            $notification['album_artists'][] = [
                'album_artist_name' => $artist->getName()." ".$artist->getFirstName(),
            ];
        }

        return $notification;
    }

}
