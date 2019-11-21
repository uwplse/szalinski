/* [Global] */
/* [Cacti settings] */
// The amount of cacti still randomizes, this just ups the highest limit. ALSO WHAT YOU SEE IS NOT WHAT GETS GENERATED! Just click the button and see what it churns out.
num_of_cacti = 5; // [1:50]
// This is a static number, all cacti will have the same number of side facets.
cacti_side_facets = 10; // [5:50]


/* [Hidden] */
listcactip = rands(0,num_of_cacti,1);

module cactusPart(height){
    listcw = rands(.55,.85,1);
    cactusw=listcw[0];
    listcl = rands(.35,.45,1);
    cactusl=listcl[0];
    listch = rands(1.75,3,1);
    cactush=listch[0];
    difference(){
        scale([cactusw,cactusl,cactush]) sphere(d=height, $fn = cacti_side_facets);
        translate([-10,-10,-90])cube([1000,1000,80]);
    }
}

module cactusMake(){
    cactip=listcactip[0];
    for (i = [0 : cactip]){
        //i in the list lets us pull 1 of the num_of_cacti values generated depending on what i is as it cycles the for loop.
        //angles start here.
        listcxa = rands(-20,20,num_of_cacti);
        cactusxa=listcxa[i];
        listcya = rands(-20,20,num_of_cacti);
        cactusya=listcya[i];
        listcza = rands(-40,40,num_of_cacti);
        cactusza=listcza[i];

        //axises start here.
        listcx = rands(-25,25,num_of_cacti);
        cactusx=listcx[i];
        listcy = rands(-25,25,num_of_cacti);
        cactusy=listcy[i];
        listcz = rands(-5,0,num_of_cacti);
        cactusz = listcz[i];
        
        //Height value for the generator.
        listcsh = rands(10,30,num_of_cacti);
        cactussh = listcsh[i];
        //Combining the code.
        color([.3, .5, .3])translate([cactusx,cactusy,cactusz])rotate([cactusxa,cactusya,cactusza])cactusPart(cactussh);
        i=i+1;
    }
}

difference(){
    cactusMake();
     translate([0,0,-15])cube([100,100,30],true);
}
color([.9, .7, .3])translate([0,0,0])scale([1,1,4])circle(50,h=10);