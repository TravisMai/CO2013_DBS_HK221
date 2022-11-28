<script>
  $(document).ready(function () {
    $('.list-group').each(function () {
      if (String($(this).html()).trim() == "") {
        $(this).html("")
      }
    })

    window.viewer_modal = function ($src = '') {
      start_loader()
      var t = $src.split('.')
      t = t[1]
      if (t == 'mp4') {
        var view = $("<video src='" + $src + "' controls autoplay></video>")
      } else {
        var view = $("<img src='" + $src + "' />")
      }
      $('#viewer_modal .modal-content video,#viewer_modal .modal-content img').remove()
      $('#viewer_modal .modal-content').append(view)
      $('#viewer_modal').modal({
        show: true,
        backdrop: 'static',
        keyboard: false,
        focus: true
      })
      end_loader()

    }
    window.uni_modal = function ($title = '', $url = '', $size = "") {
      start_loader()
      $.ajax({
        url: $url,
        error: err => {
          console.log()
          alert("An error occured")
        },
        success: function (resp) {
          if (resp) {
            $('#uni_modal .modal-title').html($title)
            $('#uni_modal .modal-body').html(resp)
            if ($size != '') {
              $('#uni_modal .modal-dialog').addClass($size + '  modal-dialog-centered')
            } else {
              $('#uni_modal .modal-dialog').removeAttr("class").addClass("modal-dialog modal-md modal-dialog-centered")
            }
            $('#uni_modal').modal({
              show: true,
              backdrop: 'static',
              keyboard: false,
              focus: true
            })
            end_loader()
          }
        }
      })
    }
    window._conf = function ($msg = '', $func = '', $params = []) {
      $('#confirm_modal #confirm').attr('onclick', $func + "(" + $params.join(',') + ")")
      $('#confirm_modal .modal-body').html($msg)
      $('#confirm_modal').modal('show')
    }
  })
</script>
<style>
  body {
    background: #fff;
  }

  .new_footer_area {
    background: #fff;
  }


  .new_footer_top {
    padding: 50px 0px 50px;
    position: relative;
    overflow-x: hidden;
  }

  .new_footer_top .company_widget p {
    font-size: 16px;
    font-weight: 300;
    line-height: 28px;
    color: #6a7695;
    margin-bottom: 20px;
  }

  .new_footer_top .company_widget .f_subscribe_two .btn_get {
    border-width: 1px;
    margin-top: 20px;
  }

  .btn_get_two:hover {
    background: transparent;
    color: #54c577;
  }

  .btn_get:hover {
    color: #fff;
    background: #6754e2;
    border-color: #6754e2;
    -webkit-box-shadow: none;
    box-shadow: none;
  }

  a:hover,
  a:focus,
  .btn:hover,
  .btn:focus,
  button:hover,
  button:focus {
    text-decoration: none;
    outline: none;
  }



  .new_footer_top .f_widget.about-widget .f_list li a:hover {
    color: #54c577;
  }

  .new_footer_top .f_widget.about-widget .f_list li {
    margin-bottom: 11px;
  }

  .f_widget.about-widget .f_list li:last-child {
    margin-bottom: 0px;
  }

  .f_widget.about-widget .f_list li {
    margin-bottom: 15px;
  }

  .f_widget.about-widget .f_list {
    margin-bottom: 0px;
  }

  .new_footer_top .f_social_icon a {
    width: 44px;
    height: 44px;
    line-height: 43px;
    background: transparent;
    border: 1px solid #e2e2eb;
    font-size: 24px;
  }

  .f_social_icon a {
    width: 46px;
    height: 46px;
    border-radius: 50%;
    font-size: 14px;
    line-height: 45px;
    color: #858da8;
    display: inline-block;
    background: #ebeef5;
    text-align: center;
    -webkit-transition: all 0.2s linear;
    -o-transition: all 0.2s linear;
    transition: all 0.2s linear;
  }

  .ti-facebook:before {
    content: "\e741";
  }

  .ti-twitter-alt:before {
    content: "\e74b";
  }

  .ti-vimeo-alt:before {
    content: "\e74a";
  }

  .ti-pinterest:before {
    content: "\e731";
  }

  .btn_get_two {
    -webkit-box-shadow: none;
    box-shadow: none;
    background: #54c577;
    border-color: #54c577;
    color: #fff;
  }

  .btn_get_two:hover {
    background: transparent;
    color: #54c577;
  }

  .new_footer_top .f_social_icon a:hover {
    background: #54c577;
    border-color: #54c577;
    color: white;
  }

  .new_footer_top .f_social_icon a+a {
    margin-left: 4px;
  }

  .new_footer_top .f-title {
    margin-bottom: 30px;
    color: #263b5e;
  }

  .f_600 {
    font-weight: 600;
  }

  .f_size_18 {
    font-size: 18px;
  }

  h1,
  h2,
  h3,
  h4,
  h5,
  h6 {
    color: #4b505e;
  }

  .new_footer_top .f_widget.about-widget .f_list li a {
    color: #6a7695;
  }



  @-moz-keyframes myfirst {
    0% {
      left: -25%;
    }

    100% {
      left: 100%;
    }
  }

  @-webkit-keyframes myfirst {
    0% {
      left: -25%;
    }

    100% {
      left: 100%;
    }
  }

  @keyframes myfirst {
    0% {
      left: -25%;
    }

    100% {
      left: 100%;
    }
  }

  /*************footer End*****************/
</style>
</div>


<footer class="new_footer_area bg_color">
  <div class="new_footer_top">
    <div class="container">
      <div class="row">
        <div class="col-lg-3 col-md-6">
          <div class="f_widget about-widget pl_70 wow fadeInLeft" data-wow-delay="0.2s"
            style="visibility: visible; animation-delay: 0.4s; animation-name: fadeInLeft;">
            <a href="<?php echo base_url ?>">
              <img src="<?php echo base_url ?>./uploads/VFRESH.png" style="width:65%; height:auto;" />
            </a>
            <!--h3 class="f-title f_600 t_color f_size_18">Kết nối với VFresh</h3-->
            <br></br>
            <ul class="list-unstyled f_list">
              <li><a href="https://goo.gl/maps/2eB85GuGJEsxATkh7" target="_blank"><i
                    class="fas fa-map-marker-alt"></i>&nbsp;&nbsp;268 Lý Thường Kiệt, Quận 10, Thành phố Hồ Chí Minh,
                  Việt Nam</a></li>
              <li><a href="#"><i class="fas fa-phone-volume"></i>&nbsp;&nbsp;+84 28 3864 7256</a></li>
              <li><a href="mailto:vfresh@fake.demo.com" target="_blank"><i
                    class="fa fa-paper-plane"></i>&nbsp;&nbsp;vfresh@fake.demo.com</a></li>
            </ul>
          </div>
        </div>
        <div class="col-lg-3 col-md-6">
          <div class="f_widget about-widget pl_70 wow fadeInLeft" data-wow-delay="0.4s"
            style="visibility: visible; animation-delay: 0.4s; animation-name: fadeInLeft;">
            <h3 class="f-title f_600 t_color f_size_18" style="color:#54c577">BkFresh - BKonnect</h3>
            <ul class="list-unstyled f_list">
              <li><a href="./">Trang chủ</a></li>
              <li><a href="./?page=about">Giới thiệu</a></li>
              <li><a href="./?page=products">Sản phẩm</a></li>
              <li><a href="./?page=sellers">Doanh nghiệp</a></li>
            </ul>
          </div>
        </div>
        <div class="col-lg-3 col-md-6">
          <div class="f_widget about-widget pl_70 wow fadeInLeft" data-wow-delay="0.6s"
            style="visibility: visible; animation-delay: 0.6s; animation-name: fadeInLeft;">
            <h3 class="f-title f_600 t_color f_size_18" style="color:#54c577">Tài khoản</h3>
            <ul class="list-unstyled f_list">
              <?php if ($_settings->userdata('id') <= 0): ?>
              <li>
                <a href="./login.php">Đăng nhập</a>
              </li>
              <li>
                <a href="./register.php">Đăng ký</a>
              </li>
              <?php endif; ?>
              <?php if ($_settings->userdata('id') > 0 && $_settings->userdata('login_type') == 3): ?>
              <li>
                <a href="./?page=manage_account">Tài khoản của tôi</a>
              </li>
              <li>
                <?php
                                    $cart_count = $conn->query("SELECT sum(quantity) FROM `cart_list` where client_id = '{$_settings->userdata('id')}'")->fetch_array()[0];
                                    $cart_count = $cart_count > 0 ? $cart_count : 0;
                                    ?>
                <a href="./?page=orders/cart" class="<?= isset($page) && $page == 'orders/cart' ? "active" : "" ?>"><span
                    class="badge badge-secondary rounded-cirlce">
                    <?= format_num($cart_count) ?>
                  </span> Giỏ hàng</a>
              </li>
              <li>
                <a href="./?page=orders/my_orders"
                  class="<?= isset($page) && $page == 'orders/my_orders' ? "active" : "" ?>">Đơn hàng của tôi</a>
              </li>
              <?php endif; ?>
            </ul>
          </div>
        </div>
        <div class="col-lg-3 col-md-6">
          <div class="f_widget social-widget pl_70 wow fadeInLeft" data-wow-delay="0.8s"
            style="visibility: visible; animation-delay: 0.8s; animation-name: fadeInLeft;">
            <h3 class="f-title f_600 t_color f_size_18" style="color:#54c577">Liên kết mạng xã hội</h3>
            <div class="f_social_icon">
              <a href="https://www.facebook.com/cse.hcmut" target="_blank" class="fab fa-facebook"></a>
              <a href="https://github.com/TravisMai" target="_blank" class="fab fa-github"></a>
              <a href="https://www.google.com.vn/search?q=hcmut&ie=UTF-8&oe=UTF-8&hl=en-vn" target="_blank"
                class="fab fa-google"></a>
              <a href="https://www.instagram.com/bachkhoa.hcmut/" target="_blank" class="fab fa-instagram fa-spin"></a>
            </div>
          </div>
          <div class="f_widget social-widget pl_70 wow fadeInLeft" data-wow-delay="0.8s"
            style="visibility: visible; animation-delay: 0.8s; animation-name: fadeInLeft;">
            <?php
                            $sql = "UPDATE Counter SET visits = visits+1 WHERE id = 1";
                            $result = mysqli_query($conn, $sql);

                            $sql = "SELECT visits FROM Counter WHERE id = 1";
                            $result = mysqli_query($conn, $sql);

                            while ($row = $result->fetch_assoc()):
                            ?>
            <br></br>
            <h3 class="f-title f_600 t_color f_size_18" style="color:#54c577">Tổng lượt truy cập: <?= $row['visits'] ?>
                &nbsp;&nbsp;<i class="fas fa-user fa-spin" style="color:#54c577"></i></h3>
            <?php endwhile; ?>
          </div>
        </div>
      </div>
    </div>
  </div>
</footer>
<!-- ./wrapper -->
<div id="libraries">
  <!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
  <script>
    $.widget.bridge('uibutton', $.ui.button)
  </script>
  <!-- Bootstrap 4 -->
  <script src="<?php echo base_url ?>plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
  <!-- ChartJS -->
  <script src="<?php echo base_url ?>plugins/chart.js/Chart.min.js"></script>
  <!-- Sparkline -->
  <script src="<?php echo base_url ?>plugins/sparklines/sparkline.js"></script>
  <!-- Select2 -->
  <script src="<?php echo base_url ?>plugins/select2/js/select2.full.min.js"></script>
  <!-- JQVMap -->
  <script src="<?php echo base_url ?>plugins/jqvmap/jquery.vmap.min.js"></script>
  <script src="<?php echo base_url ?>plugins/jqvmap/maps/jquery.vmap.usa.js"></script>
  <!-- jQuery Knob Chart -->
  <script src="<?php echo base_url ?>plugins/jquery-knob/jquery.knob.min.js"></script>
  <!-- daterangepicker -->
  <script src="<?php echo base_url ?>plugins/moment/moment.min.js"></script>
  <script src="<?php echo base_url ?>plugins/daterangepicker/daterangepicker.js"></script>
  <!-- Tempusdominus Bootstrap 4 -->
  <script src="<?php echo base_url ?>plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
  <!-- Summernote -->
  <script src="<?php echo base_url ?>plugins/summernote/summernote-bs4.min.js"></script>
  <script src="<?php echo base_url ?>plugins/datatables/jquery.dataTables.min.js"></script>
  <script src="<?php echo base_url ?>plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
  <script src="<?php echo base_url ?>plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
  <script src="<?php echo base_url ?>plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>
  <script src="<?php echo base_url ?>plugins/moment/moment.min.js"></script>
  <script src="<?php echo base_url ?>plugins/fullcalendar/main.js"></script>
  <!-- overlayScrollbars -->
  <!-- <script src="<?php echo base_url ?>plugins/overlayScrollbars/js/jquery.overlayScrollbars.min.js"></script> -->
  <!-- AdminLTE App -->
  <script src="<?php echo base_url ?>dist/js/adminlte.js"></script>
</div>
<div class="daterangepicker ltr show-ranges opensright">
  <div class="ranges">
    <ul>
      <li data-range-key="Today">Today</li>
      <li data-range-key="Yesterday">Yesterday</li>
      <li data-range-key="Last 7 Days">Last 7 Days</li>
      <li data-range-key="Last 30 Days">Last 30 Days</li>
      <li data-range-key="This Month">This Month</li>
      <li data-range-key="Last Month">Last Month</li>
      <li data-range-key="Custom Range">Custom Range</li>
    </ul>
  </div>
  <div class="drp-calendar left">
    <div class="calendar-table"></div>
    <div class="calendar-time" style="display: none;"></div>
  </div>
  <div class="drp-calendar right">
    <div class="calendar-table"></div>
    <div class="calendar-time" style="display: none;"></div>
  </div>
  <div class="drp-buttons"><span class="drp-selected"></span><button class="cancelBtn btn btn-sm btn-default"
      type="button">Cancel</button><button class="applyBtn btn btn-sm btn-primary" disabled="disabled"
      type="button">Apply</button> </div>
</div>
<div class="jqvmap-label" style="display: none; left: 1093.83px; top: 394.361px;">Idaho</div>
<script>
  $(function () {
    $('.wrapper>.content-wrapper').css("min-height", $(window).height() - $('#top-Nav').height() - $('#login-nav').height() - $("footer.main-footer").height())
  })
</script>