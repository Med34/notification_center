<?php

declare(strict_types=1);

namespace App\Domain\Model\Notification;

use App\Domain\Model\Content\Album;
use App\Domain\Model\Content\Artist;
use App\Domain\Model\Content\Track;
use DateTime;


final class TrackNotification extends Notification
{

    private ?Track $track;

    public function createFromArray(array $data): ?INotification
    {
        parent::createFromArray($data);

        if (
            $data['track_title']
            && $data['track_image_url']
            && $data['track_album_title']
            && $data['track_album_released_date']
            && $data['track_album_image_url']
        ) {
            $album = new Album(
                $data['track_album_title'],
                new DateTime($data['track_album_released_date']),
                $data['track_album_image_url']
            );

            if ($data['track_album_artist_name'] && $data['track_album_artist_firstname']) {
                $albumArtist = new Artist($data['track_album_artist_name'], $data['track_album_artist_firstname']);
                $album->addArtist($albumArtist);
            }

            $this->track = new Track($data['track_title'], $album, $data['track_image_url'], $data['track_nb_views']);
        }

        return $this;
    }

    public function toArray(INotification $notification): array
    {
        $notification = parent::toArray($notification);

        $notification['track_title']           = $this->track->getTitle();
        $notification['track_image_url']       = $this->track->getImageUrl();
        $notification['track_album_title']     = $this->track->getAlbum()->getTitle();

        $notification['track_artists'] = [];

        foreach ($this->track->getAlbum()->getArtists() as $artist) {
            $notification['track_artists'][] = [
                'track_artist_name' => $artist->getName()." ".$artist->getFirstName(),
            ];
        }

        return $notification;
    }

}
