<?php

declare(strict_types=1);

namespace App\Infrastructure\Request;

final class GetUserNotificationRequest
{

    public function __construct(
        private readonly int $userId
    ) {
    }

    public function getUserId(): int
    {
        return $this->userId;
    }

}
