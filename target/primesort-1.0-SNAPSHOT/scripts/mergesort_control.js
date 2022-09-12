//ZMIENNE GLOBALNE
let dataset=[]; //Zmienna do przechowywania danych z pola do wpisywania zmiennych
let positions=[5, 55, 105, 155, 205, 255, 305, 355, 405, 455, 505, 555, 605, 655, 705, 755, 805, 855, 905, 955]; // Tabela możliwych pozycji belek
let heightsl1=[];
let heightsl2=[];
let playing=false; //Zmienna logiczna ustanawiająca czy animacja jest odtwarzana czy nie. Użyta by przycisk odtwarzania mógł służyć jako przycisk do rozpoczęcia animacji, jak i pauzowania i wznowienia gdy animacja jest rozpoczęta
let paused=false; //Zmienna logiczna ustanawiająca czy animacja jest spauzowana czy nie. Użyta by główna pętla animacji została wstrzymana podczas odtwarzania animacji
let finished=false;
let moving=false;
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
    for(var i=0;i<gendata.length;i++){
        heightsl1[i]=230-(gendata[i]/max*200);
        heightsl2[i]=230-(gendata[i]/max*200)+250;
    }
    console.log(heightsl1);
    console.log(heightsl2);
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
    mergesort(data);

})

//Polecenia do wykonania po załadowaniu się dokumentu
$(document).ready(
    //Wstrzyknięcie losowych danych do inputu zaraz po starcie strony oraz generowanie
    $("#random-btn").click(),
);


// UŻYTKOWE FUNKCJE

//Funkcja przemieszczająca belkę na odpowiednią pozycję
function move(bar, x, l, id) {
    if(l==1) h=heightsl1[id];
    if(l==2) h=heightsl2[id];
    bar.transition()
        .ease(d3.easeCubic)
        .duration($("#speedslider").val() / 2)
        .attr("transform", "translate(" + positions[x] + "," + h + ")");
}

//Funkcja zmieniająca belkę na podany kolor
function highlight(bar, mode){
    switch(mode){
        case 0: {   //red - unsorted
            bar.select("rect").transition()
                .ease(d3.easeCubic)
                .duration($("#speedslider").val()/2)
                .attr("style", "fill: rgb(230, 103, 92)");
            break;
        }
        case 1: { //yellow - comparing
            bar.select("rect").transition()
                .ease(d3.easeCubic)
                .duration($("#speedslider").val()/2)
                .attr("style", "fill: rgb(235, 195, 52)");
            break;
        }
        case 2: { //green - sorted
            bar.select("rect").transition()
                .ease(d3.easeCubic)
                .duration($("#speedslider").val()/2)
                .attr("style", "fill: rgb(71, 209, 117)");
            break;
        }
        case 3: { //blue - group 1
            bar.select("rect").transition()
                .ease(d3.easeCubic)
                .duration($("#speedslider").val()/2)
                .attr("style", "fill: rgb(255, 0, 0)");
            break;
        }
        case 4: { //purple - group 2
            bar.select("rect").transition()
                .ease(d3.easeCubic)
                .duration($("#speedslider").val()/2)
                .attr("style", "fill: rgb(255, 96, 0)");
            break;
        }
        case 5: { //pink - group 3
            bar.select("rect").transition()
                .ease(d3.easeCubic)
                .duration($("#speedslider").val()/2)
                .attr("style", "fill: rgb(255, 192, 0)");
            break;
        }
        case 6: { //cyan - group 4
            bar.select("rect").transition()
                .ease(d3.easeCubic)
                .duration($("#speedslider").val()/2)
                .attr("style", "fill: rgb(226, 255, 0)");
            break;
        }
        case 7: { //orange - group 9
            bar.select("rect").transition()
                .ease(d3.easeCubic)
                .duration($("#speedslider").val()/2)
                .attr("style", "fill: rgb(134, 255, 0)");
            break;
        }
        case 8: { //light blue - group 5
            bar.select("rect").transition()
                .ease(d3.easeCubic)
                .duration($("#speedslider").val()/2)
                .attr("style", "fill: rgb(38, 255, 0)");
            break;
        }
        case 9: { //light purple - group 6
            bar.select("rect").transition()
                .ease(d3.easeCubic)
                .duration($("#speedslider").val()/2)
                .attr("style", "fill: rgb(0, 255, 54)");
            break;
        }
        case 10: { //light pink - group 7
            bar.select("rect").transition()
                .ease(d3.easeCubic)
                .duration($("#speedslider").val()/2)
                .attr("style", "fill: rgb(0, 255, 146)");
            break;
        }
        case 11: { //light cyan - group 8
            bar.select("rect").transition()
                .ease(d3.easeCubic)
                .duration($("#speedslider").val()/2)
                .attr("style", "fill: rgb(0, 255, 238)");
            break;
        }
        case 12: { //light cyan - group 8
            bar.select("rect").transition()
                .ease(d3.easeCubic)
                .duration($("#speedslider").val()/2)
                .attr("style", "fill: rgb(0, 180, 255)");
            break;
        }
        case 13: { //light cyan - group 8
            bar.select("rect").transition()
                .ease(d3.easeCubic)
                .duration($("#speedslider").val()/2)
                .attr("style", "fill: rgb(0, 88, 255)");
            break;
        }
        case 14: { //light cyan - group 8
            bar.select("rect").transition()
                .ease(d3.easeCubic)
                .duration($("#speedslider").val()/2)
                .attr("style", "fill: rgb(4, 0, 255)");
            break;
        }
        case 15: { //light cyan - group 8
            bar.select("rect").transition()
                .ease(d3.easeCubic)
                .duration($("#speedslider").val()/2)
                .attr("style", "fill: rgb(96, 0, 255)");
            break;
        }
        case 16: { //light cyan - group 8
            bar.select("rect").transition()
                .ease(d3.easeCubic)
                .duration($("#speedslider").val()/2)
                .attr("style", "fill: rgb(188, 0, 255)");
            break;
        }
        case 17: { //light cyan - group 8
            bar.select("rect").transition()
                .ease(d3.easeCubic)
                .duration($("#speedslider").val()/2)
                .attr("style", "fill: rgb(255, 0, 230)");
            break;
        }
        case 18: { //light cyan - group 8
            bar.select("rect").transition()
                .ease(d3.easeCubic)
                .duration($("#speedslider").val()/2)
                .attr("style", "fill: rgb(255, 0, 138)");
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
        if(stages[stg][j][4]==1){
            move(bars[stages[stg][j][0]], j, 1, stages[stg][j][0]);
        }
        else{
            move(bars[stages[stg][j][0]], stages[stg][j][5], 2, stages[stg][j][0]);
        }
        if(stages[stg][j][2]==1) highlight(bars[stages[stg][j][0]], 3);
        else highlight(bars[stages[stg][j][0]], 2);
    }
    if(stages[stg][0][2]!=0){
        for(var i=0;i<dataset.length;i++){
            highlight(bars[stages[stg][i][0]], stages[stg][i][2]);
        }
    }
    else{
        for(var i=0;i<dataset.length;i++){
            highlight(bars[stages[s][i][0]], 0);
        }
    }
    if(paused) $("#playicon").attr("xlink:href", "icons/bootstrap-icons.svg#play-btn");
    else $("#playicon").attr("xlink:href", "icons/bootstrap-icons.svg#pause-btn");
    $("#textlog").val("");
    finished=false;
    //stg-=1;
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
            move(bars[stages[0][j][0]], j, 1, stages[0][j][0]);
            if (stages[0][j][2] == 1) highlight(bars[stages[0][j][0]], 3);
            else highlight(bars[stages[0][j][0]], 2);
        }

        stg=-1;
        finished=false;
        $("#playicon").attr("xlink:href", "icons/bootstrap-icons.svg#pause-btn");
        $("#textlog").val("");
    }
})

// FUNKCJE MERGESORT

//Funkcja wykonująca sortowanie podanych danych i generująca kroki dla funkcji wizualizującej
function merge(idxdata, l1, r1, l2, r2) {
    var temp=[];
    var idx=0;
    var text="";
    while(l1<=r1 && l2<=r2){
        stg++;
        stages[stg]=[];
        for(var i=0;i<dataset.length;i++){
            if(stg>0){
                if(stages[stg-1][i][4]==2){
                    stages[stg][i]=idxdata[i].concat([stages[stg-1][i][2], 0, 2, stages[stg-1][i][5]]);
                }
                else{
                    stages[stg][i]=idxdata[i].concat([stages[stg-1][i][2], 0, 1, 0]);
                }
            }else{
                stages[stg][i]=idxdata[i].concat([0, 0, 1, 0]);
            }
        }
        stages[stg][l1][3]=1;
        stages[stg][l2][3]=1;
        text="Porównywanie pierwszych elementów dwóch sąsiadujących podtablic "+stages[stg][l1][1]+" oraz "+stages[stg][l2][1]+".\n";
        desc[stg]="";
        desc[stg]+=text;
        text="";
        if(idxdata[l1][1]<=idxdata[l2][1]){
            temp[idx]=idxdata[l1];
            stg++;
            stages[stg]=[];
            for(var i=0;i<dataset.length;i++){
                if(stg>0){
                    if(stages[stg-1][i][4]==2){
                        stages[stg][i]=idxdata[i].concat([stages[stg-1][i][2], 0, 2, stages[stg-1][i][5]]);
                    }
                    else{
                        stages[stg][i]=idxdata[i].concat([stages[stg-1][i][2], 0, 1, 0]);
                    }
                }else{
                    stages[stg][i]=idxdata[i].concat([0, 0, 1, 0]);
                }
            }
            stages[stg][l1][2]=2;
            stages[stg][l1][4]=2;
            stages[stg][l1][5]=idx;
            text="Przenoszenie "+stages[stg][l1][1]+" na "+idx+" pozycję tablicy pomocniczej.\n";
            desc[stg]="";
            desc[stg]+=text;
            text="";
            console.log("Stage "+stg+": ");
            for(var i=0;i<dataset.length;i++){
                console.log(stages[stg][i]);
            }
            idx++;
            l1++;
        }
        else{
            temp[idx]=idxdata[l2];
            stg++;
            stages[stg]=[];
            for(var i=0;i<dataset.length;i++){
                if(stg>0){
                    if(stages[stg-1][i][4]==2){
                        stages[stg][i]=idxdata[i].concat([stages[stg-1][i][2], 0, 2, stages[stg-1][i][5]]);
                    }
                    else{
                        stages[stg][i]=idxdata[i].concat([stages[stg-1][i][2], 0, 1, 0]);
                    }
                }else{
                    stages[stg][i]=idxdata[i].concat([0, 0, 1, 0]);
                }
            }
            stages[stg][l2][2]=2;
            stages[stg][l2][4]=2;
            stages[stg][l2][5]=idx;
            text="Przenoszenie "+stages[stg][l2][1]+" na "+idx+" pozycję tablicy pomocniczej.\n";
            desc[stg]="";
            desc[stg]+=text;
            text="";
            console.log("Stage "+stg+": ");
            for(var i=0;i<dataset.length;i++){
                console.log(stages[stg][i]);
            }
            idx++;
            l2++;
        }
    }
    if(l1<=r1||l2<=r2) text="Scalanie reszty elementów.\n";
    while(l1<=r1){
        temp[idx]=idxdata[l1];
        stg++;
        stages[stg]=[];
        for(var i=0;i<dataset.length;i++){
            if(stg>0){
                if(stages[stg-1][i][4]==2){
                    stages[stg][i]=idxdata[i].concat([stages[stg-1][i][2], 0, 2, stages[stg-1][i][5]]);
                }
                else{
                    stages[stg][i]=idxdata[i].concat([stages[stg-1][i][2], 0, 1, 0]);
                }
            }else{
                stages[stg][i]=idxdata[i].concat([0, 0, 1, 0]);
            }
        }
        stages[stg][l1][2]=2;
        stages[stg][l1][4]=2;
        stages[stg][l1][5]=idx;
        text+="Przenoszenie "+stages[stg][l1][1]+" na pozycję "+idx+" tablicy pomocniczej.\n";
        desc[stg]="";
        desc[stg]+=text;
        text="";
        console.log("Stage "+stg+": ");
        for(var i=0;i<dataset.length;i++){
            console.log(stages[stg][i]);
        }
        idx++;
        l1++;
    }
    while(l2<=r2){
        temp[idx]=idxdata[l2];
        stg++;
        stages[stg]=[];
        for(var i=0;i<dataset.length;i++){
            if(stg>0){
                if(stages[stg-1][i][4]==2){
                    stages[stg][i]=idxdata[i].concat([stages[stg-1][i][2], 0, 2, stages[stg-1][i][5]]);
                }
                else{
                    stages[stg][i]=idxdata[i].concat([stages[stg-1][i][2], 0, 1, 0]);
                }
            }else{
                stages[stg][i]=idxdata[i].concat([0, 0, 1, 0]);
            }
        }
        stages[stg][l2][2]=2;
        stages[stg][l2][4]=2;
        stages[stg][l2][5]=idx;
        text+="Przenoszenie "+stages[stg][l2][1]+" na "+idx+" pozycję tablicy pomocniczej.\n";
        desc[stg]="";
        desc[stg]+=text;
        text="";
        console.log("Stage "+stg+": ");
        for(var i=0;i<dataset.length;i++){
            console.log(stages[stg][i]);
        }
        idx++;
        l2++;
    }
    return temp;
}

function mergesort(data) {
    var n = data.length;
    var idxdata = new Array();
    for (var i = 0; i < n; i++) {
        idxdata[i] = [i, data[i]]; //[index, value, color, comparison, layer, layer 2 position]
    }
    stg = -1;
    var text="";

    console.log("Tablica początkowa: ");
    for (var k = 0; k < n; k++) {
        console.log(idxdata[k]);
    }

    var len=1, i=0, l1=0, r1=0, l2=0, r2=0, temp=[];

    while(len<n){
        i=0;
        stg++;
        stages[stg]=[];
        for(var k=0, j=-1;k<dataset.length;k++){
            if(k%len==0) j++;
            stages[stg][k]=idxdata[k].concat([0, 0, 1, 0]);
            stages[stg][k][2]=j+3;
        }
        text="Dzielenie tablicy na podtablice o wielkości "+len+".\n";
        desc[stg]="";
        desc[stg]+=text;
        text="";
        while(i<n){
            l1=i;
            r1=i+len-1;
            l2=i+len;
            r2=i+(2*len)-1;
            if(l2>=n){
                break;
            }
            if(r2>=n){
                r2=n-1;
            }
            temp=merge(idxdata, l1, r1, l2, r2);
            for(var j=0;j<=r2-l1;j++){
                idxdata[i+j]=temp[j];
            }
            stg++;
            stages[stg]=[];
            for(var k=0;k<dataset.length;k++){
                if(stg>0){
                    if(stages[stg-1][k][4]==2){
                        stages[stg][k]=idxdata[k].concat([stages[stg-1][k][2], 0, 2, stages[stg-1][k][5]]);
                    }
                    else{
                        stages[stg][k]=idxdata[k].concat([stages[stg-1][k][2], 0, 1, 0]);
                    }
                }else{
                    stages[stg][k]=idxdata[k].concat([0, 0, 1, 0]);
                }
            }
            text="Przenoszenie elementów z tablicy pomocniczej do tablicy pierwotnej.\n";
            desc[stg]="";
            desc[stg]+=text;
            text="";
            for(var j=0;j<=r2-l1;j++){
                stages[stg][i+j][4]=1;
            }
            i=i+(2*len);
        }
        len=2*len;
    }



    console.log("Finalna tablica: ");
    for (var k = 0; k < n; k++) {
        console.log(idxdata[k]);
    }
    //showallstages();
    console.log("Etapy do tej pory:");
    console.log(stages);
    mergesort_vis();
    return idxdata;

}

//Funkcja wizualizująca selectionsort
async function mergesort_vis(){
    playing=true;
    var swapped=true;
    $("#playicon").attr("xlink:href", "icons/bootstrap-icons.svg#pause-btn");
    var progressbar = $("#progressbar");
    progressbar.attr("max", stages.length-1);
    progressbar.removeAttr("disabled");
    var textlog = $("#textlog");
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
        textlog.val("Etap "+s+": "+desc[s]+"\n"+textlog.val());
        if(!prgs_clicked){
            while(paused){
                await sleep(100);
            }
            if(stages[s][0][2]!=0){
                for(var i=0;i<dataset.length;i++){
                    highlight(bars[stages[s][i][0]], stages[s][i][2]);
                }
            }
            else{
                for(var i=0;i<dataset.length;i++){
                    highlight(bars[stages[s][i][0]], 0);
                }
            }

            while(paused){
                await sleep(100);
            }
            for(var i=0;i<dataset.length;i++){
                if(stages[s][i][3]==1) {
                    highlight(bars[stages[s][i][0]], 1);
                    swapped=false;
                }
            }

            if(swapped){
                while(paused){
                    await sleep(100);
                }
                for(var i=0;i<dataset.length;i++){
                    if(stages[stg][i][4]==2){
                        move(bars[stages[s][i][0]], stages[s][i][5], 2, stages[s][i][0])
                    }
                    else{
                        move(bars[stages[s][i][0]], i, 1, stages[s][i][0])
                    }
                }
            }
            else{
                await sleep($("#speedslider").val());
                while(paused){
                    await sleep(100);
                }
                for(var i=0;i<dataset.length;i++){
                    if(stages[s][i][3]==1) highlight(bars[stages[s][i][0]], stages[s][i][2]);
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
                highlight(bars[j], 2);
            }
            finished=true;
            $("#playicon").attr("xlink:href", "icons/bootstrap-icons.svg#arrow-repeat");
            textlog.val("Koniec sortowania.\n"+textlog.val());
        }
        while(s==stages.length-1) {
            s=stg;
            await sleep(100);
        }
    }
}

