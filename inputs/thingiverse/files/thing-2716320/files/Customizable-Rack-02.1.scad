/************** Publication Notes ***************/{/*

Customizable Rack by SavageRodent
Original at: https://www.thingiverse.com/thing:2716320
Last updated: 19/02/2018
Published under: the Creative Commons CC - BY 3.0 licence
Licence details here: https://creativecommons.org/licenses/by/3.0/
*/}

/*********** CUSTAMIZABLE PERAMITORS ************/{
//This section contains all the values you NEED to set
   
diameter                = 47.6; //diameter of jar + a tolerance eg 0.6mm
hight_back              = 45;   //hight of back split of spice rack
hight_front             = 25;   //hight of front split of spice rack
wall_thicknes           = 2;    //minamum thicknes of the sides of the rack
number_or_comsplitments = 4;    //how many jars each rack will hold 
extend                  = 0;    //increase the distance between compartments
back_depth              = 0;    //increase the distance from wall too compartments

screw_diameter          = 3.5;  //diaetor of the threaded split of the screw
screw_head_diameter     = 6.8;  //screw head diamitor
screw_head_depth        = 2.6;  //distance between the top of the screw and where the thread begins 

screw_slots_middle      = 1;    // [ 0=NO, 1=Yes ] add screw slots between comsplitments
screw_slots_ends        = 1;    // [ 0=NO, 1=Yes ] add screw slots at either end of rack. note the end slots have less room than the middle slots so if the screw are to big they are mor likly to intsect rack comsplitments. 

bottom_hole_diameter    = diameter*.7; // valeu rang between 1 & 0. [ 0=NO WHOLE, 1=NO FLOOR ]

front_opening_width     = diameter*.0;  //adds a gap at the front of each comparment, for easy accsess. [ 0=NO OPENING ]

show_cutaway            = 0;    // [ 0=NO, 1=Yes ] show_cutaway is a preview tool. it removes the top section of the rack so u can inspect the screw slots. 



/* DUEL EXTRUDER print options (stripes) */{ 
//To make things more intrestin I've added this decorative option which enables peolpe with duel extruder printers to add stripes to their rack design. 

split               = 0;        // [ 0=NO SPLIT, 1=SPLIT PART ONE, 2=SPLIT PART TWO ]
//To export a duel materal ie stripy rack, simpl set "split" to =1 then render and export, next set "split" to =2 then render and export again. Your then redy to merge the stl files in your slicer.

stripe_preset       = 1;        // [ 0=NO preset, 1=TOP-BOTTOM, 2=SIDE-SIDE, 3=FRONT-BACK ]    
// The stripe presets 1-3 link the rack dimentions, "stripe_rotation" & "stripe_number" so the "stripe_number" will be the actual number of strips you get.

stripe_number       = 4;        //for presets 1-3 this will be the number of strips on the rack. For preset 0 it will have no effect.

custom_stripe_width = 15;       //only works if (stripe_preset = 0)

//custom_rotate axis   x,y,z
custom_rotate       = [0,45,0]; //only works if (stripe_preset = 0)

custom_offset       = 35.8;     /*moves the stripes at a rightangle to the direction of the stripes themselves for fine tuning the postion */}


/************* END of CUSTAMIZABLE PERAMITORS ************/
}


/*Varibles fowr use in code:*/{
//This section is fowr creating abreveated verables names, compound varibles and the addition of some tolerances

di      = diameter;                 //diamitor of jar + a 0.2 tolerance
hf      = hight_front;
hb      = hight_back;
wt      = wall_thicknes;    
wth     = wt/2;
wtb     = 2;                        //wall thickness back, securing the screw
com     = number_or_comsplitments;
ex      = (extend<0 ? 0:extend);    // additionl spaceing between compartments
exh     = extend/2;                 // half additionl spaceing
bd      = back_depth;

sd      = screw_diameter + .2;
shdia   = screw_head_diameter + .2;
shdep   = screw_head_depth + .6; 
hd      = shdia* 2;                 //hight differance between screw hole and back
shh     = hb - hd;                  //screw hole hight

w       = di + (wt*2);              //width = diameter + wall_thickness
wh      = w / 2;                    //width half
fdin    = w / 2;                    //defult fillet diameter 
fd      =(fdin<((hb-hf)*2)) ? fdin : (hb-hf)*2; //fillet diameter if smaller than def


fr      = fd / 4;                   //fillet radeus
frfo    = fdin / 4;                 //fillet radeus frint opening
bhd     = bottom_hole_diameter;     //bottom hole diameter,(hole beneath jar) 
rou     = wh * .4;                  //round gap between comsplitments
fow     = front_opening_width;
fowh    = fow/2;

}
//These rack dimentions can be viewed i the console

rack_depth = (w+bd) -(wh - sqrt((wh*wh)-(fow/2)*(fow/2))); //without and with front opening


rack_width  = (w*com)+ (ex*(com-1)); 
rack_hight  = hb;

echo("*** RACK DIMENTIONS ***"); 
echo(str("Hight                          =  " ,rack_hight)); 
echo(str("Width                         =  ", rack_width)); 
echo(str("Depth                         =  ", rack_depth)); 
echo(str("Bottom Hole Diameter  =  ", bottom_hole_diameter));
echo(str("Front Opening Width    =  ", front_opening_width));


module basic_shape(){
difference(){
linear_extrude(hb){
circle(d=w, $fn=100);
polygon(points =[[wh,0],[wh,-(wh+bd)],[-wh,-(wh+bd)],[-wh,0]]);
}
//hole for jar
translate([0,0,wt]){
cylinder(h=hb, d=di, $fn=100);
}
//hole beneath the jar
translate([0,0,-1]){
cylinder(h=hb, d=bhd, $fn=100);
}
}
}




module hights_and_fillets(){
translate([(w+ex)*(com-.5),0,0]){
rotate(a = [0,-90,0]){
linear_extrude((w+ex)*com+2){
difference(){
union(){
//front and back hights 
translate([0,0,-1]){
polygon(points =[ [hf+fr,0], [hf,fr], [hf,wh+1], [hb+1,wh+1], [hb+1,-wh], [hb,-wh], [hb,-fr], [hb-fr,0]] );
}
//fillets front
translate([hf+fr, fr, -1]){
circle(r = fr, $fn=50);
}
}
//fillet back
translate([hb-fr, -fr, -1]){
circle(r = fr, $fn=50);
}
}
}
}
}
}



module round_between_com(){
whwth = wh+wth;
hyp = sqrt((wh+exh)*(wh+exh)+(rou*rou));      //hypotenuse      
//hyp = sqrt(wh*wh+(rou*rou));      //hypotenuse  back up    

linear_extrude(hb){
translate([wh,0,0]){
difference(){
//trange to cut from
polygon(points =[[wh+exh,0],[wh+exh,-(wh+bd)],[-wh-exh,-(wh+bd)],[-wh-exh,0], [0,rou]]);   
//com cuting shap 1
translate([wh+(ex/2),0,0]){
circle(r = wh-wth, $fn=100); 
}
//com cuting shap 1
translate([-wh-(ex/2),0,0]){
circle(r = wh-wth, $fn=100); 
}
//
translate([0,rou,0]){
circle(r = hyp-wh, $fn=100); 
}
}
}
}
}
/*
color("green"){
polygon(points =[[wh,0],[wh,-wh],[-wh,-wh],[-wh,0], [0,rou]]);   
}
//com cuting shap 1
translate([wh,0,0]){
circle(r = wh-wth, $fn=100); 
}
//com cuting shap 1
translate([-wh,0,0]){
circle(r = wh-wth, $fn=100); 
}
//
translate([0,rou,0]){
circle(r = hyp-wh, $fn=100);
}
*/
  

module screw_holes(){
//screw head hole  
    translate(v=[wh,-wh+(shdep+wtb)-bd,hd/2]){
 rotate([0,-90,180]) { 
    translate(v = [0, 0, -shdia/2]) {
  linear_extrude(shdia){
   polygon(points=[[0,0],[shh,0],[shh,shdep],[shh-shdia,shdep],[0,shdep+1]]);
  }
  }
//screw hole
translate(v = [0, 0, -sd/2]) {  
cube([shh,shdep+wtb+5,sd]);
}

//round top of screw holes
rotate([-90,0,0]){
translate(v = [shh, 0, 0]) {
union(){
cylinder(h = shdep, d = shdia, center = false, $fn=20);
cylinder(h = shdep+wtb+5, d = sd, center = false, $fn=20);
}
}
}
rotate([-90,0,0]){
union(){
cylinder(h = shdep+wtb+5, d = shdia, center = false, $fn=20);
}
}
}
}
}


module open_at_front(){
module o_a_f_half(){
rotate(a=[90,0,180]){
linear_extrude(w){
difference(){
polygon(points=[[-.01,-1], [fowh,0], [fowh,hf], [fowh,hf-frfo], [fowh+frfo,hf], [fowh+fr,hf+1], [-.01,hf+1]]);
translate([fowh+frfo,hf-frfo]){
circle(r=frfo,$fn=40);
}
}
}
}
}
mirror(0,1,0){
o_a_f_half();
}
o_a_f_half();
translate([0,0,-1]){
cylinder(h=wt*2, d=fow, $fn=100);
}
}


module combine_all_modules(){
color("darkorange")
rotate([0,0,180]){                               //face front
translate([-((((w*com)+(ex*(com-1)))/2)-(w/2)), bd/2, -hb/2]){     //center rack
difference(){
union(){
//duplicate basic shape
for (i=[1:com]) {
translate([(-1+i)*(w+ex),0,0]) 
basic_shape();
}
//duplicate round between com
if(com>1){
translate([ex/2,0,0]){ 
for (i=[1:com-1]) {
translate([(-1+i)*(w+ex),0,0]) 
round_between_com();
}
}
}       
}

//add screw slots middle
if (screw_slots_middle == 1){
if(com>1){
translate([exh,0,0]){ 
for (i=[1:com-1]) {
translate([(-1+i)*(w+ex),0,0]) 
screw_holes();
}
}
} 
}
//add screw slots ends
if (screw_slots_ends == 1){
translate([-(w-((shdia/2)+1)),0,0]) 
screw_holes();
translate([((w+ex)*(com-1)-((shdia/2)+1)),0,0]) 
screw_holes();
}
//cut to hight
hights_and_fillets();
//cut front opening gap or not
for (i=[1:com]) {
if(front_opening_width == 0){
//dont cut front opening
}
else{
for (i=[1:com]) {
translate([(-1+i)*(w+ex),0,0]) open_at_front();
}
}
}


//cutaway too for checking screw slots are not to deep
if(show_cutaway == 1){
translate([-(w/2)-1,-((w/2)+bd+1),hb/2])
#cube([(w+ex)*com+2,(w+bd)+2,hb+2]);

}
}
}
}
}


//stripes

// stripe_preset             0              1          2           3
// project along             ?              x          y           z                           
fit_dimention       = [  rack_width,   hight_back, rack_width, rack_depth]; 
stripe_rotate       = [custom_rotate,   [0,0,90],   [0,90,0],   [90,0,0] ] ;    //

//echo("fit_dimention ", fit_dimention[0] );

sw_preset           = (fit_dimention[stripe_preset]/stripe_number); //preset stripe_width calculation 
stripe_width        = [custom_stripe_width, sw_preset, sw_preset, sw_preset] ;//sw_preset ;     

sw                  = stripe_width[stripe_preset];

echo(str("Stripe Width                =  ", sw));

encompass       = ((rack_width*3)/2) / sw;    
//"encompass" ensures there are enough srip objects to encompus the whole rack     



module stripe(){                //single strip
if(stripe_preset > 0){
if (stripe_number%2==0){        //use offset if there's an even number of stripes 
translate([0,0,sw/2])  //offset
cube([rack_width*3, rack_width*3, sw], center=true); 
}
else
cube([rack_width*3, rack_width*3, sw], center=true); 
}
else
translate([0,0,custom_offset])
cube([rack_width*3, rack_width*3, sw], center=true); 
}


module stripe_all(){                        //roate all stripes
rotate(a=stripe_rotate[stripe_preset]){ 
for(a = [0:encompass/2]){
translate([0,0,a*(sw*2) ]){                 //generat strip objects in one direction
stripe();
}
}
for(a = [1:encompass/2]){
translate([0,0,a*-(sw*2) ]){                //generat strip objects in the opersit direction
stripe();
}
}
}
}

//generate finshed object

if (split == 1){        //rack cut into stripes, split part ONE
color("Goldenrod")
difference(){            
combine_all_modules();  
stripe_all();
}
}
else
if (split == 2){        //rack cut into stripes, split part TWO
color("FireBrick")
intersection(){         
combine_all_modules();
stripe_all();
}
}
else{
combine_all_modules();  //rack not cut into stripes
}



