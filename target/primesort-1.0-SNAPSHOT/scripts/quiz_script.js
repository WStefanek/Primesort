$(document).ready(

    $(".answerbox").on("click", function(){
        $(this).parent().find(".odpselected").removeClass("odpselected");
        $(this).addClass("odpselected");
    }),

    $("#confirmquizbtn").on("click", function(){
        var selectedArr = [];
        var i=-1;
        var selectedAll=true;
        $(".testbox").each(function(){
            i++;
            var selected = $(this).find(".odpselected").attr("value");
            if(selected==null){
                selectedArr[i] = "none";
                selectedAll=false;
            }
            else{
                selectedArr[i] = selected;
            }
        })
        $("#answerinput").attr("value", selectedArr);
        if(!selectedAll){
            var dialogue = confirm("Nie udzielono odpowiedzi na wszystkie" +
                " pytania. Mimo to przesłać odpowiedzi?");
            if(dialogue){
                $("form").submit();
            }
        }
        else{
            $("form").submit();
        }
    })
);