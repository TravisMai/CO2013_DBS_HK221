<?php
$category_ids = isset($_GET['cids']) ? $_GET['cids'] : 'all';
?>
<div class="content py-3">
    <div class="row">
        <!-- <div class="col-md-4">
            <div class="card card-outline rounded-0 card-primary shadow">
                <div class="card-body">
                    <div class="list-group">
                        <div class="list-group-item list-group-item-action">
                            <div class="custom-control custom-checkbox">
                                <input
                                    class="custom-control-input custom-control-input-primary custom-control-input-outline cat_all"
                                    type="checkbox" id="cat_all" <?=!is_array($category_ids) && $category_ids == 'all' ? 
    "checked" : "" ?>>
                                <label for="cat_all" class="custom-control-label"> Tất cả</label>
                            </div>
                        </div>
                        <?php
                        $categories = $conn->query("SELECT * FROM `season` order by `SYear` desc ");
                        while ($row = $categories->fetch_assoc()):
                        ?>
                        <div class="list-group-item list-group-item-action">
                            <div class="custom-control custom-checkbox">
                                <input
                                    class="custom-control-input custom-control-input-primary custom-control-input-outline cat_item"
                                    type="checkbox" id="cat_item<?= $row['SYear'] ?>" <?=
                                in_array($row['SYear'], explode(',', $category_ids)) ? "checked" : '' ?> value="<?=
                                $row['SYear'] ?>">
                                    <label for="cat_item<?= $row['SYear'] ?>" class="custom-control-label">
                                        <?= $row['SYear'] ?> - <?= $row['Location'] ?>
                                    </label>
                            </div>
                        </div>
                        <?php endwhile; ?>
                    </div>
                </div>
            </div>
        </div>
        <p> </p> -->
        <div class="col-md-12">
            <div class="card card-outline card-primary shadow rounded-0">
                <div class="card-body">
                    <div class="container-fluid">
                        <div class="row justify-content-center mb-3">
                            <div class="col-lg-8 col-md-10 col-sm-12">
                                <form action="" id="search-frm">
                                    <div class="input-group">
                                        <div class="input-group-prepend"><span class="input-group-text"
                                                style="background-color:#C7F2A4">Search</span></div>
                                        <input type="search" id="search" class="form-control"
                                            value="<?= isset($_GET['search']) ? $_GET['search'] : '' ?>">
                                        <div class="input-group-append"><span class="input-group-text"
                                                style="background-color:#C7F2A4"><i class="fa fa-search"></i></span>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="row" id="product_list">
                            <?php
                            $swhere = "";
                            if (!empty($category_ids)):
                                // if ($category_ids != 'all') {
                                //     $swhere = " and t.Ssn in ({$category_ids}) ";
                                // }
                                if (isset($_GET['search']) && !empty($_GET['search'])) {
                                    $swhere .= " and (p.Fname LIKE '%{$_GET['search']}%' or p.Lname LIKE '%{$_GET['search']}%' or (concat(p.Fname,' ',p.Lname) LIKE '%{$_GET['search']}%') )";
                                }
                            
                            $trainee = $conn->query("SELECT DISTINCT t.*, st.Syear as syear, p.Fname as fname, p.Lname as lname, p.PAddress as `address`, p.Phone as phone FROM `trainee` t inner join `seasontrainee` st on st.Ssn_trainee=t.Ssn inner join `season` s on st.Syear=s.SYear inner join person p on p.Ssn=t.Ssn where  t.Ssn != 0 {$swhere} order by RAND()");
                            while ($row = $trainee->fetch_assoc()):
                            ?>
                            <div class="col-lg-3 col-md-4 col-sm-8 product-item">
                                <a href="./?page=trainee/view_trainee&Ssn=<?= $row['Ssn'] ?>"
                                    class="card shadow rounded-0 text-reset text-decoration-none">
                                    <div class="product-img-holder position-relative">
                                        <img src="<?= validate_image($row['Photo']) ?>" alt="Product-image"
                                            class="img-top product-img" style="background-color:#f2faf4">
                                    </div>
                                    <div class="card-body border-top border-gray">
                                        <h5 class="card-title text-truncate w-100">
                                            <?= $row['fname'] ?>
                                                <?= $row['lname'] ?>
                                        </h5>
                                        <!-- <div class="d-flex w-100">
                                            <div class="col-auto px-0"><small class="text-muted">Ssn: &nbsp
                                                </small></div>
                                            <div class="col-auto px-0 flex-shrink-1 flex-grow-1">
                                                <p class="text-truncate m-0"><small class="text-muted">
                                                        <?= $row['Ssn'] ?>
                                                    </small></p>
                                            </div>
                                        </div>
                                        <div class="d-flex">
                                            <div class="col-auto px-0"><small class="text-muted">Date of birth: &nbsp
                                                </small></div>
                                            <div class="col-auto px-0 flex-shrink-1 flex-grow-1">
                                                <p class="text-truncate m-0"><small class="text-muted">
                                                        <?= $row['DoB'] ?>
                                                    </small></p>
                                            </div>
                                        </div>
                                        <div class="d-flex">
                                            <div class="col-auto px-0"><small class="text-muted">Company: &nbsp
                                                </small></div>
                                            <div class="col-auto px-0 flex-shrink-1 flex-grow-1">
                                                <p class="text-truncate m-0"><small class="text-muted">
                                                        <?= $row['Company_ID'] ?>
                                                    </small></p>
                                            </div>
                                        </div>
                                        <div class="d-flex">
                                            <div class="col-auto px-0"><small class="text-muted">Year: &nbsp
                                                </small></div>
                                            <div class="col-auto px-0 flex-shrink-1 flex-grow-1">
                                                <p class="text-truncate m-0"><small class="text-muted">
                                                        <?= $row['syear'] ?>
                                                    </small></p>
                                            </div>
                                        </div>
                                        <div class="d-flex">
                                            <div class="col-auto px-0"><small class="text-muted">Phone: &nbsp
                                                </small></div>
                                            <div class="col-auto px-0 flex-shrink-1 flex-grow-1">
                                                <p class="text-truncate m-0"><small class="text-muted">
                                                        <?= $row['phone'] ?>
                                                    </small></p>
                                            </div>
                                        </div>
                                        <div class="d-flex">
                                            <div class="col-auto px-0"><small class="text-muted">Address: &nbsp
                                                </small></div>
                                            <div class="col-auto px-0 flex-shrink-1 flex-grow-1">
                                                <p class="card-text truncate-3 w-100"><small class="text-muted">
                                                        <?= $row['address'] ?>
                                                    </small></p>
                                            </div>
                                        </div> -->
                                    </div>
                                </a>
                            </div>
                            <?php endwhile; ?>
                            <?php else: ?>
                            <div class="col-12 text-center">
                                Invalid
                            </div>
                            <?php endif; ?>
                        </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(function () {
        if ($('#cat_all').is(':checked') == true) {
            $('.cat_item').prop('checked', true)
        }
        if ($('.cat_item:checked').length == $('.cat_item').length) {
            $('#cat_all').prop('checked', true)
        }
        $('.cat_item').change(function () {
            var ids = [];
            $('.cat_item:checked').each(function () {
                ids.push($(this).val())
            })
            location.href = "./?page=trainee&cids=" + (ids.join(","))
        })
        $('#cat_all').change(function () {
            if ($(this).is(':checked') == true) {
                $('.cat_item').prop('checked', true)
            } else {
                $('.cat_item').prop('checked', false)
            }
            $('.cat_item').trigger('change')
        })
        $('#search-frm').submit(function (e) {
            e.preventDefault()
            var q = "search=" + $('#search').val()
            if ('<?=!empty($category_ids) && $category_ids != 'all' ?>' == 1) {
                q += "&cids=<?= $category_ids ?>"
            }
            location.href = "./?page=trainee&" + q;

        })
    })
</script>