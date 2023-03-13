<?php

declare(strict_types=1);

namespace App\Domain\Model\Content;


use DateTime;


final class Album
{

    public function __construct(
        private string   $title,
        private DateTime $releasedDate
    ) {
    }

    /** @var array<Artist> */
    private array $artists;

    /** @var array<Track> */
    private array $tracks;

    public function addArtist(Artist $artist): void
    {
        $this->artists[] = $artist;
    }

}
