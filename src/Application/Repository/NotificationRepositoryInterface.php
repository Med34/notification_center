<?php

declare(strict_types=1);

namespace App\Application\Repository;

use App\Domain\Model\Notification\UserNotification;


interface NotificationRepositoryInterface
{
    public function getByUser(int $userId): ?UserNotification;
}
