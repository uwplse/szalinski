$fn=40;

//taille du pico APRS
picoX=33.5;
picoY=24.5;
picoZ=59;

//diamètre antenne
antenne=16.5;  //16.5 for nagoya NA-771
connect=40;    //high connector antenna

//épaisseur du boitier
paroi=1.5;

//attach
fixation=16;
    
    
difference(){
    //boitier à imprimer
leftbox=3.8;        
    union(){
        hull(){
        translate([-paroi-leftbox,-paroi,-paroi])cube ([picoX+(2*paroi)+leftbox,picoY+(2*paroi),picoZ+(2*paroi)]);  //box
        translate([picoX*2/3+3+paroi,-paroi,-fixation/2-1])rotate([270,0,0])cylinder(r=fixation/2+paroi*2, h=picoY+2*paroi); // attachdown
        translate([picoX*2/3+3+paroi,-paroi,picoZ+fixation/2+2])rotate([270,0,0])cylinder(r=fixation/2+paroi*2, h=picoY+2*paroi); //attachUP
      
        }
        hull(){
        translate([6,10,picoZ+connect])cylinder(r=antenne/4, h=4); //antenna support
        translate([6,10,picoZ])cylinder(r=antenne/2+3, h=connect); //antenna support
        translate([6,10,-3])cylinder(r=antenne/4, h=2); //antenna support
        }
}


    // choses à enlever
    enlever();
    bigantenne();
    picoAPRS();  // original picoAPRS
}    
    





module enlever(){
//tout ça est à retirer

//deux fixation pour attacher le tout sur quelque chose
translate([picoX*2/3+3+paroi,40,-fixation/2-1])rotate([90,0,0])cylinder(r=fixation/2, h=60); //attachdown
translate([picoX*2/3+3+paroi,40,picoZ+fixation/2+2])rotate([90,0,0])cylinder(r=fixation/2, h=60); ////attachUP

//dégagement face avant
color("red"){translate([4,-5,5])cube([26,15,40]);} //

//ease install picoAPRS
translate([6,10-5,54])cube([60,10,10]); //for translate picoAPRS SMA
cube ([picoX*2,picoY,picoZ]); // for translate picoAPRS box
translate([-25,12,28])rotate([0,90,0])cylinder(r=5, h=40); // pour ejecter le picoAPRS
translate([4,2,-50])cube([16,13,55]); // USB




}


//couvercle
translate([60,0.5,0.5]){
    cube ([4,23.5,picoZ-1]);
    hull(){
        translate([0,6,picoZ-1.2])cube ([4,8,4]);
        translate([-10,6,picoZ-1.1])cube([12,8,2]);
    }
}







module picoAPRS() {
color("blue"){
cube ([picoX,picoY,picoZ]);
translate([6,10,55])cylinder(r=4, h=8);}
}

module bigantenne(){
    translate([6,10,55])cylinder(r=antenne/2, h=60);}



