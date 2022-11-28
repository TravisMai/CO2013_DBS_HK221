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
    <a href="<?php echo base_url ?>" class="navbar-brand">
      <img src="<?php echo validate_image($_settings->info('logo')) ?>" alt="Site Logo"
        style="max-width:200px; max-height:auto;">
    </a>



    <div class="collapse navbar-collapse order-3" id="navbarCollapse">
      <!-- Left navbar links -->
      <ul class="navbar-nav">
        <li class="nav-item">
          <a href="./" class="nav-link <?= isset($page) && $page == 'home' ? "active" : "" ?>"
            style="color: <?= isset($page) && $page == 'home' ? "#54c577" : "#000" ?>">Trang chủ</a>
        </li>
        <li class="nav-item">
          <a href="./?page=about" class="nav-link <?= isset($page) && $page == 'about' ? "active" : "" ?>"
            style="color: <?= isset($page) && $page == 'about' ? "#54c577" : "#000" ?>">Giới thiệu</a>
        </li>
        <li class="nav-item">
          <a href="./?page=products" class="nav-link <?= isset($page) && $page == 'products' ? "active" : "" ?>"
            style="color: <?= isset($page) && $page == 'products' ? "#54c577" : "#000" ?>">Sản phẩm</a>
        </li>
        <li class="nav-item">
          <a href="./?page=sellers" class="nav-link <?= isset($page) && $page == 'sellers' ? "active" : "" ?>"
            style="color: <?= isset($page) && $page == 'sellers' ? "#54c577" : "#000" ?>">Doanh nghiệp</a>
        </li>
        <?php if ($_settings->userdata('id') > 0 && $_settings->userdata('login_type') == 3): ?>
        <li class="nav-item">
          <?php
          $cart_count = $conn->query("SELECT sum(quantity) FROM `cart_list` where client_id = '{$_settings->userdata('id')}'")->fetch_array()[0];
          $cart_count = $cart_count > 0 ? $cart_count : 0;
          ?>
          <a href="./?page=orders/cart" class="nav-link <?= isset($page) && $page == 'orders/cart' ? "active" : "" ?>"
            style="color: <?= isset($page) && $page == 'orders/cart' ? "#54c577" : "#000" ?>"><span
              class="badge badge-secondary rounded-cirlce" style="background-color:#54c577">
              <?= format_num($cart_count) ?>
            </span> Giỏ hàng</a>
        </li>
        <li class="nav-item">
          <a href="./?page=orders/my_orders"
            class="nav-link <?= isset($page) && $page == 'orders/my_orders' ? "active" : "" ?>"
            style="color: <?= isset($page) && $page == 'orders/my_orders' ? "#54c577" : "#000" ?>">Đơn hàng của tôi</a>
        </li>
        <?php endif; ?>
      </ul>
    </div>
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