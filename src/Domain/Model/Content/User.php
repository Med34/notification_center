<?php

declare(strict_types=1);

namespace App\Domain\Model\Content;

final class User
{

    public function __construct(
        private string $name,
        private string $firstName
    ) {
    }

}
