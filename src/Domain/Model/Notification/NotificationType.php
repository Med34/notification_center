<?php

declare(strict_types=1);

namespace App\Domain\Model\Notification;

final class NotificationType
{

    public const
        NEW_CONTENT = 'new content',
        SHARING = 'sharing',
        UPDATE = 'update',
        RECOMMENDATION = 'recommendation';

}
