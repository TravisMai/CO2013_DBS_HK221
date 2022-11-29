<style>
  .user-img {
    position: absolute;
    height: 27px;
    width: 27px;
    object-fit: cover;
    left: -7%;
    top: -12%;
  }

  .btn-rounded {
    border-radius: 50px;
  }

  .fa-spin.spin-reverse {
    -webkit-animation-direction: reverse;
    -moz-animation-direction: reverse;
    animation-direction: reverse;
  }
</style>
<!-- Navbar -->
<style>
  #login-nav {
    position: fixed !important;
    top: 0 !important;
    z-index: 1038;
    padding: 0.3em 2.5em !important;
  }

  #top-Nav {
    top: 2.3em;
  }

  .text-sm .layout-navbar-fixed .wrapper .main-header~.content-wrapper,
  .layout-navbar-fixed .wrapper .main-header.text-sm~.content-wrapper {
    margin-top: calc(3.6) !important;
    padding-top: calc(3.2em) !important
  }
</style>
<nav class="w-100 px-2 py-1 position-fixed top-0 bg-white text-dark" id="login-nav">
  <div class="d-flex justify-content-between w-100">
    <div class="d-flex justify-content-start w-75">
      <!--p class="m-0 truncate-1"><small><?= $_settings->info('name') ?></small></p-->
      <marquee width="100%" id="marquee-banner" scrollamount="7" style="width: 100%;" loop="">
        <div class="flex space-x-8"><i class="fas fa-seedling fa-spin spin-reverse" style="color:#54c577"></i><a
            href="#" style="color:#54c577">&nbsp;<?= $_settings->info('banner') ?>&nbsp;</a><i
            class="fas fa-seedling fa-spin" style="color:#54c577"></i></div>
      </marquee>
    </div>
    <div class="d-flex justify-content-center">
      <?php if ($_settings->userdata('id') > 0 && $_settings->userdata('login_type') == 3): ?>

      <!-- <span class="mx-2">Howdy, <?=!empty($_settings->userdata('username')) ? $_settings->userdata('username') : $_settings->userdata('email') ?></span>
              <span class="mx-1"><a href="<?= base_url . 'classes/Login.php?f=logout_client' ?>"><i class="fa fa-power-off"></i></a></span> -->
      <div class="dropdown">
        <a href="javascript:void(0)" class="dropdown-toggle text-reset text-decoration-none" id="dropdownMenuButton"
          data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          <span class="mx-2"><img src="<?= validate_image($_settings->userdata('avatar')) ?>"
              class="img-thumbnail rounded-circle" alt="User Avatar" id="client-img-avatar"> <span class="mx-2">Xin
              chào, <?=!empty($_settings->userdata('username')) ? $_settings->userdata('username') :
          $_settings->userdata('email') ?></span>
        </a>
        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
          <a class="dropdown-item" href="./?page=manage_account">Tài khoản của tôi</a>
          <a class="dropdown-item" href="<?= base_url . 'classes/Login.php?f=logout_client' ?>">Đăng xuất</a>
        </div>
      </div>
      <?php else: ?>
      <!-- <a href="./login.php" class="mx-2 text-decoration-none font-weight-bolder" style="color:#54c577">Khách mua</a> -->
      <a href="./vendor" class="mx-2 text-decoration-none font-weight-bolder" style="color:#54c577">Login here</a>
      <!-- <a href="./admin" class="mx-2 text-decoration-none font-weight-bolder" style="color:#54c577">Quản trị</a> -->
      <?php endif; ?>
    </div>
  </div>
</nav>
<nav class="main-header navbar navbar-expand-md navbar-light border-0 text-sm bg-white shadow" id='top-Nav'>

  <div class="container">
    <a href="<?php echo base_url ?>?page=trainee" class="navbar-brand">
      <img src="<?php echo validate_image($_settings->info('logo')) ?>" alt="Site Logo"
        style="max-width:auto; max-height:65px;">
    </a>
    <!-- Right navbar links -->
    <div class="order-1 order-md-3 navbar-nav navbar-no-expand ml-auto">
      <button class="navbar-toggler order-1 border-0 text-sm" type="button" data-toggle="collapse"
        data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false"
        aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
    </div>
  </div>
</nav>
<!-- /.navbar -->
<script>
  $(function () {

  })
</script>