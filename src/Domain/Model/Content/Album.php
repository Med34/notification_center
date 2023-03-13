<?php

declare(strict_types=1);

namespace App\Domain\Model\Content;


use DateTime;


final class Album
{

    public function __construct(
        private readonly string   $title,
        private readonly DateTime $releasedDate,
        /** @var array<Artist> */
        private array             $artists = []
    ) {
    }

    /** @var array<Track> */
    private array $tracks;

    public function addArtist(Artist $artist): void
    {
        $this->artists[] = $artist;
    }

    public function getTitle(): string
    {
        return $this->title;
    }

    public function getReleasedDate(): DateTime
    {
        return $this->releasedDate;
    }

    public function getArtists(): array
    {
        return $this->artists;
    }

}
