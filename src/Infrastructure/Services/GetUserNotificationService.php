<?php

declare(strict_types=1);

namespace App\Infrastructure\Services;

use App\Application\UseCase\GetUserNotificationUseCase;
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
        $response = $this->getUserNotificationUseCase->handle($request);

        return [];
        //return $this->getUserNotificationUseCase->handle($request);
    }

}
