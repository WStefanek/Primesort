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
        .attr("transform", function(item, index){
            return "translate("+positions[index]+","+(230-(item/max*200))+")";
        })

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
    bubblesort(data);

})

//Polecenia do wykonania po załadowaniu się dokumentu
$(document).ready(
    //Wstrzyknięcie losowych danych do inputu zaraz po starcie strony oraz generowanie
    $("#random-btn").click(),
);


// UŻYTKOWE FUNKCJE

//Funkcja przemieszczająca belkę na odpowiednią pozycję
function move(bar, x){
    var h=parseInt(bar.attr("transform").split(",")[1].split(")")[0]);
    bar.transition()
        .ease(d3.easeCubic)
        .duration($("#speedslider").val()/2)
        .attr("transform", "translate("+positions[x]+","+h+")");
}

//Funkcja zmieniająca belkę na podany kolor
function highlight(bar, mode){
    switch(mode){
        case 1: { //żółty - porównywanie
            bar.select("rect").transition()
                .ease(d3.easeCubic)
                .duration($("#speedslider").val()/2)
                .attr("style", "fill: rgb(235, 195, 52)");
            break;
        }
        case 2: {   //czerwony - nieposortowany
            bar.select("rect").transition()
                .ease(d3.easeCubic)
                .duration($("#speedslider").val()/2)
                .attr("style", "fill: rgb(230, 103, 92)");
            break;
        }
        case 3: { //zielony - posortowany
            bar.select("rect").transition()
                .ease(d3.easeCubic)
                .duration($("#speedslider").val()/2)
                .attr("style", "fill: rgb(71, 209, 117)");
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

// FUNKCJE BUBBLESORT

//Funkcja wykonująca sortowanie podanych danych i generująca kroki dla funkcji wizualizującej
function bubblesort(data) {
    var n = data.length;
    var idxdata=new Array();
    for(var i=0;i<n;i++){
        idxdata[i]=[i, data[i]];
    }
    stg=-1;
    var swapped_pass = false;
    var swapped_stg = false;

    console.log("Tablica początkowa: ");
    console.log(idxdata);
    for (var j = 0; j < n - 1; j++) {
        console.log("Przejście " + (j + 1));
        swapped_pass = false;
        var text="";
        text="Zaczęto przejście nr "+(j+1)+", które porówna "+(n-j)+" pierwszych elementów.\n";
        for (var i = 1; i < n - j; i++) {
            swapped_stg = false;
            stg++;
            stages[stg]=[];
            console.log("Etap "+stg+":")
            for(var k=0;k<n;k++){
                if(stg==0) stages[stg][k]=idxdata[k].concat([0, 0]);
                if(stg>0){
                    if(stages[stg-1][k][2]==1) stages[stg][k]=idxdata[k].concat([1, 0]);
                    else stages[stg][k]=idxdata[k].concat([0, 0]);
                }
                console.log(stages[stg][k]);
            }
            stages[stg][i-1][3]=1;
            stages[stg][i][3]=1;
            console.log("Porównywanie " + idxdata[i - 1][1] + " i " + idxdata[i][1]);
            text+="Porównywanie elementów "+(i-1)+" oraz "+i+".\n";
            desc[stg]="";
            desc[stg]+=text;
            text="";
            if (idxdata[i - 1][1] > idxdata[i][1]) {
                idxdata[i] = [idxdata[i - 1], idxdata[i - 1] = idxdata[i]][0];
                swapped_pass = swapped_stg = true;
                console.log("Zamiana miejscami");
            }
            if(swapped_stg){
                stg++;
                stages[stg]=[];
                console.log("Etap "+stg+":")
                for(var k=0;k<n;k++){
                    if(stages[stg-1][k][2]==1) stages[stg][k]=idxdata[k].concat([1, 0]);
                    else stages[stg][k]=idxdata[k].concat([0, 0]);
                    console.log(stages[stg][k]);
                }
                text="Zamiana elementów "+(i-1)+" oraz "+i+" miejscami.\n";
                desc[stg]=""
                desc[stg]+=text;
                text="";
            }
        }
        text="Koniec przejścia, oznaczenie elementu nr "+(n-j-1)+" jako posortowany.\n";
        desc[stg]+=text;
        stages[stg][n-j-1][2]=1;
        if (swapped_pass == false) {
            for(var k=1;k<=n;k++){
                stages[stg][k-1][2]=1;
            }
            desc[stg]="";
            desc[stg]+="Podczas przejścia nie nastąpiła żadna zamiana miejscami, przerywanie sortowania.\n";
            console.log("Nie nastąpiły dalsze zamiany, finalna tablica: ");
            console.log(idxdata);
            console.log("Etapy do tej pory:");
            console.log(stages);
            console.log("Opisy:")
            console.log(desc);
            bubblesort_vis();
            return idxdata;
        }
    }
    console.log("Finalna tablica: ");
    console.log(idxdata);
    console.log("Etapy do tej pory:");
    console.log(stages);
    console.log("Opisy:")
    console.log(desc);
    bubblesort_vis();
    return idxdata;
}

//Funkcja wizualizująca bubblesort
async function bubblesort_vis(){
    var swapped=true;
    playing=true;
    $("#playicon").attr("xlink:href", "icons/bootstrap-icons.svg#pause-btn");
    var progressbar = $("#progressbar");
    progressbar.attr("max", stages.length-1);
    progressbar.removeAttr("disabled");
    var textlog=$("#textlog");
    textlog.val("Start sortowania");
    for(stg=0;stg<stages.length&&playing==true;stg++) {
        var s=stg;
        if(finished) $("#playicon").attr("xlink:href", "icons/bootstrap-icons.svg#pause-btn");
        finished=false;
        progressbar.val(s);
        await sleep($("#speedslider").val());
        while(paused){
            await sleep(100);
        }
        textlog.val("Etap "+s+": "+desc[s]+"\n"+$("#textlog").val());
        if(!prgs_clicked){
            while(paused){
                await sleep(100);
            }
            for(var i=0, j=0;i<dataset.length;i++){
                if(stages[s][i][3]==1) {
                    highlight(bars[stages[s][i][0]], 1);
                    swapped=false;
                    j++;
                }
            }
            if(swapped){
                while(paused){
                    await sleep(100);
                }
                for(var j=0;j<dataset.length;j++){
                    move(bars[stages[s][j][0]], j, 0);
                }
            }
            else{
                await sleep($("#speedslider").val());
                while(paused){
                    await sleep(100);
                }
                for(var i=0;i<dataset.length;i++){
                    if(stages[s][i][3]==1) highlight(bars[stages[s][i][0]], 2);
                }
                swapped=true;
            }

            while(paused){
                await sleep(100);
            }
            for(var j=0;j<dataset.length;j++){
                if(stages[s][j][2]==1) highlight(bars[stages[s][j][0]], 3);
            }
        }
        prgs_clicked=false;
        if(s==stages.length-1){
            for(var j=0;j<dataset.length;j++){
                highlight(bars[j], 3);
            }
            finished=true;
            $("#playicon").attr("xlink:href", "icons/bootstrap-icons.svg#arrow-repeat");
            textlog.val("Koniec sortowania\n"+$("#textlog").val());
        }
        while(s==stages.length-1) {
            s=stg;
            await sleep(100);
        }
    }
}

