/* [Parameters] */

//How many Holders?
count = 3;
//Sphere-Radius
rad1 =20;
//Width bottom
w1 = 7;
//Width middle
w2 = 15;
//Width top
w3 = 5;
//Height Middle
h1 = 13;
//Height Bottom
h2 = 5;
//Innerdiameter Drillhole
drilldia = 3;
//Stepdiameter Drillhole
drilldia2 = 5;
//Stepdepth
drilldepth = 1;
//Distance between holders in %
shift= 1.5;
//With drillings? (first and Last one)
drillings = "Yes";  //[Yes: With drillings ,No: Without drillings]

/* [Renderoptions] */
//Renderdetail; Do not exceed 80 with Full render; Thinigiverse Customizer possibly won't work >30 and Full Render
detail = 80; 
//Ready to Render? Full Render will take time and ressources!
Render = "Preview";    //[Full: Render with rounded edges ,Preview: Render without rounded edges]

/* [Hidden] */
//Fix_Parameters
hb = rad1/2;
r = 1.5;
Start = 0;
End = count-1; 

//Render
$fn = detail;

if (Render == "Full")
    rounded_multiple_holder();
else
   multiple_holder();



//modules

module multiple_holder(){
if (count==2) 
 for (i=[1,2])
    translate([i*rad1*shift-rad1*1.5,0,0])    
        difference(){
        holder();
        if (drillings == "Yes") drilling(i);}
        
if (count>2){
for (i=[Start+1:End-1])
   translate([i*rad1*shift,0,0])
     holder(i+1);

for (i=[0,End])
    translate([i*rad1*shift,0,0])    
        difference(){
        holder();
        if (drillings == "Yes") drilling(i);}
    }
    
}
module rounded_multiple_holder(){
if (count==2) 
 for (i=[1,2])
    translate([i*rad1*shift,0,0])    
        difference(){
        rounded_holder();
        if (drillings == "Yes") drilling(i);}
        
if (count>2){
for (i=[Start+1:End-1])
   translate([i*rad1*shift,0,0])
     rounded_holder(i+1);

for (i=[0,End])
    translate([i*rad1*shift,0,0])    
        difference(){
        rounded_holder();
        if (drillings == "Yes") drilling(i);}
    }
}

module rounded_holder(){
    
    translate([0,0,r])
        minkowski(){
            holder();
                sphere(r);}
            }
                

module holder(){
    difference(){
    difference(){
    //color("green")
        translate([0,0,rad1/2])
            sphere(rad1);
    color("blue")
        translate([0,0,-hb/2])
            cube([rad1*2,rad1*2,hb],center= true);}
cutout();
//drilling();
            }}

module cutout(){
    mirror(0,1,0){
    translate([0,rad1,0])
        rotate([90,-90,0])
            linear_extrude(height = rad1*2) 
                polygon(points=[[h2,w1/2],[h1,w2/2],[rad1*1.5,w3/2],[rad1*1.5,0],[h2,0],[h2,w1/2]]);}
    translate([0,rad1,0])
        rotate([90,-90,0])
            linear_extrude(height = rad1*2) 
                polygon(points=[[h2,w1/2],[h1,w2/2],[rad1*1.5,w3/2],[rad1*1.5,-0.1],[h2,-0.1],[h2,w1/2]]);}

module drilling(){
    translate([0,0,-0.1])
    cylinder(h=h2+0.2, r=drilldia/2, center=false);
    color("blue")
    translate([0,0,h2-drilldepth])
    cylinder(h=drilldepth+r*2, r=drilldia2/2, center=false);
}