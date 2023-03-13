<?php

declare(strict_types=1);

namespace App\Domain\Model\Notification;

use App\Domain\Model\Content\Artist;
use App\Domain\Model\Content\Podcast;


final class PodcastNotification extends Notification
{

    private ?Podcast $podcast;

    public function createFromArray(array $data): ?INotification
    {
        parent::createFromArray($data);

        if ($data['podcast_title']) {
            $podcast = new Podcast($data['podcast_title'], $data['podcast_description']);

            if ($data['podcast_artist_name'] && $data['podcast_artist_firstname']) {
                $artist = new Artist(
                    $data['podcast_artist_name'],
                    $data['podcast_artist_firstname']
                );

                $podcast->addArtist($artist);
            }

            $this->podcast = $podcast;
        }


        return $this;
    }

    public function toArray(INotification $notification): array
    {
        $notification = parent::toArray($notification);

        $notification['podcast_title']       = $this->podcast->getTitle();
        $notification['podcast_description'] = $this->podcast->getDescription();

        $notification['podcast_artists'] = [];

        foreach ($this->podcast->getArtists() as $artist) {
            $notification['podcast_artists'][] = [
                'podcast_artist_name' => $artist->getName()." ".$artist->getFirstName(),
            ];
        }

        return $notification;
    }
}
