<?php

declare(strict_types=1);

namespace App\Infrastructure\Services;

use App\Application\UseCase\GetUserNotificationUseCase;
use App\Domain\Model\Notification\UserNotification;
use App\Infrastructure\Request\GetUserNotificationRequest;


final class GetUserNotificationService
{

    public function __construct(
        private readonly GetUserNotificationUseCase $getUserNotificationUseCase

    ) {
    }

    public function __invoke(
        GetUserNotificationRequest $request,
    ): iterable {
        $userNotification = $this->getUserNotificationUseCase->handle($request);
        $userNotificationsArray = UserNotification::toArray($userNotification);

        if ($userNotificationsArray['nb_notifications'] === 0) {
            return ['No notification '];
        }

        return $userNotificationsArray;
    }

}
