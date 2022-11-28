<?php
if (isset($_GET['id']) && $_GET['id'] > 0) {
    $qry = $conn->query("SELECT  p.*, v.shop_name as vendor, v.id as shop_id,  c.name as `category` FROM `product_list` p inner join vendor_list v on p.vendor_id = v.id inner join category_list c on p.category_id = c.id where p.delete_flag = 0 and p.id = '{$_GET['id']}'");
    if ($qry->num_rows > 0) {
        foreach ($qry->fetch_assoc() as $k => $v) {
            $$k = $v;
        }
    } else {
        echo "<script> alert('Unkown Product ID.'); location.replace('./?page=products') </script>";
        exit;
    }
} else {
    echo "<script> alert('Product ID is required.'); location.replace('./?page=products') </script>";
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

    .hah {}

    .hah:hover {
        background-color: #C7F2A4;
    }
</style>
<div class="content py-3">
    <div class="card card-outline card-primary rounded-0 shadow">
        <div class="card-header">
            <h5 class="card-title"><b>Chi tiết sản phẩm</b></h5>
        </div>
        <div class="card-body">
            <div class="container-fluid">
                <div id="msg"></div>
                <div class="row">
                    <div class="col-lg-4 col-md-5 col-sm-12 text-center">
                        <div class="position-relative overflow-hidden" id="prod-img-holder">
                            <img src="<?= validate_image(isset($image_path) ? $image_path : "") ?>"
                                alt="<?= $row['name'] ?>" id="prod-img" class="img-thumbnail"
                                style="background-color:#f2faf4">
                        </div>
                    </div>
                    <div class="col-lg-8 col-md-7 col-sm-12">
                        <h3><b>
                                <?= $name ?>
                            </b></h3>
                        <div class="d-flex w-100">
                            <div class="col-auto px-0"><small class="text-muted">Người bán: &nbsp; </small></div>
                            <a href="./?page=sellers/view_seller&id=<?= $vendor_id ?>">
                                <h5 class="card-title text-truncate w-100 hah"><small class="text-muted">
                                        <?= $vendor ?> &nbsp;
                                    </small><i class="fas fa-user-tie fa-spin" style="color:#54c577"></i></h5>
                            </a>
                        </div>
                        <div class="d-flex">
                            <div class="col-auto px-0"><small class="text-muted">Danh mục: &nbsp; </small></div>
                            <div class="col-auto px-0 flex-shrink-1 flex-grow-1">
                                <p class="m-0"><small class="text-muted">
                                        <?= $category ?>
                                    </small></p>
                            </div>
                        </div>
                        <div class="d-flex">
                            <div class="col-auto px-0"><small class="text-muted">Giá mong muốn: &nbsp; </small></div>
                            <div class="col-auto px-0 flex-shrink-1 flex-grow-1">
                                <p class="m-0 pl-3"><small class="text-primary">
                                        <?= format_num($price) ?>
                                    </small></p>
                            </div>
                        </div>
                        <div class="row align-items-end">
                            <div class="col-md-3 form-group">
                                <input type="number" min="1" id='qty' value="1"
                                    class="form-control rounded-0 text-center">
                            </div>
                            <div class="col-md-3 form-group">
                                <button class="btn btn-primary btn-flat" type="button" id="add_to_cart"
                                    style="background-color:#54c577"><i class="fa fa-cart-plus"></i> Thêm vào giỏ
                                    hàng</button>
                            </div>
                        </div>
                        <div class="w-100">
                            <?= html_entity_decode($description) ?>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function add_to_cart() {
        var pid = '<?= isset($id) ? $id : '' ?>';
        var qty = $('#qty').val();
        var el = $('<div>')
        el.addClass('alert alert-danger')
        el.hide()
        $('#msg').html('')
        start_loader()
        $.ajax({
            url: _base_url_ + 'classes/Master.php?f=add_to_cart',
            method: 'POST',
            data: { product_id: pid, quantity: qty },
            dataType: 'json',
            error: err => {
                console.error(err)
                alert_toast('An error occurred.', 'error')
                end_loader()
            },
            success: function (resp) {
                if (resp.status == 'success') {
                    location.reload()
                } else if (!!resp.msg) {
                    el.text(resp.msg)
                    $('#msg').append(el)
                    el.show('slow')
                    $('html, body').scrollTop(0)
                } else {
                    el.text("An error occurred. Please try to refresh this page.")
                    $('#msg').append(el)
                    el.show('slow')
                    $('html, body').scrollTop(0)
                }
                end_loader()
            }
        })
    }
    $(function () {
        $('#add_to_cart').click(function () {
            if ('<?= $_settings->userdata('id') > 0 && $_settings->userdata('login_type') == 3 ?>') {
                add_to_cart();
            } else {
                location.href = "./login.php"
            }
        })
    })
</script>