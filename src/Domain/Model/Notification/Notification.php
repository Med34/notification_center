<?php

declare(strict_types=1);

namespace App\Domain\Model\Notification;

use DateTime;
use Exception;
use ReflectionClass;


class Notification implements INotification
{

    protected string $type;

    private int $isRead;

    private ?string $description;

    private ?DateTime $createdAt;

    private ?DateTime $validatedAt;

    public function createFromArray(array $data): ?INotification
    {
        $this->type        = $data['notification_type'];
        $this->description = $data['notification_description'];
        $this->isRead      = $data['notification_is_read'];

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

    public function toArray(INotification $notification): array
    {
        return [
            'is_read'     => $this->isRead,
            'description' => $this->description,
            'created_at'  => $this->createdAt(),
            'type'        => $this->getType(),
        ];
    }

    private function createdAt(): string
    {
        $now  = new DateTime();
        $diff = $now->diff($this->createdAt);

        if ($diff->y !== 0) {
            return $diff->format('Il y a %y year(s)');
        }

        if ($diff->m !== 0) {
            return $diff->format('Il y a %m mois(s)');
        }

        if ($diff->d !== 0) {
            return $diff->format('Il y a %d jour(s)');
        }

        return '';
    }

    private function getType(): string
    {
        $type        = '';
        $reflectionClass = new ReflectionClass($this);
        $contentType = str_replace('Notification', '', $reflectionClass->getShortName());

        switch ($this->type) {
            case NotificationType::NEW_CONTENT:
                $type = "New $contentType";
                break;
            case NotificationType::RECOMMENDATION:
                $type = "Recommended $contentType";
                break;
            case NotificationType::SHARING:
                $type = 'Sharing';
                break;
            case NotificationType::UPDATE;
                $type = "Updated $contentType";
                break;
        }

        return $type;
    }

}
