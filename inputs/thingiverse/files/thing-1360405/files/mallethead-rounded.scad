//mallet head
height=60; //complete length of mallet head
fillet=3; //roundover radius, 0 for none
topradius=10; //radius at top end
bottomradius=10; //radius at bottom end

//handle hole
cutdepth=10; //depth of cut into head for handle
cuttoprad=6; //entry hole for handle
cutbotrad=6; //exit hole for handle in head

smooth=60; //resolution

//Calculations
adjheight=height-fillet;
adjtopradius=topradius-fillet;
adjbotradius=bottomradius-fillet;


difference(){
translate([0,(0),(-.5*height)]) 
    minkowski(){
        cylinder(adjheight,adjtopradius,adjbotradius,$fn=smooth);
        sphere(fillet,$fn=smooth);
        }
rotate([-90,0,0]) translate([0,0,-(topradius)]) cylinder(cutdepth,cuttoprad,cutbotrad,$fn=smooth);
}