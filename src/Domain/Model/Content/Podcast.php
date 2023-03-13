<?php

declare(strict_types=1);

namespace App\Domain\Model\Content;


final class Podcast
{

    public function __construct(
        private readonly string  $title,
        private readonly ?string $description,
        /** @var array<Artist> */
        private ?array           $artists = []
    ) {
    }

    public function addArtist(Artist $artist): void
    {
        $this->artists[] = $artist;
    }

    public function getTitle(): string
    {
        return $this->title;
    }

    public function getDescription(): ?string
    {
        return $this->description;
    }

    public function getArtists(): ?array
    {
        return $this->artists;
    }

}
