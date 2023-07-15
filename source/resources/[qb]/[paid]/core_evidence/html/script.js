var evidence = null;
var evidences = null;

var animating = false;
var removing = false;

function GenerateReport() {

    if (!animating) {

        $("#main_container").html("");
        $("#main_container").css({
            display: 'none'
        });


        html_header = "<div id=\"section_header\">";
        html_header += "<div id=\"header_title\">" + 'EVIDENCE REPORT' + "</div>";
        html_header += "<div id=\"header_seal\"></div>";
        html_header += "<div id=\"header_details\"><h2>" + 'Offical police forensics team report for the evidence given!' + "</h2>";


        $("#main_container").append(html_header);

        $("#main_container").append("<div id=\"section_input\"></div>");

        html_middle = '';

        var i;

        for (i = 0; i < Object.keys(evidence).length; i++) {

            html_middle += "<div id=\"section_footer_block\">" + 'EVIDENCE #' + (i + 1) + ' (' + evidence[i]["type"] + ')' + "</div>";

            for (const [key, value] of Object.entries(evidence[i]["evidence"])) {
                html_middle += "<div class=\"header_information_subblock\">";
                html_middle += "<h3>" + key.charAt(0).toUpperCase() + key.slice(1) + "</h3>";
                html_middle += "<h4>" + value + "</h4>";
                html_middle += "</div>";
            }
        }

        printSound();

        $("#main_container").append(html_middle);
        animating = true;
        $("#main_container").css({
            display: 'block',
            bottom: '-80%'
        }).animate({
            bottom: "0%",
        }, 2000, function () {
            animating = false;
        });;
    }
}

function clickSound() {
    var audio = document.getElementById("clickaudio");
    audio.volume = 0.05;
    audio.play();
}

function printSound() {
    var audio = document.getElementById("printing");
    audio.volume = 0.05;
    audio.play();
}

function selectEvidence(k) {
    if (removing) {
        removing = false;
    } else {
        evidence = JSON.parse(evidences[k].data);
        GenerateReport();
    }
}

function remove(t, k) {
    removing = true;
    $.post('https://core_evidence/remove', JSON.stringify({
        evidence: k
    }));
    $(t).parent().remove();
    clickSound();
}

function openLocker() {
    var base = '<div class="grpelem slide-right" id="u104" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- simple frame -->' +
        '   <div class="clearfix grpelem" id="u109-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
        '    <p>EVIDENCE LOCKER</p>' +
        '   </div>' +
        '<div id="spacer"></div>';

    for (const [key, value] of Object.entries(evidences)) {
        base = base + '     <div class="clearfix colelem" onclick="selectEvidence(\'' + key + '\')" id="pu120-4"><!-- group -->' +
            '      <div class="clearfix grpelem" id="u120-4" data-sizePolicy="fixed" data-pintopage="page_fluidx"><!-- content -->' +
            '       <p>#' + value.id + '</p>' +
            '      </div>' +
            '      <div class="grpelem" id="u131" onclick="remove(this,\'' + value.id + '\')" data-sizePolicy="fixed" data-pintopage="page_fluidx">X</div>' +

            '     </div>';
    }

    base = base + '   </div>';

    $("body").append(base);

}

function closeMenu() {
    $.post('https://core_evidence/close', JSON.stringify({}));

    $("body").fadeOut(400);
    timeout = setTimeout(function () {
        $("#u104").remove();
        $("body").fadeIn();
        $("#main_container").html("");
        $("#main_container").css({
            display: 'none'
        });
    }, 400);
}

$(document).keyup(function (e) {
    if (e.keyCode === 27 || e.keyCode === 8) {
        closeMenu();
    }
});


window.addEventListener('message', function (event) {
    var edata = event.data;
    if (edata.type == "openLocker") {
        evidences = edata.evidences;
        openLocker();
    }
    if (edata.type == "showReport") {
        evidence = edata.evidence;
        GenerateReport();
    } else if (edata.type == "close") {
        $("#main_container").html("");
        $("#main_container").css({
            display: 'none'
        });
    }
});