<!doctype html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>admin &mdash; Login</title>

    <!-- Favicon -->
    <link rel="shortcut icon" href="<?= base_url('assets_Owner/'); ?>media/image/login.png" />

    <!-- Plugin styles -->
    <link rel="stylesheet" href="<?= base_url('assets_Owner/'); ?>vendors/bundle.css" type="text/css">

    <!-- App styles -->
    <link rel="stylesheet" href="<?= base_url('assets_Owner/'); ?>css/app.min.css" type="text/css">
</head>

<body class="form-membership">

    <!-- begin::preloader-->
    <div class="preloader">
        <div class="preloader-icon"></div>
    </div>
    <!-- end::preloader -->

    <div class="form-wrapper">

        <!-- logo -->
        <div id="logo">
            <img src="<?= base_url('assets_Owner/'); ?>media/image/logo.png" alt="image">
        </div>
        <!-- ./ logo -->


        <h5>Login As Admin</h5>

        <?php
        if (!empty($this->session->flashdata('success'))) {
        ?>
            <div class="alert alert-success" role="alert"><?php echo $this->session->flashdata('success'); ?></div>
        <?php
        }
        ?>
        <?php
        if (!empty($this->session->flashdata('error'))) {
        ?>
            <div class="alert alert-danger" role="alert"><?php echo $this->session->flashdata('error'); ?></div>
        <?php
        }
        ?>

        <!-- form -->
        <?php echo form_open('admin/login_proses', ''); ?>
        <div class="form-group">
            <input type="email" name="email" class="form-control" placeholder="Email" required="Required" autofocus autocomplete="off">
            <?php echo form_error('email', '<div class="text-danger"><small>', '</small></div>');?>
        </div>
        <div class="form-group">
            <input type="password" name="password" class="form-control" placeholder="Password" required="Required">
            <?php echo form_error('password', '<div class="text-danger"><small>', '</small></div>');?>
        </div>
        
        <button type="submit" class="btn btn-primary btn-block">Login</button>
        <hr>
        
        <hr>
        <p class="text-muted">Don't have an account?</p>
        
        <a href="<?= base_url('admin/register'); ?>" class="btn btn-outline-light btn-sm">Register now!</a>
        <?php echo form_close(); ?>
        <!-- ./ form -->


    </div>

    <!-- Plugin scripts -->
    <script src="<?= base_url('assets_Owner/'); ?>vendors/bundle.js"></script>

    <!-- App scripts -->
    <script src="<?= base_url('assets_Owner/'); ?>js/app.min.js"></script>
</body>

</html>