<?php

declare(strict_types=1);

namespace App\Domain\Model\Content;


final class Podcast
{

    public function __construct(
        private string  $title,
        private ?string $description
    ) {
    }

    /** @var array<Artist> */
    private array $artists;

    public function addArtist(Artist $artist): void
    {
        $this->artists[] = $artist;
    }

}
