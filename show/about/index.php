<style>
    .center {
        display: block;
        margin-left: auto;
        margin-right: auto;
    }

    .ourfounders_info {
        width: 100%;
        background: rgba(211, 239, 218, 0.3);
        padding: 70px 0;
    }

    .ourfounders_info h5 {
        margin: 0 0 20px 0;
        padding: 0;
        font-size: 22px;
        line-height: 34px;
        font-weight: normal;
        color: #2B292D;
        text-align: center;
    }

    .ourfounders_info h2 {
        margin: 0 0 50px 0;
        padding: 0;
        font-size: 56px;
        font-family: 'chivobold';
        text-align: center;
    }

    .ourfounders_info .ourfounders_list {
        max-width: 750px;
        margin: 0 auto;
    }

    .ourfounders_info ul {
        margin: 0;
        padding: 0;
        list-style: none;
        display: -webkit-box;
        display: -ms-flexbox;
        display: flex;
        -ms-flex-wrap: wrap;
        flex-wrap: wrap;
        margin-right: -15px;
        margin-left: -15px;
        justify-content: center;
    }

    .ourfounders_info ul li {
        margin: 0;
        padding: 15px;
        -webkit-box-flex: 0;
        -ms-flex: 0 0 33.333%;
        flex: 0 0 33.333%;
        max-width: 33.333%;
        text-align: center;
    }

    .ourfounders_info ul li a {
        display: block;
        text-decoration: none;
        color: #828287;
    }

    .ourfounders_info ul li .ourfounders_img {
        max-width: 170px;
        margin: 0 auto 16px;
        transition: all ease 0.5s;
        -webkit-transition: all ease 0.5s;
        -moz-transition: all ease 0.5s;
    }

    .ourfounders_info ul li .ourfounders_img img {
        width: 100%;
        display: block;
        margin: 0;
        border-radius: 100%;
    }

    .ourfounders_info ul li a:hover .ourfounders_img {
        transform: scale(1.1);
    }

    .ourfounders_info ul li h6 {
        margin: 0;
        padding: 0;
        font-size: 17px;
        line-height: 27px;
        color: #2B292D;
        font-weight: normal;
    }

    .trustus_direct_info {
        width: 100%;
        padding: 0 0 100px 0;
        position: relative;
    }

    .trustus_direct_list {
        width: 100%;
    }

    .trustus_direct_list ul {
        margin: 0;
        padding: 0;
        list-style: none;
        display: -webkit-box;
        display: -ms-flexbox;
        display: flex;
        -ms-flex-wrap: wrap;
        flex-wrap: wrap;
        margin-right: -10px;
        margin-left: -10px;
    }

    .trustus_direct_list ul li {
        margin: 0;
        padding: 0 10px;
        -webkit-box-flex: 0;
        -ms-flex: 0 0 50%;
        flex: 0 0 50%;
        max-width: 50%;
    }

    .trustus_direct_list ul li a {
        text-decoration: none;
        display: block;
        height: 100%;
        width: 100%;
    }

    .trustus_direct_list ul li .trustus_direct_listinner {
        width: 100%;
        height: 100%;
        padding: 50px 100px 50px 50px;
        position: relative;
        background-size: cover;
        box-shadow: -1px 13px 20px #e4e5e6;
        border-radius: 5px;
        transition: all ease 0.5s;
        -webkit-transition: all ease 0.5s;
        -moz-transition: all ease 0.5s;
        top: 0;
    }

    .trustus_direct_list ul li a:hover .trustus_direct_listinner {
        top: -20px;
    }

    .trustus_direct_list ul li .trustus_direct_listinner h5 {
        margin: 0 0 15px 0;
        padding: 0;
        font-size: 26px;
        font-weight: normal;
        color: #000;
        transition: all ease 0.5s;
        -webkit-transition: all ease 0.5s;
        -moz-transition: all ease 0.5s;
        position: relative;
        top: 23px;
        line-height: 26px;
    }

    .trustus_direct_list ul li .trustus_direct_listinner h6 {
        margin: 0;
        padding: 0;
        font-size: 15px;
        color: #828287;
        font-weight: normal;
        transition: all ease 0.5s;
        -webkit-transition: all ease 0.5s;
        -moz-transition: all ease 0.5s;
        opacity: 0;
        visibility: hidden;
        line-height: 15px;
    }

    .trustus_direct_list ul li .trustus_direct_listinner .trustus_direct_arrow {
        position: absolute;
        top: 50%;
        right: 50px;
        border: 2px solid #66BB6A;
        width: 44px;
        height: 44px;
        margin: -22px 0 0 0;
        border-radius: 100%;
        text-align: center;
        line-height: 40px;
        color: #66BB6A;
        font-size: 20px;
        transition: all ease 0.5s;
        -webkit-transition: all ease 0.5s;
        -moz-transition: all ease 0.5s;
    }

    .trustus_direct_list ul li a:hover .trustus_direct_listinner,
    .trustus_direct_list ul li.active .trustus_direct_listinner {
        background: url("../images/trustus_direct_bg2.png") 0 0 no-repeat #66BB6A;
        background-size: cover;
    }

    .trustus_direct_list ul li a:hover .trustus_direct_listinner h6 {
        opacity: 1;
        visibility: visible;
    }

    .trustus_direct_list ul li a:hover .trustus_direct_listinner h5,
    .trustus_direct_list ul li a:hover .trustus_direct_listinner h6,
    .trustus_direct_list ul li.active .trustus_direct_listinner h5,
    .trustus_direct_list ul li.active .trustus_direct_listinner h6 {
        color: #fff;
    }

    .trustus_direct_list ul li a:hover .trustus_direct_listinner h5 {
        top: 0;
    }

    .trustus_direct_list ul li a:hover .trustus_direct_listinner .trustus_direct_arrow,
    .trustus_direct_list ul li.active .trustus_direct_listinner .trustus_direct_arrow {
        color: #fff;
        border-color: #fff;
    }

    .ourstandpoint_info {
        width: 100%;
        padding: 70px 0;
    }

    .ourstandpoint_list {
        width: 100%;
        margin: 0 0 70px 0;
    }

    .ourstandpoint_list:after {
        clear: both;
        display: block;
        content: "";
    }

    .ourstandpoint_img {
        float: left;
        width: 40%;
        position: relative;
    }

    .ourstandpoint_imginner {
        position: relative;
        width: 422px;
    }

    .ourstandpoint_bg {
        width: 282px;
        position: relative;
        left: 10px;
    }

    .ourstandpoint_icon {
        position: absolute;
        top: 109px;
        left: 0;
        width: 48px;
        z-index: 2;
    }

    .ourstandpoint_icon.ourstandpoint_icon2 {
        left: 67px;
    }

    .ourstandpoint_icon.ourstandpoint_icon3 {
        left: 135px;
    }

    .ourstandpoint_icon.ourstandpoint_icon4 {
        left: 201px;
    }

    .ourstandpoint_icon.ourstandpoint_icon5 {
        left: 269px;
    }

    .ourstandpoint_sheimg {
        position: absolute;
        top: 50px;
        right: 0;
        width: 128px;
        z-index: 1;
    }

    .ourstandpoint_img_mobile {
        display: none;
    }

    .ourstandpoint_cont {
        float: left;
        width: 60%;
        padding: 0 0 0 50px;
    }

    .ourstandpoint_cont h3 {
        margin: 0 0 20px 0;
        padding: 0;
        font-size: 35px;
        line-height: 44px;
        font-family: 'chivobold';
    }

    .ourstandpoint_cont p {
        margin: 0 0 30px 0;
        padding: 0;
        font-size: 17px;
        line-height: 26px;
        color: #828287;
    }

    .ourstandpoint_cont .readmore_btn {
        color: #66BB6A;
        text-decoration: none;
        font-family: 'chivobold';
    }

    .ourstandpoint_info .freshproducesupply_inner {
        width: 100%;
        padding: 0 20px;
        text-align: center;
        background: #f4f6f9;
        border-radius: 5px;
        position: relative;
    }

    .ourstandpoint_info .freshproducesupply_inner .freshproducesupply_bg {
        position: absolute;
        /*top: -70px;*/
        top: -110px;
        right: -133px;
        content: "";
        background: url("../images/freshproducesupply_bg2.png") 0 0 no-repeat;
        width: 133px;
        height: 209px;
    }

    .ourstandpoint_info .freshproducesupply_inner h3 {
        margin: 0 0 35px;
        padding: 0;
        font-size: 36px;
        font-family: 'chivobold';
        color: #000;
    }

    .ourstandpoint_info .freshproducesupply_inner h3 span {
        color: #EAAF00;
    }

    .ourstandpoint_info .freshproducesupply_inner .joinrevolution_btn {
        color: #f4f6f9;
        font-size: 18px;
        text-decoration: none;
        display: inline-block;
        padding: 15px 50px;
        background: #66BB6A;
        border-radius: 5px;
        position: relative;
        overflow: hidden;
    }

    .ourstandpoint_info .freshproducesupply_inner .joinrevolution_btn::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        z-index: 1;
        opacity: 0;
        background-color: rgba(40, 95, 43, 0.5);
        -webkit-transition: all 0.4s;
        -moz-transition: all 0.4s;
        -o-transition: all 0.4s;
        transition: all 0.4s;
        -webkit-transform: scale(0.5, 1);
        transform: scale(0.5, 1);
    }

    .ourstandpoint_info .freshproducesupply_inner .joinrevolution_btn:hover::before {
        opacity: 1;
        -webkit-transform: scale(1, 1);
        transform: scale(1, 1);
    }

    .ourstandpoint_info .freshproducesupply_inner .joinrevolution_btn span {
        position: relative;
        z-index: 2;
    }
</style>

<script>
    function resizeIframe(obj) {
        obj.style.height = obj.contentWindow.document.documentElement.scrollHeight + 'px';
    }
</script>

<div class=" py-5">
    <h1 class="text-center" style="color:#54c577">Dự án tiên phong trong giải quyết chuỗi cung ứng theo hướng công nghệ
        cho sản phẩm nông sản</h1>
    <div>
        <img src="./uploads/ill-tab2-hero-cropped.svg" alt="" class="center">
    </div>
</div>


<div class="row py-5">
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

<div class="ourstandpoint_info">
    <div class="container_info">
        <div class="ourstandpoint_list">
            <div class="ourstandpoint_cont">
                <h3>Định hướng tương lai</h3>
                <p>Tầm nhìn của dự án là xây dựng nền tảng chuỗi cung ứng hiệu quả nhất và lớn nhất của Việt Nam và cải
                    thiện cuộc sống của các nhà sản xuất, doanh nghiệp và người tiêu dùng.</p>
                <p>Chúng tôi tập trung vào việc làm cho đổi mới BkFresh dễ tiếp cận hơn đến từng khía cạnh của xã hội.
                    Chúng tôi dự định tận dụng thế mạnh và nguồn lực của mình để đổi mới các danh mục sản phẩm và phân
                    khúc khách hàng mới đồng thời giải quyết các vấn đề phức tạp của chuỗi cung ứng.</p>
            </div>
            <div class="ourstandpoint_img">
                <img src="./uploads/0646263251da437e2faa6d0ac2c412a7.png" alt="">
            </div>
        </div>
    </div>
    <div class="container_info">
        <div class="freshproducesupply_inner">
            <div class="freshproducesupply_bg"></div>
            <h3>Tương lai của chuỗi cung ứng <span>Nông Sản</span> chính là BkFresh</h3>
            <a href="./vendor/register.php" class="joinrevolution_btn"><span>Tham gia ngay</span></a>
        </div>
    </div>
</div>

<div class="ourfounders_info">
    <div class="container_info">
        <h2>Các thành viên của dự án</h2>
        <div class="ourfounders_list">
            <ul>
                <li>
                    <a href="https://www.facebook.com/HuuNghiaTheGreat/">
                        <div class="ourfounders_img">
                            <img src="./uploads/308109630_514372727194465_1002285854542186557_n.jpg" alt="">

                        </div>
                        <h6>Mai Hữu Nghĩa</h6>
                    </a>
                </li>
                <li>
                    <a href="https://www.facebook.com/trantridat.1101">
                        <div class="ourfounders_img">
                            <img src="./uploads/Screenshot 2022-09-27 100339.png" alt="">

                        </div>
                        <h6>Trần Trí Đạt</h6>
                    </a>
                </li>
            </ul>
        </div>
    </div>
</div>
<div class="trustus_direct_info">
    <div class="container_info">
        <div class="trustus_direct_list">
            <ul>
                <li class="active">
                    <a href="./vendor/register.php">
                        <div class="trustus_direct_listinner">
                            <h5>Tin tưởng BkFresh với thu hoạch của bạn</h5>
                            <h6>Nhận giá hợp lý cho sản phẩm của bạn từ BkFresh</h6>
                        </div>
                    </a>
                </li>
                <li>
                    <a href="./register.php">
                        <div class="trustus_direct_listinner">
                            <h5>Trực tiếp từ trang trại đến doanh nghiệp</h5>
                            <h6>Đặt hàng và kết nối qua BkFresh</h6>
                        </div>
                    </a>
                </li>
            </ul>
        </div>
    </div>
</div>