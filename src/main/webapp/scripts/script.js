function sleep(duration) {
    return new Promise(resolve => {
        setTimeout(() => {
            resolve()
        }, duration)
    })
}

$(document).ready(
    function(){
        $(".scriptbtn").hover(
            function(){
                $bgcolor = $(this).css("backgroundColor");
                $txtcolor = $(this).css("color");
                $(this).css({"backgroundColor": $txtcolor, "color": $bgcolor})
            },
            function(){
                $(this).css({"backgroundColor": $bgcolor, "color": $txtcolor})
            }
        );

        $( ".btn-sidebar" ).click(function() {
            if (  $(this).find(".bi").css( "transform" ) == 'none' ){
                $(this).find(".bi").css("transform","rotate(90deg)");
            } else {
                $(this).find(".bi").css("transform","" );
            }
        });

        $("#playbtn").hover(function(){$("#playbtn").attr("style", "background-color: #0f79a6")}, function(){$("#playbtn").attr("style", "background-color: #0B4F6C")});

    }
);
