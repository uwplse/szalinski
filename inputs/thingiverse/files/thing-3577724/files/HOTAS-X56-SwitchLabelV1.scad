/* [General] */
// (Default = 1)
ground_plate_thickness=1;//[0.1:0.1:5]
// (Default = 2)
corner_radius = 1;//[0:0.5:10]
// (Default = 20)
switch_hole_diameter = 20;//[10:20]




/* [Switch Texts] */
//Make sure to not use too many characters.
// (Default = 0.5)
text_thickness = 0.5;//[0.1:0.1:2]

switch_text_1 = "Galaxy";
switch_text_2 = "Sector";
switch_text_3 = "Freight";
switch_text_4 = "L-Gear";
switch_text_5 = "Cruise";
switch_text_6 = "Jump";

/* [Advanced/Expert] */
print_grountplate="yes"; //[yes,no]
print_text="yes"; //[yes,no]
//Increase for wider tolerances.
tolerance_adjustment=0.1; //[-1:0.1:+1]
//Auto = 0 , see openscad $fn setting.
radial_resolution=0;//[0:10:100]


/* [Hidden] */
font = "Liberation Sans:style=Bold";
bglWidth=22.5+9.5;//Abstand zweier BügelZentren!
bglDm = 9.5+tolerance_adjustment;
bglLuecke = bglWidth- bglDm;//Platz zwischen zwei Bügeln

x = 105.5 - bglDm;
y = 47;
z =ground_plate_thickness;
bglY = 39.5+tolerance_adjustment;

swR=switch_hole_diameter/2;
rnd=3.5;

$fn = radial_resolution;

eckR = corner_radius == 0 ? 0.1 : corner_radius;


//Grundplatte
if(print_grountplate=="yes"){
linear_extrude(z){
copy_mirror()
copy_mirror(1){
    difference(){
hull(){
//Platte
    square();
    translate([x/2-1,0,0])
    square();
    translate([0,y/2-1,0])
    square();
    translate([x/2-eckR, y/2-eckR,0])
    circle(eckR);
    }

//Bugel Aussparungen
//color("blue")
translate([bglWidth/2,0,0]){
    bgl();
    
    translate([bglWidth,0,0])
    bgl();}


//Switch Locher
circle(swR);
translate([bglWidth,0,0])
circle(swR);
}}}}



//Texts
if(print_text=="yes"){
    
    sw = [
//  [   X   ,      Y        ,   TEXT  ]
    [-bglWidth  , bglY/2-rnd  , switch_text_1 ],
    [-bglWidth  , -bglY/2+rnd , switch_text_2 ],
    [0      , bglY/2-rnd  , switch_text_3 ],
    [0      ,-bglY/2+rnd  ,switch_text_4 ],
    [bglWidth   , bglY/2-rnd  , switch_text_5 ],
    [bglWidth   ,-bglY/2+rnd  ,switch_text_6 ]
];
    
    
color("blue")
translate([0,0,z])
    linear_extrude(text_thickness){
for(a = sw){
    translate([a[0],a[1],z])
    swTxt(mtext=a[2]);
    }}}






module bgl(){
    translate([-bglDm/2,0,0])
    square([bglDm,bglY/2-bglDm/2]);
    translate([0,bglY/2-bglDm/2,0])
    circle(d=bglDm);
    
    
    }
    
    module copy_mirror(vec=[0,1,0])
{
    //Dubliziert und Spiegelt ein Objekt
    children();
    mirror(vec) children();
}


module swTxt(mtext="None", mfont = font){
    
    //Erstellt und skalliert Text
    
        resize([bglLuecke-2,0,0], auto=true)
        text(
            text = mtext,
            font = mfont,
            size = 10,
            valign = "center",
            halign = "center"
        ); 
}
