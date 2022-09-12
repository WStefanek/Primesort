//ZMIENNE GLOBALNE
let dataset=[]; //Zmienna do przechowywania danych z pola do wpisywania zmiennych
let positions=[5, 55, 105, 155, 205, 255, 305, 355, 405, 455, 505, 555, 605, 655, 705, 755, 805, 855, 905, 955]; // Tabela możliwych pozycji belek
let playing=false; //Zmienna logiczna ustanawiająca czy animacja jest odtwarzana czy nie. Użyta by przycisk odtwarzania mógł służyć jako przycisk do rozpoczęcia animacji, jak i pauzowania i wznowienia gdy animacja jest rozpoczęta
let paused=false; //Zmienna logiczna ustanawiająca czy animacja jest spauzowana czy nie. Użyta by główna pętla animacji została wstrzymana podczas odtwarzania animacji
let finished=false;
let prgs_clicked=false; //Zmienna logiczna ustanawiająca czy pasek postępu został kliknięty. Użyta by po kliknięciu na pasek postępu jego wartość się zmieniła oraz zmodyfikowała pozycję belek w animacji
let stg=0 //stg - skrót od stage, zmienna przechowująca numer etapu animacji
let stages=[];  //Tablica etapów, użyta by przypisać do niej tablicę etapów wygenerowaną w funkcji sortującej. Tablica będzie miała formę tablicy trójwymiarowej: stages[numer_etapu][numer_belki_z_rzędu][element_danych]
let bars=[];    //Tablica belek wygenerowanych podczas generowania belek. Tablica będzie miała formę bars[numer_belki], z czego numer belki to cyfra znajdująca się w id znacznika html belki po przedrostku "pos"
let desc=[]; //Tablica zawierająca opis etapu

//OBSŁUGA PRZYCISKU GENERUJĄCEGO
$("#generate-btn").click(function(){

    //Resetowanie potrzebnych atrybutów
    $("#sort-btn").removeAttr("disabled");
    $("#sort-btn").removeClass("btn-secondary");
    $("#sort-btn").addClass("btn-primary");
    playing=false;
    paused=false;
    finished=false;
    $("#playicon").attr("xlink:href", "icons/bootstrap-icons.svg#play-btn");
    $("#progressbar").val(0);
    $("#progressbar").attr("disabled", 1)
    stg=0;
    bars=[];
    stages=[];

    //Generowanie
    var gendata = $("#dataset").val().split(",").map((i)=>Number(i));
    if (gendata.length>16){
        alert("Ilość elementów nie może być większa niż 16.")
        return;
    }
    for(var i=0;i<gendata.length;i++){
        if(gendata[i]>999){
            alert("Żaden z elementów nie może być większy niż 999.");
            return;
        }
        if(!Number.isInteger(gendata[i])){
            alert("W polu zestawu danch mogą się znajdować jedynie liczby naturalne oddzielone przecinkami.\nPrzykład: 5, 13, 4, 19");
            return;
        }
    }
    var max = Math.max(...gendata);
    dataset=gendata;
    $("#can-vis").attr("width", gendata.length*50)
    $("#can-vis").empty();

    var svgGroup = d3.select("#can-vis").selectAll("g")
        .data(gendata)
        .enter()
        .append("g")
        .attr("id", function(item, index){return "pos"+(index)})
        .attr("transform", function(item, index){return "translate("+positions[index]+","+(230-(item/max*200))+")";})

    svgGroup.append("rect")
        .attr("width", 45)
        .attr("height", item=>item/max*200)
        .attr("style", "fill: rgb(230, 103, 92)");
    svgGroup.append("text")
        .attr("x", function(item){
            if(item<=9) return 18;
            if(item>9&&item<=99) return 13;
            if(item>99&&item<=999) return 9;
        })
        .attr("dy", -5)
        .text(item=>item);
    for(var i=0;i<dataset.length;i++){
        bars[i]=d3.select("#pos"+i);
    }
})

//OBSŁUGA PRZYCISKU LOSUJĄCEGO DANE
$("#random-btn").click(function(){
    $("#dataset").val(function(){
        var tabrand=[];
        for(var i = 0;i<Math.ceil(Math.random()*10)+5;i++){
            tabrand.push(Math.ceil(Math.random()*100));
        }
        return tabrand.join(", ");
    })
    $("#generate-btn").click();
})


//OBSŁUGA PRZYCISKU ROZPOCZYNAJĄCEGO SORTOWANIE
$("#sort-btn").click(function(){
    $("#sort-btn").attr("disabled", 1);
    $("#sort-btn").removeClass("btn-primary");
    $("#sort-btn").addClass("btn-secondary");
    var sorttype=$("#sort-btn").val();
    var data=dataset;
    switch(sorttype){
        case "bubblesort":{
            bubblesort(data);
            break;
        }
        case "insertionsort":{
            insertionsort(data);
            break;
        }
        case "selectionsort":{
            selectionsort(data);
            break;
        }
        case "mergesort":{
            mergesort(data);
            break;
        }
    }

})

//Polecenia do wykonania po załadowaniu się dokumentu
$(document).ready(
    //Wstrzyknięcie losowych danych do inputu zaraz po starcie strony oraz generowanie
    $("#random-btn").click(),
);


// UŻYTKOWE FUNKCJE

//Funkcja przemieszczająca belkę na odpowiednią pozycję
function move(bar, x, l){
    var h=parseInt(bar.attr("transform").split(",")[1].split(")")[0]);
    if(l==1) h-=300;
    if(l==2) h+=300;
    bar.transition()
        .ease(d3.easeCubic)
        .duration($("#speedslider").val()/2)
        .attr("transform", "translate("+positions[x]+","+h+")");
}

//Funkcja zmieniająca belkę na podany kolor
function highlight(bar, mode){
    switch(mode){
        case 1: { //yellow - comparing
            bar.select("rect").transition()
                .ease(d3.easeCubic)
                .duration($("#speedslider").val()/2)
                .attr("style", "fill: rgb(235, 195, 52)");
            break;
        }
        case 2: {   //red - unsorted
            bar.select("rect").transition()
                .ease(d3.easeCubic)
                .duration($("#speedslider").val()/2)
                .attr("style", "fill: rgb(230, 103, 92)");
            break;
        }
        case 3: { //green - sorted
            bar.select("rect").transition()
                .ease(d3.easeCubic)
                .duration($("#speedslider").val()/2)
                .attr("style", "fill: rgb(71, 209, 117)");
            break;
        }
        case 4: { //orange - current min
            bar.select("rect").transition()
                .ease(d3.easeCubic)
                .duration($("#speedslider").val()/2)
                .attr("style", "fill: rgb(211, 135, 255)");
            break;
        }
        case 5: { //blue - group 1
            bar.select("rect").transition()
                .ease(d3.easeCubic)
                .duration($("#speedslider").val()/2)
                .attr("style", "fill: rgb(52, 73, 235)");
            break;
        }
        case 6: { //purple - group 2
            bar.select("rect").transition()
                .ease(d3.easeCubic)
                .duration($("#speedslider").val()/2)
                .attr("style", "fill: rgb(162, 52, 235)");
            break;
        }
        case 7: { //pink - group 3
            bar.select("rect").transition()
                .ease(d3.easeCubic)
                .duration($("#speedslider").val()/2)
                .attr("style", "fill: rgb(235, 52, 232)");
            break;
        }
        case 8: { //cyan - group 4
            bar.select("rect").transition()
                .ease(d3.easeCubic)
                .duration($("#speedslider").val()/2)
                .attr("style", "fill: rgb(52, 235, 235)");
            break;
        }
        case 9: { //light blue - group 5
            bar.select("rect").transition()
                .ease(d3.easeCubic)
                .duration($("#speedslider").val()/2)
                .attr("style", "fill: rgb(175, 171, 255)");
            break;
        }
        case 10: { //light purple - group 6
            bar.select("rect").transition()
                .ease(d3.easeCubic)
                .duration($("#speedslider").val()/2)
                .attr("style", "fill: rgb(230, 171, 255)");
            break;
        }
        case 11: { //light pink - group 7
            bar.select("rect").transition()
                .ease(d3.easeCubic)
                .duration($("#speedslider").val()/2)
                .attr("style", "fill: rgb(255, 171, 244)");
            break;
        }
        case 11: { //light cyan - group 8
            bar.select("rect").transition()
                .ease(d3.easeCubic)
                .duration($("#speedslider").val()/2)
                .attr("style", "fill: rgb(197, 252, 242)");
            break;
        }
    }
}

//Obsługa kliknięcia na pasek postępu wizualizacji
$("#progressbar").click(function(){
    prgs_clicked=true;
    stg=$("#progressbar").val();
    for(var j=0;j<dataset.length;j++){
        highlight(bars[stages[stg][j][0]], 2);
    }
    for(var j=0;j<dataset.length;j++){
        move(bars[stages[stg][j][0]], j);
        if(stages[stg][j][2]==1) highlight(bars[stages[stg][j][0]], 3);
        else highlight(bars[stages[stg][j][0]], 2);
    }
    if(paused) $("#playicon").attr("xlink:href", "icons/bootstrap-icons.svg#play-btn");
    else $("#playicon").attr("xlink:href", "icons/bootstrap-icons.svg#pause-btn");
    $("#textlog").val("");
    finished=false;
    stg-=1;
});

//Obsługa przycisku play
$("#playbtn").click(function(){
    if(!finished){
        if(paused){
            paused=false;
            $("#playicon").attr("xlink:href", "icons/bootstrap-icons.svg#pause-btn");
        }
        else{
            if(!playing){
                $("#sort-btn").click();
            }else{
                paused=true;
                $("#playicon").attr("xlink:href", "icons/bootstrap-icons.svg#play-btn");
            }
        }
    }
    else{
        for(var j=0;j<dataset.length;j++) {
            move(bars[stages[0][j][0]], j);
            if (stages[0][j][2] == 1) highlight(bars[stages[0][j][0]], 3);
            else highlight(bars[stages[0][j][0]], 2);
        }

        stg=-1;
        finished=false;
        $("#playicon").attr("xlink:href", "icons/bootstrap-icons.svg#pause-btn");
        $("#textlog").val("");
    }
})