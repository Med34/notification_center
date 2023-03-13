<?php

declare(strict_types=1);

namespace App\Domain\Model\Content;

final class Artist
{

    public function __construct(
        private readonly string $name,
        private readonly string $firstName,
    ) {
    }

    public function getName(): string
    {
        return $this->name;
    }

    public function getFirstName(): string
    {
        return $this->firstName;
    }

}
