<style>

</style>

<script>
    function resizeIframe(obj) {
        obj.style.height = obj.contentWindow.document.documentElement.scrollHeight + 'px';
    }
</script>

<!--div class=" py-5">
    <div class="contain-fluid">
        <div class="clear-fix mb-3"></div>
        <h3 class="text-center" style="color:#54c577"><b><i class="fa fa-newspaper"></i>&nbsp; Tin tức nông sản</b></h3>
        <center><hr class="w-25"></center>
        <div align="center"><iframe width=100% height="500" src="https://rss.app/embed/v1/carousel/OasTpOGOQkwlAW79" frameborder="0"></iframe></div>
    </div>
</div-->

<!-- <div class=" py-5">
    <div class="contain-fluid">
        <div class="clear-fix mb-3"></div>
        <h3 class="text-center" style="color:#54c577"><b><i class="fa fa-newspaper"></i>&nbsp; Xmas Vibe</b></h3>
        <center><hr class="w-25"></center>
        <div align="center"><iframe src="https://www.facebook.com/plugins/video.php?height=420&href=https%3A%2F%2Fwww.facebook.com%2FweareMusicUSUK%2Fvideos%2F839195020733012%2F&show_text=false&width=560&t=0" width="560" height="420" style="border:none;overflow:hidden" scrolling="no" frameborder="0" allowfullscreen="true" allow="autoplay; clipboard-write; encrypted-media; picture-in-picture; web-share" allowFullScreen="true"></iframe></div>
    </div>
</div> -->

<div class="row">
<div class="contain-fluid col-md-6">
        <div class="clear-fix mb-3"></div>
        <h3 class="text-center" style="color:#54c577"><b>Không thể cản phá</b></h3>
        <center>
            <hr class="w-25">
        </center>
        <div align="center"><iframe style="border-radius:12px" src="https://open.spotify.com/embed/track/6q0O3OYHF9IkabfMH1IDaj?utm_source=generator" width="100%" height="352" frameBorder="0" allowfullscreen="" allow="autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture" loading="lazy"></iframe></div>
    </div>
    <div class="contain-fluid col-md-6">
        <div class="clear-fix mb-3"></div>
        <h3 class="text-center" style="color:#54c577"><b>Random Panther Shit</b></h3>
        <center>
            <hr class="w-25">
        </center>
        <div align="center"><iframe style="border-radius:12px" src="https://open.spotify.com/embed/track/2LSsSV7V33wM9EKQA2xjGS?utm_source=generator" width="100%" height="352" frameBorder="0" allowfullscreen="" allow="autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture" loading="lazy"></iframe></div>
    </div>
</div>

<div class="col-lg-12 py-5">
    <div class="contain-fluid">
        <div class="clear-fix mb-3"></div>
        <h3 class="text-center" style="color:#54c577"><b>Doanh nghiệp</b></h3>
        <center>
            <hr class="w-25">
        </center>
        <div class="row" id="product_list">
            <?php
            $products = $conn->query("SELECT DISTINCT v.*, s.name as shop_type_name, p.vendor_id as 'seller_id' FROM `product_list` p inner join vendor_list v on p.vendor_id = v.id inner join shop_type_list s on s.id = v.shop_type_id where v.delete_flag = 0 and v.`status` =1 order by RAND() limit 4");
            while ($row = $products->fetch_assoc()):
            ?>
            <div class="col-lg-3 col-md-6 col-sm-12 product-item">
                <a href="./?page=sellers/view_seller&id=<?= $row['seller_id'] ?>"
                    class="card shadow rounded-0 text-reset text-decoration-none">
                    <div class="product-img-holder position-relative">
                        <img src="<?= validate_image($row['avatar']) ?>" alt="Product-image" class="img-top product-img"
                            style="background-color:#f2faf4">
                    </div>
                    <div class="card-body border-top border-gray">
                        <h5 class="card-title text-truncate w-100">
                            <?= $row['shop_name'] ?>
                        </h5>
                        <div class="d-flex w-100">
                            <div class="col-auto px-0"><small class="text-muted">Chủ doanh nghiệp: &nbsp; </small></div>
                            <div class="col-auto px-0 flex-shrink-1 flex-grow-1">
                                <p class="text-truncate m-0"><small class="text-muted">
                                        <?= $row['shop_owner'] ?>
                                    </small></p>
                            </div>
                        </div>
                        <div class="d-flex">
                            <div class="col-auto px-0"><small class="text-muted">Lĩnh vực: &nbsp; </small></div>
                            <div class="col-auto px-0 flex-shrink-1 flex-grow-1">
                                <p class="text-truncate m-0"><small class="text-muted">
                                        <?= $row['shop_type_name'] ?>
                                    </small></p>
                            </div>
                        </div>
                        <?php if ($_settings->userdata('id') > 0 && $_settings->userdata('login_type') == 3): ?>
                        <div class="d-flex">
                            <div class="col-auto px-0"><small class="text-muted">Điện thoại: &nbsp; </small></div>
                            <div class="col-auto px-0 flex-shrink-1 flex-grow-1">
                                <p class="text-truncate m-0"><small class="text-muted">
                                        <?= $row['contact'] ?>
                                    </small></p>
                            </div>
                        </div>
                        <div class="d-flex">
                            <div class="col-auto px-0"><small class="text-muted">Email: &nbsp; </small></div>
                            <div class="col-auto px-0 flex-shrink-1 flex-grow-1">
                                <p class="text-truncate m-0"><small class="text-muted">
                                        <?= $row['email'] ?>
                                    </small></p>
                            </div>
                        </div>
                        <?php endif; ?>
                    </div>
                </a>
            </div>
            <?php endwhile; ?>
        </div>
        <div class="text-center">
            <a href="./?page=sellers" class="btn btn-large btn-primary rounded-pill col-lg-3 col-md-5 col-sm-12"
                style="background-color:#54c577; border-color:#54c577">Khám phá thêm doanh nghiệp</a>
        </div>
    </div>
</div>

<div class="col-lg-12 py-5">
    <div class="contain-fluid">
        <div class="clear-fix mb-3"></div>
        <h3 class="text-center" style="color:#54c577"><b>Sản phẩm</b></h3>
        <center>
            <hr class="w-25">
        </center>
        <div class="row" id="product_list">
            <?php
            $products = $conn->query("SELECT p.*, v.shop_name as vendor, c.name as `category` FROM `product_list` p inner join vendor_list v on p.vendor_id = v.id inner join category_list c on p.category_id = c.id where p.delete_flag = 0 and p.`status` =1 order by RAND() limit 8");
            while ($row = $products->fetch_assoc()):
            ?>
            <div class="col-lg-3 col-md-6 col-sm-12 product-item">
                <a href="./?page=products/view_product&id=<?= $row['id'] ?>"
                    class="card shadow rounded-0 text-reset text-decoration-none">
                    <div class="product-img-holder position-relative">
                        <img src="<?= validate_image($row['image_path']) ?>" alt="Product-image"
                            class="img-top product-img" style="background-color:#f2faf4">
                    </div>
                    <div class="card-body border-top border-gray">
                        <h5 class="card-title text-truncate w-100">
                            <?= $row['name'] ?>
                        </h5>
                        <div class="d-flex w-100">
                            <div class="col-auto px-0"><small class="text-muted">Người bán: &nbsp </small></div>
                            <div class="col-auto px-0 flex-shrink-1 flex-grow-1">
                                <p class="text-truncate m-0"><small class="text-muted">
                                        <?= $row['vendor'] ?>
                                    </small></p>
                            </div>
                        </div>
                        <div class="d-flex">
                            <div class="col-auto px-0"><small class="text-muted">Danh mục: &nbsp </small></div>
                            <div class="col-auto px-0 flex-shrink-1 flex-grow-1">
                                <p class="text-truncate m-0"><small class="text-muted">
                                        <?= $row['category'] ?>
                                    </small></p>
                            </div>
                        </div>
                        <div class="d-flex">
                            <div class="col-auto px-0"><small class="text-muted">Giá mong muốn: &nbsp </small></div>
                            <div class="col-auto px-0 flex-shrink-1 flex-grow-1">
                                <p class="m-0 pl-3"><small class="text-primary">
                                        <?= format_num($row['price']) ?>
                                    </small></p>
                            </div>
                        </div>
                        <p class="card-text truncate-3 w-100">
                            <?= strip_tags(html_entity_decode($row['description'])) ?>
                        </p>
                    </div>
                </a>
            </div>
            <?php endwhile; ?>
        </div>
        <div class="clear-fix mb-2"></div>
        <div class="text-center">
            <a href="./?page=products" class="btn btn-large btn-primary rounded-pill col-lg-3 col-md-5 col-sm-12"
                style="background-color:#54c577; border-color:#54c577">Khám phá thêm sản phẩm</a>
        </div>
    </div>
</div>


<div class="row">
    <div class="contain-fluid col-md-6">
        <div class="clear-fix mb-3"></div>
        <h3 class="text-center" style="color:#54c577"><b>Sản phẩm trên BkFresh</b></h3>
        <center>
            <hr class="w-25">
        </center>
        <?php
        $link = mysqli_connect("localhost", "root", "");
        mysqli_select_db($link, "bkfresh");
        $test = array();
        $count = 0;
        $res = mysqli_query($link, "SELECT stl.name, count(*) FROM product_list pl join vendor_list vl on pl.vendor_id = vl.id join shop_type_list stl on vl.shop_type_id = stl.id GROUP BY stl.name;");
        while ($row = mysqli_fetch_array($res)) {
            $test[$count]["label"] = $row["name"];
            $test[$count]["y"] = $row["count(*)"];
            $count = $count + 1;
        }
        $test1 = array();
        $count1 = 0;
        $res1 = mysqli_query($link, "SELECT stl.name, count(*) FROM vendor_list vl join shop_type_list stl on vl.shop_type_id = stl.id GROUP BY stl.name;");
        while ($row1 = mysqli_fetch_array($res1)) {
            $test1[$count1]["label"] = $row1["name"];
            $test1[$count1]["y"] = $row1["count(*)"];
            $count1 = $count1 + 1;
        }
        ?>
        <!DOCTYPE HTML>
        <html>

        <head>
            <script>
                window.onload = function () {

                    var chart1 = new CanvasJS.Chart("chartContainer1", {
                        animationEnabled: true,
                        exportEnabled: false,
                        backgroundColor: "#f4f6f9",
                        fontFamily: "Times New Roman",
                        data: [{
                            type: "doughnut",
                            showInLegend: "true",
                            legendText: "{label}",
                            indexLabelFontSize: 16,
                            indexLabel: "{label} - #percent%",
                            yValueFormatString: "####### sản phẩm",
                            dataPoints: <?php echo json_encode($test, JSON_NUMERIC_CHECK); ?>
            }]
        });
                var chart2 = new CanvasJS.Chart("chartContainer2", {
                    animationEnabled: true,
                    exportEnabled: false,
                    backgroundColor: "#f4f6f9",
                    fontFamily: "Times New Roman",
                    data: [{
                        type: "doughnut",
                        showInLegend: "true",
                        legendText: "{label}",
                        indexLabelFontSize: 16,
                        indexLabel: "{label} - #percent%",
                        yValueFormatString: "####### đối tác",
                        dataPoints: <?php echo json_encode($test1, JSON_NUMERIC_CHECK); ?>
            }]
        });
                chart1.render();
                chart2.render();
        }
            </script>
        </head>

        <body>
            <div id="chartContainer1" style="height: 370px; width: 100%;"></div>
            <script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
        </body>

        </html>
    </div>
    <div class="contain-fluid col-md-6">
        <div class="clear-fix mb-3"></div>
        <h3 class="text-center" style="color:#54c577"><b>Các đối tác của BkFresh</b></h3>
        <center>
            <hr class="w-25">
        </center>
        <div id="chartContainer2" style="height: 370px; width: 100%;"></div>
    </div>
</div>

<div class=" py-5">
    <div class="contain-fluid">
        <div class="clear-fix mb-3"></div>
        <h3 class="text-center" style="color:#54c577"><b><i class="	fas fa-route"></i>&nbsp; BkFresh ở đâu ?</b></h3>
        <center>
            <hr class="w-25">
        </center>
        <div align="center"><iframe
                src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2046.5192422326704!2d106.65690861992293!3d10.772420648932444!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31752ec3c161a3fb%3A0xef77cd47a1cc691e!2sHo%20Chi%20Minh%20City%20University%20of%20Technology%20(HCMUT)!5e0!3m2!1sen!2s!4v1665920802261!5m2!1sen!2s"
                width=100% height="450" style="border:0;" allowfullscreen="" loading="lazy"
                referrerpolicy="no-referrer-when-downgrade" frameborder="0" scrolling="no"
                onload="resizeIframe(this)"></iframe></div>
    </div>
</div>