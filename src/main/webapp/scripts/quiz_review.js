let red = "rgb(220, 53, 69)";
let yellow = "rgb(237, 178, 0)";
let green = "rgb(35, 176, 110)";
$(document).ready(
    $(".testbox").each(function(){

        var correct = $(this).attr("value");
        var correctbox = $(this).find("."+correct);
        var correctboxletter = correctbox.find(".answerletter");

        var selected = $(this).attr("data-selected");
        var selectedbox = $(this).find("."+selected);
        var selectedboxletter = selectedbox.find(".answerletter");

        var resultbox = $(this).find(".resultbox");
        correctbox.css("color", "rgb(255, 255, 255)");
        correctbox.css("border", "0");
        selectedbox.css("color", "rgb(255, 255, 255)");
        selectedbox.css("border", "0");

        if(selected=="none"){
            resultbox.append("Nie wybrano odpowiedzi. Poprawna odpowiedź to: "+correct.substr(3));
            resultbox.css("backgroundColor", red);

            correctbox.css("backgroundColor", yellow);
            correctboxletter.css("backgroundColor", yellow);

        }
        else{
            if(selected==correct){
                resultbox.append("Poprawna odpowiedź! Poprawna odpowiedź to: "+correct.substr(3));
                resultbox.css("backgroundColor", green);

                correctbox.css("backgroundColor", green);
                correctboxletter.css("backgroundColor", green);
            }
            else{
                resultbox.append("Błędna odpowiedź. Poprawna odpowiedź to: "+correct.substr(3));
                resultbox.css("backgroundColor", red);

                selectedbox.css("backgroundColor", red);
                selectedboxletter.css("backgroundColor", red);

                correctbox.css("backgroundColor", yellow);
                correctboxletter.css("backgroundColor", yellow);
            }
        }

    })
);