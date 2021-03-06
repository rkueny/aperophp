<?php

namespace Aperophp\Repository;

class DrinkComment extends Repository
{
    public function getTableName()
    {
        return 'Drink_Comment';
    }

    public function findByDrinkId($drinkId, $hideSpam = false)
    {
        $sql = 'SELECT c.*, u.email as user_email, u.firstname,
                (SELECT username FROM Member m WHERE m.id = u.member_id) as username
                FROM Drink_Comment c, User u
                WHERE c.user_id = u.id AND drink_id = ?
            ';

        if ($hideSpam) {
            $sql .= ' AND c.is_spam = 0 ';
        }

        $sql .= ' ORDER BY created_at';

        $params = array((int) $drinkId);

        return $this->db->fetchAll($sql, $params);
    }

    public function findOne($drinkId, $userId)
    {
        $sql = 'SELECT * FROM Drink_Comment WHERE drink_id = ? AND user_id = ? LIMIT 1';

        return $this->db->fetchAssoc($sql, array((int) $drinkId, (int) $userId));
    }

    public function groupByEmail($email, $userId)
    {
        $sql = 'UPDATE Drink_Comment SET user_id = ? WHERE user_id IN (SELECT id FROM User WHERE email = ?)';

        $this->db->prepare($sql)->execute(array((int) $userId, $email));
    }
}
