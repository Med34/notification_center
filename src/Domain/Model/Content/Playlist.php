<?php

declare(strict_types=1);

namespace App\Domain\Model\Content;


final class Playlist
{

    public function __construct(
        private string  $title,
        private User    $user,
        private ?string $description,
        private ?int   $isPublic
    ) {
    }

    /** @var array<Track> */
    private array $tracks;

}
