<?php
try {
    $db = new PDO('sqlite:db/db.db');
    $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    $sql = "INSERT INTO users (email, password, forename, surname)
            VALUES (:email, :password, :forename, :surname)";
    
    $stmt = $db->prepare($sql);
    $stmt->execute([
        ':email' => 'testuser2@example.com',
        ':password' => password_hash('mypassword', PASSWORD_DEFAULT),
        ':forename' => 'Test',
        ':surname' => 'User'
    ]);

    echo "User inserted successfully!";
} catch (PDOException $e) {
    echo "Error: " . $e->getMessage();
}
