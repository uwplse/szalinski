/*
"Parametric customizable BAR CLAMP V1" by ANDRES ROMAN (AKA Cuiso) August 2018

NUT JOB | Nut, Bolt, Washer and Threaded Rod Factory by mike_mattala Dec 1, 2013 (https://www.thingiverse.com/thing:193647)
was used for obtain "precompiled" screws and nuts files:
    SCREW-10-V2.stl    NUT-10-V2.stl
    SCREW-08-V2.stl    NUT-08-V2.stl
    SCREW-06-V2.stl    NUT-06-V2.stl
    SCREW-04-V2.stl    NUT-04-V2.stl
*/

// --- FIRST: SPECIFY PARAMETERS FOR CLAMP MEASUREMENTS and LEVEL OF DETAIL:
//screw_width: POSSIBLE VALUES 10, 8, 6, 4. Specifies the external diameter of the screw in millimeters. with 10 mm the screw supports a lot of force (for a plastic tool), with 4 mm you can make a really small clamp. 
screw_width = 08; 

//screw_long: Long of the screw, free value, the clamp not need too much long of screw to be functional
screw_long = 30;

//longviga: Long of the bar, in milimeters, free value.
longviga=70;

//longsep: Distance between the bar and the screw in each head, determines the size of the heads of the clamp, in milimeters, free value. 
longsep=30;

//alturarosca: Thickness of the part of the screw in arm, this determines also the thickness of the part of the bar, in milimeters, free value. 
//Higher values ​​for more solid and rigid parts. Lower values ​​for shorter printing times. Six is a good starting value for medium and bigs clamps.
//Min. value recommended if using screw_width equal to 4 for alturarosca is 4
//Min. value recommended if using screw_width equal to 6 for alturarosca is 4.5
//Min. value recommended if using screw_width equal to 8 for alturarosca is 5.5
//Min. value recommended if using screw_width equal to 8 for alturarosca is 6
alturarosca=5.5;

//holhuecovigatop: The clearance between the top head and the bar, less clearance provides a better functionality but it can cause the pieces not to fit, or fit with difficulty. Try to keep this parameter as low as possible, for my printer value 0.14 works fine.
holhuecovigatop=0.14;

//holhuecovigabot: The clearance between the lower head (the sliding head) and the bar, less clearance provides a better functionality but it can cause the pieces not to fit, or fit with difficulty. Try to keep this parameter as low as possible but allowing an easy slide, for my printer value 0.18 works fine.
holhuecovigabot=0.18;

$fn=100; //you can set $fn at a lower value to increase rendering speed but can loss details. Recomended value is 100

// --- SECOND: SPECIFY PARTS TO DRAW.
// you have to set to true the part o parts to draw, to false parts not to draw. Or set to true "all" to draw all. 
// If you set draw_keychain_hole to true a hole is made in the bar to be used, for example, on a keychain. I have a keychain with a small clamp and it's nice :-)

draw_all = true;
draw_screw = false;
draw_bottom_arm = false;
draw_top_arm = false;
draw_beam = false;
draw_push_platform = false;
draw_pin = false;
draw_keychain_hole = false;

// --- AND JUST PRESS F5 preview :-)


/* EXAMPLES OF PARAMETERS FOR DIFFERENT SCREW SIZES
screw_width screw_long  longviga longsep alturarosca holhuecovigatop holhuecovigabot $fn
4           15          40       15      4           0.14            0.18            100
6           20          50       22      4.5         0.14            0.18            100
8           30          70       30      5.5         0.14            0.18            100
10          35          80       35      6           0.14            0.18            100
*/

//>>>>>>>>>>>>>>>>>>>>>>
// This thing was tested with PLA
//>>>>>>>>>>>>>>>>>>>>>>
// Probably the precompiled scale of screw and bottom arm works ok for most 
// printers and filament but if you need more or less fit you can use scale([x,y,z]).
// Anyway, a bit of lubricant of any tipe on screw and sphere of the screw probably 
// will make it work better .
//
// If you want more fit between screw and bottom arm you can use for example
// scale([0.95,0.95,1]) preceding import of nut .stl files in lines 359->362
//
// If you want less fit between screw and bottom arm you can use for example
// scale([1.05,1.05,1]) preceding import of nut .stl files in lines 359->362
//>>>>>>>>>>>>>>>>>>>>>>

/*TEST, for print a test screw and nut in bottom arm without complete print
difference(){
union(){
    bottom_arm();
    complete_screw();
    }
cube([150,110,100],center=true);
}
*/

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
// MODULES
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
if(screw_width != 4 && screw_width != 6 && screw_width != 8 && screw_width != 10){
    color("red")
    rotate([45,0,45]){
    translate([-25,0,0])  text(size=3, "ERROR: You have to choose ");
    translate([-25,-10,0])text(size=3,"an screw_width 10, 8, 6, or 4");
    }
}
else
{
if(draw_all) {
    complete_screw();
    bottom_arm();
    beam();
    top_arm();
    complete_push_platform();
    pin();
}
if(draw_screw) complete_screw();
if(draw_top_arm) top_arm();
if(draw_bottom_arm) bottom_arm();
if(draw_beam) beam();
if(draw_push_platform) complete_push_platform();
if(draw_pin) pin();
    
}


//screw
module complete_screw(){
translate([-longviga/2+diamcab*1.2,-longsep-anchoviga-screw_width/2-largocabviga/2-longala,0])
{
if(screw_width==10) push_screw(screw_long,10,14);
else push_screw(screw_long,10,12);
}
}

module complete_push_platform()
{
translate([-longviga/2+diamcab*2.5,-longsep-largocabviga,-alturarosca/2]){
    if(screw_width == 4)  push_platform(1.3,  6, 8*screw_width/10, 1.70, 0.2,0.15);
    if(screw_width == 6)  push_platform(1.5,  8, 8*screw_width/10, 1.55, 0.5,0.20);
    if(screw_width == 8)  push_platform(2, 10, 8*screw_width/10, 1.42, 0.75,0.15);
    if(screw_width == 10) push_platform(2.5, 12, 8*screw_width/10, 1.35, 1,0.20);
}
}

//viga
anchoviga=screw_width*7/10;
largoviga=screw_width*15/10;

alturacabviga=alturarosca*1.5;
diamcab=screw_width*1.6;
largocabviga=screw_width*2.60;
anchocabviga=screw_width*2.00;
altobrazo=alturarosca/3;
anchonervio=screw_width*0.60;
anchohueco= anchoviga + holhuecovigatop;
largohueco= largoviga + holhuecovigatop;
bajadacunya=alturarosca/2+(alturacabviga-alturarosca)-alturacabviga/2;
bajadacunyaviga=-alturacabviga/2;

anchohuecoalto= anchoviga + holhuecovigabot*0.9; //A BIT LESS SPACE SIDE
largohuecoalto= largoviga + holhuecovigabot;
longala=1;
espesorala=2;
espesoralahol=espesorala+holhuecovigabot*1.5;

//////////////////////////////////////////////////////////////////////////////////

module stlscrew(diam){
    if(diam==10) import("SCREW-10-V2.stl", convexity=3);
    if(diam==8)  import("SCREW-08-V2.stl", convexity=3);
    if(diam==6)  import("SCREW-06-V2.stl", convexity=3);
    if(diam==4)  import("SCREW-04-V2.stl", convexity=3);
}
//////////////////////////////////////////////////////////////////////////////////
module pin(){
    holgpin=0.25;
    translate([longviga/2-anchocabviga*1.1,-anchoviga-anchocabviga/2*1.5,(1.5-holgpin)/2-alturarosca/2]) 
    rotate([0,0,90])
intersection()
{
cube([largocabviga/4-holgpin,anchocabviga-holgpin,1.5-holgpin],center=true);
resize([largocabviga,anchocabviga,0]) cylinder(d=anchocabviga,h=alturacabviga,center=true);
}
}

module esfera(){
translate([0,0,8/2/3]) sphere(d=8,center=true);
translate([0,0,5])
cylinder(h=5, r1=3, r2=4, center=true);
}

//////////////////////////////////////////////////////////////////////////////////
module push_platform(grosorbase, diambase, diamesfera, offcyl, anchocorte, holgesf){
difference(){
union(){
cylinder(d=diambase, h=grosorbase);
translate([0,0,grosorbase])cylinder(d=diamesfera*offcyl, h=diamesfera*0.7);
}    
translate([0,0,grosorbase+diamesfera/2])sphere(d=diamesfera+holgesf);

for(ic = [0 : 360/3 : 360/3*(3-1)]) 
rotate([0,0,ic])
translate([0,diamesfera*offcyl/1.3,grosorbase+diamesfera*0.7/2]) 
cube([anchocorte,diamesfera*offcyl,diamesfera*0.7+0.001],center=true);
}
}
//////////////////////////////////////////////////////////////////////////////////
module push_screw(long,longmango,diammango){  
translate([0,0,screw_width/10*longmango-0.1-alturarosca/2]){
difference(){
stlscrew(screw_width);
translate([0,0,long]) cylinder(d=11,h=120);
}

scale([screw_width/10,screw_width/10,screw_width/10])mango(diammango, longmango);

if(screw_width==10) despesfera(7.3,long);
if(screw_width==06) despesfera(4.45,long);
if(screw_width==08) despesfera(5.85,long);
if(screw_width==04) despesfera(2.8,long);
    
}

module despesfera(desp,long){
    translate([0,0,desp+long])
    scale([screw_width/10,screw_width/10,screw_width/10])
    rotate([180,0,0])esfera();
}
}

module mango(diam, altura){
translate([0,0,-altura/2+0.1]) cylinder(d=diam,h=altura,center=true);

translate([0,0,-altura/2+0.1])
for(k = [0 : 60 : 360])
rotate([0,0,k])
translate([diam/2,0,0])
rotate([0,0,45])
//cube([0.5,0.5,altura],center=true);
cylinder(d=5,h=altura,center=true);
}


//brazo bajo
module top_arm(){
translate([longviga/2,-longsep-anchoviga*1.5-largocabviga/2,0])
rotate([0,0,90])
difference(){
cuerpo_top_arm();
//translate([0,0,0])negativo_rosca(screw_width);
hueco_column();
cunya();
}
}

//brazo alto
module bottom_arm(){
translate([-longviga/2,-longsep-anchoviga*1.5-largocabviga/2-longala,0])
rotate([0,0,90])
difference(){
cuerpo_bottom_arm();
translate([0,0,-0.001])negativo_rosca(screw_width);
hueco_alto_column();
}
}

//viga
module beam(){
translate([0,0,anchoviga/2-alturarosca/2])
if(draw_keychain_hole) difference(){viga_principal(); cunya_column(); keychain_hole();}
else difference(){viga_principal(); cunya_column();}
}

module keychain_hole()
{
   translate([-longviga/2-bajadacunyaviga+screw_width/10-1,0,0]) {
   if(screw_width==4)  cylinder(h=anchoviga+0.001, d=1.5,center = true);
   if(screw_width==6)  cylinder(h=anchoviga+0.001, d=1.7,center = true);
   if(screw_width==8)  cylinder(h=anchoviga+0.001, d=2.0,center = true);
   if(screw_width==10) cylinder(h=anchoviga+0.001, d=2.5,center = true); 
   } 
}

module cunya_column(){
translate([longviga/2+bajadacunyaviga,0,0])
rotate([90,0,90])
cube([largocabviga/4,anchocabviga,1.5],center=true);
}

module cunya(){
translate([longsep,0,bajadacunya]) 
cube([largocabviga/4,anchocabviga,1.5],center=true);
}



//////////////////////////////////////////////////////////////////////////////////
module hueco_alto_column(){
translate([longsep,0,(alturacabviga - alturarosca)/2])  
cube([largohuecoalto,anchohuecoalto,alturacabviga+0.001],center=true);

if(screw_width==4 || screw_width==6)
translate([longsep,0,(alturacabviga - alturarosca)/2+alturacabviga/2-espesoralahol/2/2])  
cube([largohuecoalto+longala*2+holhuecovigabot*2,anchohuecoalto,espesoralahol/2+0.001],center=true);
else
translate([longsep,0,(alturacabviga - alturarosca)/2+alturacabviga/2-espesoralahol/2])  
cube([largohuecoalto+longala*2+holhuecovigabot*2,anchohuecoalto,espesoralahol+0.001],center=true);
}
//////////////////////////////////////////////////////////////////////////////////
// brazo alto
module hueco_column(){
translate([longsep,0,(alturacabviga - alturarosca)/2])  
cube([largohueco,anchohueco,alturacabviga+0.001],center=true);
}

module cabezas(){
cylinder(d=diamcab,h=alturarosca,center=true);

translate([longsep,0,(alturacabviga - alturarosca)/2]) 
resize([largocabviga,anchocabviga,0])
cylinder(d=anchocabviga,h=alturacabviga,center=true);
}

module cabezas1(){
resize([diamcab*1.4,0,0])
cylinder(d=diamcab,h=alturarosca,center=true);

translate([longsep,0,(alturacabviga - alturarosca)/2]) 
resize([largocabviga,anchocabviga,0])
cylinder(d=anchocabviga,h=alturacabviga,center=true);
}


module cuerpo_top_arm(){
translate([0,0,-alturarosca/2+altobrazo/2])
linear_extrude(height = altobrazo, center = true, convexity = 10) 
projection()
hull(){cabezas1();}
cabezas1();
translate([0,0,-alturarosca/2]) ///////////nervio
rotate([90,0,0])
linear_extrude(height = anchonervio, center = true, convexity = 10) 
polygon(points=[[-diamcab/2-1,0],[longsep - largocabviga/2 +1,0],
                [longsep - largocabviga/2 +1,alturacabviga],
                [-diamcab/2-1,alturarosca]]);
}

module cuerpo_bottom_arm(){
translate([0,0,-alturarosca/2+altobrazo/2])
linear_extrude(height = altobrazo, center = true, convexity = 10) 
projection()
hull(){cabezas();}
cabezas();
translate([0,0,-alturarosca/2]) ///////////nervio
rotate([90,0,0])
linear_extrude(height = anchonervio, center = true, convexity = 10) 
polygon(points=[[diamcab/2-1,0],[longsep - largocabviga/2 +1,0],
                [longsep - largocabviga/2 +1,alturacabviga],
                [diamcab/2-1,alturarosca]]);
}


module negativo_rosca(diarosca){
translate([0,0,-alturarosca/2-0.001]){
if(diarosca==10)import("NUT-10-V2.stl", convexity=3);
if(diarosca==8) import("NUT-08-V2.stl", convexity=3);
if(diarosca==6) import("NUT-06-V2.stl", convexity=3);
if(diarosca==4) import("NUT-04-V2.stl", convexity=3);
}
}

//////////////////////////////////////////////////////////////////////////////////
// viga
module viga_principal(){
    difference(){
        cube([longviga,largoviga,anchoviga],center=true);
        dentado();
    }
    translate([-longviga/2+espesorala/2,0,0])
    cube([espesorala,largoviga+longala*2,anchoviga],center=true);
}


module dentado(){
for(i = [-longviga/2+1 : 1 : longviga/2])
translate([i,largoviga/2,0])rotate([0,0,45]) cube([0.5,0.5,anchoviga+0.001],center=true);

for(i = [-longviga/2+1 : 1 : longviga/2])
translate([i,-largoviga/2,0])rotate([0,0,45]) cube([0.5,0.5,anchoviga+0.001],center=true);
}

/////////////////////////////////////////////////////////////////////////

