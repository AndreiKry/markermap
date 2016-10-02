<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Marker Map</title>
</head>
<style type="text/css">

    body, html {
        font-family: sans-serif;
        color: #0B68F3;
        background: #FFFFFF;
        margin: 0;
        padding: 0;
    }

    body {
        margin: 20px;
    }

    h1 {
        font-weight: normal;
        text-align: center;
    }

    button {
        background: #e9e9e9;
        cursor: pointer;
        border: 1px solid #ddd;
        padding: 2px 13px;
        -webkit-border-radius: 3px;
        -moz-border-radius: 3px;
        margin-top: 3%;
        margin-left: 25%;
        cursor: pointer;
    }


    .div-send {
        margin: 0 0 0 55%;
        vertical-align: middle;
        display: none;
    }

    .button-send {
        height: 31px;
        position: relative;
        display: inline-block;
        padding-bottom: 3px;
        color: #FFFFFF;
        background-color: #0B68F3;
    }
    textarea::-webkit-input-placeholder {
        color: #FFFFFF;
    }
    textarea:-moz-placeholder {
        color: #FFFFFF;
    }

    .input-send {
        position: relative;
        display: inline-block;
        width: 100%;
        height: 10%;
        resize: none;
        padding: 3px;
        font-family: monospace;
        font-size: 16px;
        border: #0B68F3;
        background: #7C4DFF;
        color: #212121;
    }

    .send {
        margin: 0 0 -20% 0;
        display: inline-block;
    }
</style>
<body>
<script src="http://code.jquery.com/jquery-1.10.2.js" type="text/javascript"></script>
<script src="http://maps.api.2gis.ru/2.0/loader.js?pkg=full&skin=dark"></script>

<h1>Сервис карт</h1>
    <div class="span1">
        <div class="send" id="map" style="width:100%; height:90%">
        </div>
        <div class="div-send">
                <textarea id="sender" class="input-send" maxlength="35" cols="10" wrap="soft" placeholder="Введите ваше сообщение!    (максимум 35 символов)"></textarea>
                <button id="btnsnd" class="button-send" lat="" lng="">Отправить</button>
        </div>
    </div>
<script type="text/javascript">
    var map;

    DG.then(function () {
        map = DG.map('map', {
            center: [54.755195080195, 55.952674522536],
            zoom: 11
        });

        var doto = 2;
        $.post('getit', {
            "doto" : doto
        }, function(responseText) {
            printMarks(responseText);
        }).fail(function() {
            alert("Запрос не выполнен");
        });

        map.on('dragstart', function(){
            $(".div-send").css('display', 'none');
        });

        map.on('click', function(e) {
            var lat = e.latlng.lat;
            var lng = e.latlng.lng;

            $(".div-send").css('display', 'inline-block');
            $("#btnsnd").attr("lat",lat);
            $("#btnsnd").attr("lng",lng);

            map.setView([lat, lng]);

        });
    });

    function btnsnd(){
        var sendwhat = $('#sender').val();
        var lat = $("#btnsnd").attr("lat");
        var lng = $("#btnsnd").attr("lng");
        var doto = 1;

            $.post('getit', {
                "sender" : sendwhat, "lat" : lat, "lng" : lng, "doto" : doto
            }, function() {
                marker = DG.marker([lat, lng])
                        .addTo(map);
                marker.bindPopup(sendwhat);
            }).fail(function() {
                alert("Запрос не выполнен");
            });

        $(".div-send").css('display', 'none');
        $("#sender").val("");
        $("#btnsnd").attr("lat","");
        $("#btnsnd").attr("lng","");

    }

    function printMarks (json) {

        $.each(json, function(i, markObject) {

            var contt = markObject.cont;
            var latt = markObject.lat;
            var lngg = markObject.lng;
            marker = DG.marker([latt, lngg])
                    .addTo(map);
            marker.bindPopup(contt);
        });
    };

    $(document).ready(function () {
        $(".button-send").click(btnsnd);

    });

</script>

</body>
</html>
