<?php
  require_once('sess_auth.php');
  
?>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" href="<?php echo validate_image($_settings->info('logo')) ?>" />
    <!-- Google Font: Source Sans Pro -->
    <!-- <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&amp;display=fallback"> -->
    <!-- Font Awesome -->
    <link rel="stylesheet" href="<?php echo base_url ?>plugins/fontawesome-free/css/all.min.css">
    <!-- Ionicons -->
    <!-- <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css"> -->
    <!-- Tempusdominus Bootstrap 4 -->
    <link rel="stylesheet" href="<?php echo base_url ?>plugins/tempusdominus-bootstrap-4/css/tempusdominus-bootstrap-4.min.css">
      <!-- DataTables -->
  <link rel="stylesheet" href="<?php echo base_url ?>plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
  <link rel="stylesheet" href="<?php echo base_url ?>plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
  <link rel="stylesheet" href="<?php echo base_url ?>plugins/datatables-buttons/css/buttons.bootstrap4.min.css">
   <!-- Select2 -->
  <link rel="stylesheet" href="<?php echo base_url ?>plugins/select2/css/select2.min.css">
  <link rel="stylesheet" href="<?php echo base_url ?>plugins/select2-bootstrap4-theme/select2-bootstrap4.min.css">
    <!-- iCheck -->
    <link rel="stylesheet" href="<?php echo base_url ?>plugins/icheck-bootstrap/icheck-bootstrap.min.css">
    <!-- JQVMap -->
    <link rel="stylesheet" href="<?php echo base_url ?>plugins/jqvmap/jqvmap.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="<?php echo base_url ?>dist/css/adminlte.css">
    <link rel="stylesheet" href="<?php echo base_url ?>dist/css/custom.css">
    <!-- overlayScrollbars -->
    <link rel="stylesheet" href="<?php echo base_url ?>plugins/overlayScrollbars/css/OverlayScrollbars.min.css">
    <!-- Daterange picker -->
    <link rel="stylesheet" href="<?php echo base_url ?>plugins/daterangepicker/daterangepicker.css">
    <!-- summernote -->
    <link rel="stylesheet" href="<?php echo base_url ?>plugins/summernote/summernote-bs4.min.css">
     <!-- SweetAlert2 -->
  <link rel="stylesheet" href="<?php echo base_url ?>plugins/sweetalert2-theme-bootstrap-4/bootstrap-4.min.css">
    <style type="text/css">/* Chart.js */
      @keyframes chartjs-render-animation{from{opacity:.99}to{opacity:1}}.chartjs-render-monitor{animation:chartjs-render-animation 1ms}.chartjs-size-monitor,.chartjs-size-monitor-expand,.chartjs-size-monitor-shrink{position:absolute;direction:ltr;left:0;top:0;right:0;bottom:0;overflow:hidden;pointer-events:none;visibility:hidden;z-index:-1}.chartjs-size-monitor-expand>div{position:absolute;width:1000000px;height:1000000px;left:0;top:0}.chartjs-size-monitor-shrink>div{position:absolute;width:200%;height:200%;left:0;top:0}
    </style>

     <!-- jQuery -->
    <script src="<?php echo base_url ?>plugins/jquery/jquery.min.js"></script>
    <!-- jQuery UI 1.11.4 -->
    <script src="<?php echo base_url ?>plugins/jquery-ui/jquery-ui.min.js"></script>
    <!-- SweetAlert2 -->
    <script src="<?php echo base_url ?>plugins/sweetalert2/sweetalert2.min.js"></script>
    <!-- Toastr -->
    <script src="<?php echo base_url ?>plugins/toastr/toastr.min.js"></script>
    <script>
        var _base_url_ = '<?php echo base_url ?>';
    </script>
    <script src="<?php echo base_url ?>dist/js/script.js"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=5">
    <link rel="apple-touch-icon" sizes="57x57" href="../uploads/favicons/sheaf-of-rice.png" height="57" width="57">
    <link rel="apple-touch-icon" sizes="60x60" href="../uploads/favicons/sheaf-of-rice.png" height="60" width="60">
    <link rel="apple-touch-icon" sizes="72x72" href="../uploads/favicons/sheaf-of-rice.png" height="72" width="72">
    <link rel="apple-touch-icon" sizes="76x76" href="../uploads/favicons/sheaf-of-rice.png" height="76" width="76">
    <link rel="apple-touch-icon" sizes="114x114" href="../uploads/favicons/sheaf-of-rice.png" height="114" width="114">
    <link rel="apple-touch-icon" sizes="120x120" href="../uploads/favicons/sheaf-of-rice.png" height="120" width="120">
    <link rel="apple-touch-icon" sizes="144x144" href="../uploads/favicons/sheaf-of-rice.png" height="144" width="144">
    <link rel="apple-touch-icon" sizes="152x152" href="../uploads/favicons/sheaf-of-rice.png" height="152" width="152">
    <link rel="apple-touch-icon" sizes="180x180" href="../uploads/favicons/sheaf-of-rice.png" height="180" width="180">
    <link rel="icon" type="image/png" href="../uploads/favicons/sheaf-of-rice.png" sizes="32x32">
    <link rel="icon" type="image/png" href="../uploads/favicons/sheaf-of-rice.png" sizes="194x194">
    <link rel="icon" type="image/png" href="../uploads/favicons/sheaf-of-rice.png" sizes="96x96">
    <link rel="icon" type="image/png" href="../uploads/favicons/sheaf-of-rice.png" sizes="192x192">
    <link rel="icon" type="image/png" href="../uploads/favicons/sheaf-of-rice.png" sizes="16x16">
    <link rel="manifest" href="../uploads/favicons/manifest.json">
    <meta name="msapplication-TileImage" content="../uploads/favicons/sheaf-of-rice.png">
    <meta name="msapplication-config" content="../uploads/favicons/browserconfig.xml">
    <meta name="theme-color" content="#66BB6A">
    <link rel="shortcut icon" href="../uploads/favicons/sheaf-of-rice.png">
    <title>BkFresh | Người bán</title>
    <link rel="canonical" href="./">
  </head>