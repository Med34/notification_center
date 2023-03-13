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

}
