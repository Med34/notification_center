<?php

declare(strict_types=1);

namespace App\Domain\Model\Content;


final class Playlist
{

    public function __construct(
        private readonly string  $title,
        private readonly User    $user,
        private readonly ?string $description,
        private readonly ?int    $isPublic,
        /** @var array<Track> */
        private readonly ?array  $tracks = [],
    ) {
    }

    public function getTitle(): string
    {
        return $this->title;
    }

    public function getUser(): User
    {
        return $this->user;
    }

    public function getTracks(): ?array
    {
        return $this->tracks;
    }

    public function getDescription(): ?string
    {
        return $this->description;
    }

    public function getIsPublic(): ?int
    {
        return $this->isPublic;
    }

}
