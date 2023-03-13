<?php

declare(strict_types=1);

namespace App\Domain\Model\Notification;

interface INotification
{
    public function createFromArray(array $data): ?INotification;

    public function toArray(INotification $notification): array;
}
