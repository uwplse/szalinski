/* Publication Notes */{/*

Customizable Loaded Dice by SavageRodent
Original at: https://www.thingiverse.com/thing:2778633
Last updated: 24/08/2018
Published under: the Creative Commons CC - BY 3.0 licence
Licence details here: https://creativecommons.org/licenses/by/3.0/

*/}
/*********** CUSTAMIZABLE PERAMITORS ************/{
//Note: To make scaling simpler, the dimentions are expressed, directly or inderectly, as fractions of the "dice_size". To see the dimentions as decimals, press F5 (preview) and view the updated, decimal values in the console. 

show_cutaway    = 0;   // [ 0=NO 1=YES ]
//show_cutaway is a preview tool. it removes a 1/4 section of the dice so u can inspect the inside. DON'T FORGET to disable (set to "0") befor u render for export.

dice_size       = 20;                   
//dice_size = (hight, width & depth) of the dice.

wall_thickness = (dice_size/2)*.20;

load_size       = 0;    // %          
//load_size = the volume of solid fill inside the dice, causing it to favor laying on a particular side.  0% = no loading, 100% = maximum loading, 200% = solid infill

loaded_number   = 6;    // between 1-6                
//loaded_number = the side of the dice to be loaded in favor of

character       = 1;   //[ 0=text, 1=dots_domed, 2=dots_round ] 
//characters= the sybols on the sides of the dics dots, numbers, words etc

depth       = (wall_thickness/2)*.5;     //
//depth = how deep the dotos or text charactersare are embossed into the dice. maximum depth is half wall thickness. "depth" is not aplicable to domed dots.

/* dot settings: */{

dot_size        = dice_size*.2;                 
//dot_size = diamitor of the dot

dot_spaceing    = dice_size/4.1;               
//dot_spaceing = the distance from the center of one dot to the center of its nearist neighbor      

dot_smooth      = 30;
//dot_smooth = the number of polgons in each dot. higher value = smoother 

dice_smooth     = 80; 
//dice_smooth  = the number of polgons in cuved parts of the dice. higher value = smoother 
/* end of dot settings */}


/* text settings: */{

//side of the dice  1      2      3      4      5      6  
txt_charicters  =[ "1",   "2",   "3",   "4",   "5",   "6", ]; 
//text_character, to change the charictors on the dice simply replace the numbers inside the quotation marks with the whatever numbers, words, symbols etc you want. 

// DEFAULT text settings. 
// These valus will be used for text ALL charicters unless replased in the custom text settings.

/* font      default    */ fd   = "arile";      // name of a font   
/* bold      default    */ bd   = 1;            // bold?    [0=no, 1-yes]
/* italic    default    */ id   = 0;            // italic?  [0=no, 1-yes]
/* spaceing  default    */ spcd = 1;            // size of spacing between charicters
/* size      default    */ sizd = dice_size*.7; // size of text / charicters
/* direction default    */ dd   = 0;            // 0=left-to-right), 1=right-to-left), 3=top-to-bottom 4=bottom-to-top
/* smothness default    */ smod = 40;           //  
/* align_h   default    */ ahd  = 0;            // move charicter horazontaly
/* align_v   default    */ avd  = 0;            // move charicter  verticly
/* rotate    default    */ rd   = 0;            // rotate charicter 


// CUSTOM text settings. 
// To set a custom value for any setting of any charicter simply supliment or replace the default value with one of your chice. Note: Many fonts don't center correctly, so u might want to use the default align_h & v to get the averige center point then tweak any chariters still off center by + or - in custom text settings 

//side of the dice 1      2      3      4      5      6
txt_font        =[ fd,    fd,    fd,    fd,    fd,    fd,  ];   // name of a font eg "arile" (include quotation makes)
txt_bold        =[ bd,    bd,    bd,    bd,    bd,    bd   ];   // bold?    [0=no, 1-yes]
txt_italic      =[ id,    id,    id,    id,    id,    id,  ];   // italic?  [0=no, 1-yes]
txt_spaceing    =[ spcd,  spcd,  spcd,  spcd,  spcd,  spcd ];   
txt_size        =[ sizd,  sizd,  sizd,  sizd,  sizd,  sizd ];   
txt_direction   =[ dd,    dd,    dd,    dd,    dd,    dd   ];   // 0="ltr", 1="rtl", 2="ttb", 3="btt"
txt_smothness   =[ smod,  smod,  smod,  smod,  smod,  smod ];   
txt_align_h     =[ ahd+0, ahd+0, ahd+0, ahd+0, ahd+0, ahd+0];  
txt_align_v     =[ avd+0, avd+0, avd+0, avd+0, avd+0, avd+0];   
txt_rotate      =[ 90,    rd,    rd,    rd,    rd,    90   ];   
/*end of text settings */}

//Dule Materal Options:

dule_materal_cut = 0;   //[ 0=NONE, 1=OUTSIDE, 2=INSIDE ]
/*This option enables u to splits the dice into two parts, the inside + characters and the outside.  Simply change the value from "0" too "1" then render and export the STL. Next change the value to "2" then render and export the STL again.*/  

/******** end of CUSTAMIZABLE PERAMITORS *******/}


/* miscellaneous */{

hollow          = dice_size-(wall_thickness*2);       


load_1_percent = hollow/100;

//                  0      1      2      3
text_direction = ["ltr", "rtl", "ttb", "btt"];
//td = text_direction[dd];   //tdd = text_direction 

//                  0      1      2      3
text_direction = ["ltr", "rtl", "ttb", "btt"];
//td = text_direction[dd];   //tdd = text_direction 
bo = [" ", "bold: "];       //bold or not bold
it = [" ", "italic "];      //italic or not italic

cut_color=[77/255, 94/255, 210/255];


/* end of miscellaneous */}

/* view customzable peramitors as decimals */{

//The echo() funtions below return the customzable peramitors as decimals that can be viewed in the consele.
echo("********* DIMENTIONS *********");
echo(str("Dice Size           ",dice_size));
echo(str("Wall Thickness   ",wall_thickness));
echo(str("Hollow Size       ",hollow));
echo(str("Load Size          ",(load_size/hollow)*100," %"));
echo(str("Dot Size            ",dot_size));
echo(str("Dot Spaceing     ",dot_spaceing));
echo(str("Depth               ", depth));

/* end of view customzable peramitors */}

/* shapes */{ 
module outside_shape(){                             //outside shape
intersection() {
sphere(d = dice_size*1.381, $fn = dice_smooth);             
cube(size = dice_size, center = true);
}
}

module inside_shape(){                              //inside shape (hollow)
intersection() {
sphere(d = hollow*1.381, $fn = dice_smooth);                
cube(size = hollow, center = true);
}
}

module load(){                                      //load shape
translate(v = [0, 0, -hollow/2]) 
cube(size = [dice_size,dice_size, load_1_percent*load_size], center = true);
}

module dule_materal_shape(){                        //shape used to split the dice
intersection() {
sphere(d = (dice_size*1.381)-(wall_thickness), $fn = dice_smooth);  
cube(size = dice_size-((wall_thickness)-.01), center = true);
}
}


module cutaway_shape(){                             //preview tool shape
intersection(){
translate([0,0,-(dice_size*1.1)/2]){
cylinder(h=dice_size*1.1, d=dice_size*1.4, $fn=120);
}
translate([0,0,-(dice_size*1.2)/2]){
cube(dice_size*1.2);  //the cutaway
}
}
}
 
/* end of shapes */} 

/* dots */{

dome_dia = dot_size*1.15;  //diamiter of the sphere that give the dots the inverted dome shape 
dome_intecect = sqrt((dome_dia/2)*(dome_dia/2)-((dot_size/2)*(dot_size/2))); //find the distance from the center of sphere were its diamiter = the dot size.

dome_depth = ((dome_dia/2)-dome_intecect);  //

module dot_dome(){
translate([0,0,dice_size/2])
translate([0,0,((dome_dia/2)-dome_depth)])
sphere(d=dome_dia,$fn=dot_smooth);
}

module dot_round(){
translate([0,0,(dice_size/2)-wall_thickness])
cylinder(h=wall_thickness-depth, d=dot_size, $fn=dot_smooth);
}

// dot_cut is a tool used for the dule_materal_cut 
module dot_cut(){
translate([0,0,(dice_size/2)-(wall_thickness+.001)])
cylinder(h=wall_thickness*1.1, d=dot_size, $fn=dot_smooth);
}

module dot_depth_cut(){
translate([0,0,(dice_size/2)-depth])
cylinder(h=depth*1.1, d=dot_size, $fn=dot_smooth);
}



/*All the dots on a dice have a postion on a 3x3 matrix (see ilerstration below). Verible x_y_pos hold the x & y value for each of these 9 postions. 

0--1--2
3--4--5
6--7--8
*/

ds = dot_spaceing;

//      Postion on 3x3 matrix
//           0          1         2         3         4         5         6         7         8      
x_y_pos =[[-ds, ds],[ 0, ds],[ ds, ds],[-ds, 0],[ 0, 0],[ ds, 0],[-ds,-ds],[ 0,-ds],[ ds,-ds]];

grouped_pos = [[4], [0,8], [0,4,8], [0,2,6,8], [0,2,4,6,8], [0,1,2,6,7,8]];     // postion of all dot for each face of the dice       

/* end of dots */}


/* Rotation values */{

//     1         2         3         4        5
side=[[180,0,0],[0,270,0],[270,0,0],[90,0,0],[0,90,0]]; //rotation values, used to put each group of dots on its own side.

//rotates all dotes to change waighted number 
//dice number: 0          1          2          3          4          5          6
x_y_rot = [[  0,  0], [180,  0], [  0, 90], [ 90,  0], [  0,270], [270,  0], [  0,  0]];
/* end of Rotation values */ }

/* characters all grouped & postioned */{
module characters_dots_domed_all(){
color(cut_color)
rotate( x_y_rot[loaded_number])
for (i =[0:5])         // rotate each group of dots to their own side
rotate(side[i])
for (a =grouped_pos[i]) // generate and postion all dots per a given face of the dice
translate(x_y_pos[a])      
dot_dome();
/* end of characters_dots_domed_all */}

module characters_dots_round_all(){
color(cut_color)
rotate( x_y_rot[loaded_number])
for (i =[0:5])         // rotate each group of dots to their own side
rotate(side[i])
for (a =grouped_pos[i]) // generate and postion all dots per a given face of the dice
translate(x_y_pos[a])      
dot_round();
/* end of characters_dots_round_all */}

module characters_text_all(){     
color(cut_color)
rotate( x_y_rot[loaded_number])
for (i =[0:5])         // rotate each group of dots to their own side
rotate(side[i]){
fo = str(txt_font[i], ": ");// combine font and style into a single string so scad can read it   
font_and_style = str(fo, bo[txt_bold[i]], it[txt_italic[i]]);  
td = text_direction[txt_direction[i]];   //td = text_direction 
rotate([0,0,txt_rotate[i]]){
translate([txt_align_h[i], txt_align_v[i],(dice_size/2)-(wall_thickness/2)]){    //tweak postion of charicters
linear_extrude(height = (wall_thickness/2)-depth){
text(                              
text        =txt_charicters[i], 
size        =txt_size[i], 
spacing     =txt_spaceing[i], 
font        =font_and_style,  
direction   =td, 
halign      ="center", 
valign      ="center", 
$fn         =txt_smothness[i]);
}
}
}
}
/* end of characters_text_all */}
/* end of characters all grouped & postioned */ }
/* cuts all grouped & postioned */{
module cuts_text_all(){
rotate( x_y_rot[loaded_number])
for (i =[0:5]){         // rotate each group of dots to their own side
rotate(side[i]){
fo = str(txt_font[i], ": ");// combine font and style into a single string so scad can read it   
font_and_style = str(fo, bo[txt_bold[i]], it[txt_italic[i]]);
td = text_direction[txt_direction[i]];   //tdd = text_direction 
rotate([0,0,txt_rotate[i]]){
translate([txt_align_h[i], txt_align_v[i],(dice_size/2)-(wall_thickness/2)]){    //tweak postion of charicters + depth
linear_extrude(height = (wall_thickness/2)*1.1){
text(
text        =txt_charicters[i], 
size        =txt_size[i], 
spacing     =txt_spaceing[i], 
font        =font_and_style,  
direction   =td, 
halign      ="center", 
valign      ="center", 
$fn         =txt_smothness[i]);
}
}
}
}
}
/* cuts_text_all */}





module cuts_round_all(){ 
rotate( x_y_rot[loaded_number])
for (i =[0:5])         // rotate each group of dots to their own side
rotate(side[i])     
for (a =grouped_pos[i]) // generate and postion all dots per a given face of the dice
translate(x_y_pos[a])
dot_cut();
/* end of cuts_round_all */}

module cuts_round_depth_all(){ 
rotate( x_y_rot[loaded_number])
for (i =[0:5])         // rotate each group of dots to their own side
rotate(side[i])     
for (a =grouped_pos[i]) // generate and postion all dots per a given face of the dice
translate(x_y_pos[a])
dot_depth_cut();
/* end of cuts_round_depth_all */}



/* end of cuts all grouped & postioned */}
module dice_body(){
color("darkseagreen")
difference(){
outside_shape();
difference(){
inside_shape();
load();
}
}
/* end of cuts_round_all */}


/* dice body and characters combined */{
module dice_text(){
if(dule_materal_cut==0){        //whole
difference(){
color("darkseagreen"){
dice_body();
}
cuts_text_all();
}
characters_text_all();
}
else
if(dule_materal_cut==1){        //outside
difference(){
color("gold"){
difference(){
dice_body();
dule_materal_shape();
}
}
cuts_text_all();
}
}
else
color("white"){                  //inside
intersection(){
dice_body();
dule_materal_shape();
}
characters_text_all();
}
/* end of dice_text */}
module dice_dots_dome(){        //whole
if(dule_materal_cut==0){         
difference(){
color("DarkSeaGreen"){
dice_body();
}
characters_dots_domed_all();
}
}
else                            //outside
if(dule_materal_cut==1){        
difference(){
color("gold"){
difference(){
dice_body();
dule_materal_shape();
}
}
cuts_round_all();
}
}
else                            //inside
color("white"){                  
difference(){
union(){
intersection(){
dice_body();
dule_materal_shape();
}
cuts_round_all();
}
characters_dots_domed_all();
}
}
/* end of dice_dots_dome*/ }






module dice_dots_round(){
if(dule_materal_cut==0){        //whole
difference(){
dice_body();
cuts_round_depth_all();
}
}
else
if(dule_materal_cut==1){        //outside
difference(){
color("gold"){
difference(){
dice_body();
dule_materal_shape();
}
}
cuts_round_all();
}
}
else
color("white"){                  //inside
intersection(){
dice_body();
dule_materal_shape();
}
characters_dots_round_all();
}
/* end of dice_dots_round */}
/* end of dice body and characters combined */}
module dice_character_type(){
if(character==0){
dice_text();
}
else
if(character==1){
dice_dots_dome();
}
else
dice_dots_round();
/* end of dice_character_type */}



/* render dice */{
//preview dice with or without cutaway
if(show_cutaway==1){                    //with cutaway
difference(){
dice_character_type();                   
cutaway_shape();
}
}
else                                    //without cutaway
dice_character_type();
/* end of render dice */}
