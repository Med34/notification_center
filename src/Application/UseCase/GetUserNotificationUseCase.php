<?php

declare(strict_types=1);

namespace App\Application\UseCase;

use App\Application\Repository\NotificationRepositoryInterface;
use App\Domain\Model\Notification\UserNotification;
use App\Infrastructure\Request\GetUserNotificationRequest;


final class GetUserNotificationUseCase
{

    public function __construct(
        private readonly NotificationRepositoryInterface $notificationRepository
    ) {
    }

    public function handle(GetUserNotificationRequest $request): UserNotification
    {
        return $this->notificationRepository->getByUser($request->getUserId());
    }

}
