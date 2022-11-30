<?php
if (isset($_GET['Ssn']) && $_GET['Ssn'] > 0) {
    $qry = $conn->query("SELECT DISTINCT t.*, st.Syear as syear, p.Fname as fname, p.Lname as lname, p.PAddress as `address`, p.Phone as phone, count(st.Syear) as cyear FROM `trainee` t inner join `seasontrainee` st on st.Ssn_trainee=t.Ssn inner join `season` s on st.Syear=s.SYear inner join person p on p.Ssn=t.Ssn where  t.Ssn != 0 and t.Ssn = '{$_GET['Ssn']}'");
    if ($qry->num_rows > 0) {
        foreach ($qry->fetch_assoc() as $k => $v) {
            $$k = $v;
        }
    } else {
        echo "<script> alert('Unkown Ssn.'); location.replace('./?page=trainee') </script>";
        exit;
    }
} else {
    echo "<script> alert('Ssn is required.'); location.replace('./?page=trainee') </script>";
    exit;
}
?>
<style>
    #prod-img-holder {
        height: 45vh !important;
        width: calc(100%);
        overflow: hidden;
    }

    #prod-img {
        object-fit: scale-down;
        height: calc(100%);
        width: calc(100%);
        transition: transform .3s ease-in;
    }

    #prod-img-holder:hover #prod-img {
        transform: scale(1.2);
    }
</style>


<div class="content py-3">
    <div class="card card-outline card-primary rounded-0 shadow">
        <div class="card-header">
            <h2 class="card-title"><b>Trainee's detail infomation</b></h2>
        </div>
        <div class="card-body">
            <div class="container-fluid">
                <div id="msg"></div>
                <div class="row">
                    <div class="col-lg-4 col-md-5 col-sm-12 text-center">
                        <div class="position-relative overflow-hidden" id="prod-img-holder">
                            <img src="<?= validate_image(isset($Photo) ? $Photo : "") ?>" id="prod-img"
                                class="img-thumbnail" style="background-color:#f2faf4">
                        </div>
                    </div>
                    <div class="col-lg-8 col-md-7 col-sm-12">
                        <h3><b>
                                <?= $fname ?>
                                    <?= $lname ?> &nbsp;
                            </b><i class="fas fa-user-tie fa-spin" style="color:#54c577"></i></h3>
                        <div class="d-flex w-100" style="padding-bottom:10px">
                            <div class="col-auto px-0">Ssn: &nbsp; </div>
                                <h5 class="card-title text-truncate w-100 hah">
                                        <?= $Ssn ?> &nbsp;
                                    </h5>
                        </div>
                        <div class="d-flex" style="padding-bottom:10px">
                            <div class="col-auto px-0">Date of birth: &nbsp; </div>
                            <div class="col-auto px-0 flex-shrink-1 flex-grow-1">
                                <p class="m-0">
                                        <?= $DoB ?>
                                    </p>
                            </div>
                        </div>
                        <div class="d-flex" style="padding-bottom:10px">
                            <div class="col-auto px-0">Company: &nbsp; </div>
                            <div class="col-auto px-0 flex-shrink-1 flex-grow-1">
                                <p class="m-0">
                                        <?= $Company_ID ?>
                                    </p>
                            </div>
                        </div>
                        
                        <div class="d-flex" style="padding-bottom:10px">
                            <div class="col-auto px-0">Phone: &nbsp; </div>
                            <div class="col-auto px-0 flex-shrink-1 flex-grow-1">
                                <p class="m-0">
                                        <?= $phone ?>
                                    </p>
                            </div>
                        </div>
                        <div class="d-flex" style="padding-bottom:10px">
                            <div class="col-auto px-0">Address: &nbsp; </div>
                            <div class="col-auto px-0 flex-shrink-1 flex-grow-1">
                                <p class="m-0">
                                        <?= $address ?>
                                    </p>
                            </div>
                        </div>
                        <div class="d-flex" style="padding-bottom:10px">
                            <div class="col-auto px-0">Best result season: &nbsp; </div>
                            <div class="col-auto px-0 flex-shrink-1 flex-grow-1">
                                    <?= 
                                        $swhere = "";
                                        $swhere .= "sit.Ssn_trainee ='{$_GET['Ssn']}'";
                                        
                                        $bestresult = $conn->query("SELECT sit.SYear as best_year FROM stageincludetrainee sit WHERE {$swhere} ORDER BY sit.Ep_No DESC LIMIT 1;");
                                        $row = $bestresult->fetch_assoc();
                                    ?>
                                <p class="m-0">
                                <?= isset($row['best_year']) ? $row['best_year'] : 'No result' ?>
                                </p>
                            </div>
                        </div>
                        <div class="d-flex" style="padding-bottom:10px">
                            <div class="col-auto px-0">Joined season: &nbsp; </div>
                            <div class="col-auto px-0 flex-shrink-1 flex-grow-1">
                                <p class="m-0">
                                        <?= $cyear ?>
                                    </p>
                                        <?= 
                                        $swhere = "";
                                        $swhere .= "st.Ssn_trainee ='{$_GET['Ssn']}'";
                                        
                                        $trainee = $conn->query("SELECT DISTINCT st.Syear as syear FROM `seasontrainee` st where {$swhere}");
                                        while ($row = $trainee->fetch_assoc()):
                                        ?>
                                        <a class="text" href="javascript:void(0)"
                                        data-year="<?= $row['syear'] ?>" data-ssn="<?= $Ssn ?>">
                                        
                                                <?= $row['syear'] ?> &nbsp;
                                            
                                        </a>
                                        <?php endwhile; ?>
                            </div>
                            
                        </div>
                        
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<script>
    $('.text').click(function () {
        uni_modal("Result in season " + $(this).attr('data-year') , "trainee/view_trainee_result.php?year=" + $(this).attr('data-year') + "&ssn=" + $(this).attr('data-ssn'), 'mid-large')
    });
    
</script>

