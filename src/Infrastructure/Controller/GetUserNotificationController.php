<?php

declare(strict_types=1);

namespace App\Infrastructure\Controller;

use App\Infrastructure\Request\GetUserNotificationRequest;
use App\Infrastructure\Services\GetUserNotificationService;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Validator\Validator\ValidatorInterface;


final class GetUserNotificationController extends AbstractController
{

    private const REQUEST_USER_ID = 'userId';

    #[Route('/api/user/{userId}/notifications', 'user_notifications', [ 'page' => '\d+' ], methods: [ 'GET' ])]
    public function __invoke(
        Request                    $request,
        ValidatorInterface         $validator,
        GetUserNotificationService $getUserNotificationService
    ): JsonResponse {
        $userId = $request->attributes->getInt(self::REQUEST_USER_ID);

        $request = new GetUserNotificationRequest($userId);

        // @TODO: make a validation here
        $validator->validate($request);

        $response = $getUserNotificationService($request);

        return $this->json($response);
    }

}
