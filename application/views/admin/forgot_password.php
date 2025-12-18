<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lupa Password</title>
</head>
<body>
    <h2>Lupa Password</h2>

    <?php if (isset($message)): ?>
        <p><?php echo $message; ?></p>
    <?php endif; ?>

    <form action="<?php echo base_url('forgotpassword/resetpassword'); ?>" method="post">
        <label for="email">Email:</label>
        <input type="email" name="email" required>
        <button type="submit">Reset Password</button>
    </form>
</body>
</html>
