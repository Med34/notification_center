<?php

declare(strict_types=1);

namespace App\Domain\Model\Content;


final class Track
{

    public function __construct(
        private string $title,
        private Album  $album,
        private ?int   $nbViews
    ) {
    }

}
