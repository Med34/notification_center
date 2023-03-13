<?php

declare(strict_types=1);

namespace App\Domain\Model\Content;


final class Track
{

    public function __construct(
        private readonly string $title,
        private readonly Album  $album,
        private readonly ?int   $nbViews
    ) {
    }

    public function getTitle(): string
    {
        return $this->title;
    }

    public function getAlbum(): Album
    {
        return $this->album;
    }

    public function getNbViews(): ?int
    {
        return $this->nbViews;
    }

}
