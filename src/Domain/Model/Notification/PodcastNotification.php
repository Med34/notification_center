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

}
