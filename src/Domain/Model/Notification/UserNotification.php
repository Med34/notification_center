<?php

declare(strict_types=1);

namespace App\Domain\Model\Notification;


use App\Domain\Factory\NotificationFactory;


final class UserNotification
{

    /** @var array<INotification> */
    private array $notifications;

    public function addNotification(INotification $notification) : self
    {
        $this->notifications[] = $notification;

        return $this;
    }

    public static function fromArray(array $rawData): ?self
    {
        if (count($rawData) === 0) {
            return null;
        }

        $userNotifications = new UserNotification();

        foreach ($rawData as $data) {
            $notification = NotificationFactory::createFromArray($data);

            if ($notification) {
                $userNotifications->addNotification($notification);
            }
        }

        return $userNotifications;
    }
}
