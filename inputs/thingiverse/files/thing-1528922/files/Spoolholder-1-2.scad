// My first OpenSCAD experiment
// 
// Enable/Disable Arm
arm = "true";    // [true:Enabled,false:Disabled]
// Enable/Disable roll
roll = "";   // [true:Enabled,false:Disabled]
// Enable/Disable spacer
spacer = ""; // [true:Enabled,false:Disabled]


// Height of the standing backpart of the arm
height_backlatch = 65;
// Height of the arm at the backside. Consider spindle diameter. 40mm is a sane value. Backlatch height is not automaticly adjusted.
height_arm = 30; // [200]
// Angle of the lower part of the arm. Set to zero for a straight arm and adjust height with "Height arm".
arm_angle = 9; // [45]
// Distance between the hooks the arm hangs on
distance_hooks = 50; // [200]
// diameter of the holder for the spool. Should be slightly less than the hole in the spool.
diameter_roll = 50; // [100]
// Width of spoolhole. Include a couple of mm margin yourself.
width_roll = 55; // [100]

// Arm thickness. Sturdiness is given by the top part so the default of 1.8 should be enough. Make sure you match the layerheight of the print otherwise you will get tolerance issues.
thickness = 1.8;
// Margin for fitting of parts. Depending on the accuracy of your printer 0.2 or 0.4 are good values.
tolerance=0.2;
// Height of the spoolguider.
spoolcarrier = 10; // [1:100]

//Maximum height of the spacer.
spacermax=4; // [10]
//Height at low end of the spacer.
spacermin=2; // [10]

/* [Hidden] */
cutoff_backlatch = 6;
lengte_arm = 2*width_roll+3*10;
uitsnede_spoolcarrier = -(diameter_roll/2)+spoolcarrier; //0 is 25mm, -25 is 0mm
echo(uitsnede_spoolcarrier=uitsnede_spoolcarrier);
show=true;
//roldraaiing=[-90,-90,0];
roldraaiing=[-90,0,0];
//rolplaatsing = [25,-10,(thickness)/2];
rolplaatsing = [height_backlatch+(diameter_roll/2)+5,0,uitsnede_spoolcarrier];
$fa=0.1;


module haakje(diepte_haakjes = 10,thickness=thickness){
difference(){
color("green"){
    union(){
        translate([0,-diepte_haakjes,0]){
            cube([10,diepte_haakjes*2,thickness]); //staander
        }
// Half boogje
        cylinder(r=diepte_haakjes,h=thickness);
    }}


color("red"){
     translate([-2,-3,-1])
    {
hull(){
    cube([10,3,thickness+2]);
    translate([8,-1,0]){
        cube([8+1,4,thickness+2]);
        }
   }
}}}
} //einde module haakje

module stopper(verhoging=2,thickness=thickness){
    //translate([-12,0,0]){
    union(){intersection(){    cube([10,10,thickness]);
    translate([10,10,0]){
cylinder(r=10,h=thickness);
    }
    
} translate([10,0,0])
cube([2,10,thickness]);
//}
}}

module stoppergat(thickness=thickness){
    translate([0,0,-tolerance])
    cube([thickness+tolerance,(diameter_roll/2)+2,10+2*tolerance]);
}



// Arm
if ( arm == "true") {
union(){
translate([2,0,0])
difference(){
cube([height_arm,lengte_arm+(10-cutoff_backlatch),thickness]); // armvlak

translate([height_arm,0,-1]){
rotate(arm_angle)
cube([2*height_arm,lengte_arm+50,thickness+2]); // schuine uitsnede
}
}

translate([0,-cutoff_backlatch,0])
difference(){
color("blue"){
    translate([0,0,0]){
        cube([height_backlatch,10,thickness]); //staander
    }
    translate([0,0,0])
    haakje();

    translate([distance_hooks,0,0])
    haakje();
    }
        translate([height_arm,+cutoff_backlatch,-1]){
        cube([height_backlatch-2,12,thickness+2]); //cutout voor staander en onderste haakje
    }
}



translate([-10,width_roll+(10-cutoff_backlatch),0])
//scale([1,-1,1])
stopper();


translate([-10,width_roll+20+(10-cutoff_backlatch),0])
scale([1,-1,1])
stopper();


translate([-10,2*width_roll+20+(10-cutoff_backlatch),0])
//scale([1,-1,1])
stopper();
}
}

//
// Top Cylinder
//
if ( roll == "true") {

translate(rolplaatsing) // lelijke translate van 0,95 omdat cirkel centered is op z as. is thickness- (tolerance/2)
rotate(roldraaiing){
    difference(){
        translate([0,0,2])
        cylinder( r=diameter_roll/2, h=lengte_arm+6);
        {translate([-(diameter_roll/2)-1,uitsnede_spoolcarrier,-1]){
           cube([diameter_roll+2,(diameter_roll)+2,lengte_arm+10+2]);
        }
    translate([-(thickness+tolerance)/2,-(diameter_roll/2)+2,-1]){
        cube([thickness+tolerance,diameter_roll,lengte_arm+2]);}
   
    translate([-(thickness+tolerance)/2,-(diameter_roll/2)-2,0])
        stoppergat();
    translate([-(thickness+tolerance)/2,-(diameter_roll/2)-2,width_roll+10])
        stoppergat();
    translate([-(thickness+tolerance)/2,-(diameter_roll/2)-2,width_roll+20])
        stoppergat();
    translate([-(thickness+tolerance)/2,-(diameter_roll/2)-2,2*width_roll+30])
        stoppergat();
    }
    }}
}
//
// Spacer
//

if ( spacer == "true") {

translate([height_backlatch+diameter_roll+50,0,0]){
   rotate([0,0,90])
difference(){
    hull(){
cube([10,20+thickness+2*tolerance,spacermax]);
cube([height_backlatch,20+thickness+2*tolerance,spacermin]);
}
translate([6,(10),-1])
{
cube([height_backlatch+2,thickness+2*tolerance,10]);
}}}
  echo("Spacer enabled");}