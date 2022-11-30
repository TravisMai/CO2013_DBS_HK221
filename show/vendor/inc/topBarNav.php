<style>
  .user-img{
        position: absolute;
        height: 27px;
        width: 27px;
        object-fit: cover;
        left: -7%;
        top: -12%;
  }
  .btn-rounded{
        border-radius: 50px;
  }
</style>
<!-- Navbar -->
      <nav class="main-header navbar navbar-expand navbar-light text-sm shadow">
        <!-- Left navbar links -->
        <ul class="navbar-nav">
          <li class="nav-item">
          <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
          </li>
          <li class="nav-item d-none d-sm-inline-block">
            <a href="<?php echo base_url ?>" class="nav-link"><?php echo (!isMobileDevice()) ? $_settings->info('name'):$_settings->info('short_name'); ?>  Manager site</a>
          </li>
        </ul>
        <!-- Right navbar links -->
        <ul class="navbar-nav ml-auto">
          <li class="nav-item">
            <div class="btn-group nav-link">
                  <button type="button" class="btn btn-rounded badge badge-light">
                    <span class="ml-3"><?php echo ucwords($_settings->userdata('username')) ?></span>
                  </button>
                  <a href="<?php echo base_url.'/classes/Login.php?f=logout_vendor' ?>"><span class="fas fa-sign-out-alt"></span> Logout</a>
                    
              </div>
          </li>
          <li class="nav-item">
            
          </li>
        </ul>
      </nav>