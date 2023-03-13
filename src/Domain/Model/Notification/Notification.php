<?php

declare(strict_types=1);

namespace App\Domain\Model\Notification;

use DateTime;
use Exception;


class Notification implements INotification
{

    private string $type;

    private ?string $description;

    private ?DateTime $createdAt;

    private ?DateTime $validatedAt;

    public function createFromArray(array $data): ?INotification
    {
        $this->type        = $data['notification_type'];
        $this->description = $data['notification_description'];

        $createdAt   = $data['notification_created_at'];
        $validatedAt = $data['notification_validated_at'];

        try {
            $this->createdAt = $createdAt !== null ? new DateTime($createdAt) : null;
        } catch (Exception) {
            $this->createdAt = null;
        }

        try {
            $this->validatedAt = $validatedAt !== null ? new DateTime($data['notification_validated_at']) : null;
        } catch (Exception) {
            $this->validatedAt = null;
        }

        return $this;
    }

}
