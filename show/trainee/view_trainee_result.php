<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
        integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"
        integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous" />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"
        integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
        integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
        crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
        integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
        crossorigin="anonymous"></script>
</head>

<style>
    #uni_modal .modal-footer {
        display: none
    }

    .prod-img {
        width: calc(100%);
        height: auto;
        max-height: 10em;
        object-fit: scale-down;
        object-position: center center
    }

    .tablecolor {
        background-color: #54c577;
        color: #fff;
    }

    .progress-label-left {
        float: left;
        margin-right: 0.5em;
        line-height: 1em;
    }

    .progress-label-right {
        float: right;
        margin-left: 0.3em;
        line-height: 1em;
    }

    .star-light {
        color: #e9ecef;
    }
</style>

<div class="container-fluid">
    <div class="row">
        <div class="col-3 border tablecolor"><span class="">Episode</span></div>
        
        <div class="col-3 border tablecolor"><span class="">Result</span></div>
        
               
    </div>
    
</div>


<?php
require_once('./../config.php');
if (isset($_GET['year']) && isset($_GET['ssn'])) {
    $qry = $conn->query("CALL trainee_result('{$_GET['year']}','{$_GET['ssn']}') ");
  
    while($row = $qry->fetch_assoc()) {
        
?>


<div class="container-fluid">
    <div class="row">
        <div class="col-3 border"><span class="font-weight-bolder">
                <?= isset($row['Episode']) ? $row['Episode'] : '' ?>
            </span></div>
            
        <div class="col-3 border"><span class="font-weight-bolder">
                <?= isset($row['Result']) ? $row['Result'] : 'No result' ?>
            </span></div>
               
    </div>
    
</div>

<?php } ?>


<div class="clear-fix mb-3"></div>
<div class="text-right">
    <button class="btn btn-default bg-gradient-dark text-light btn-sm btn-flat" type="button" data-dismiss="modal"><i
            class="fa fa-times"></i> Close</button>
</div>
</div>

<?php
        
        exit;
    
}
?>