//cylinder height
ch=75;
//cylinder radius
cd=5;
hh=60;
$fn=35;
Namesize=4;
Name="Bongo";
Phone="906 440-6316";
Phonesize=2;
fonttype="Stencil";
module cylinder_begin(){
    union(){
        union(){
        hull()union(){
        cylinder(ch/2,cd,cd);
        translate([0,0,hh])sphere(5);}
        translate([-ch/8,0,0])rotate([0,90,0])cylinder(ch/4,cd,cd);
        }
        translate([-ch/8,0,0])sphere(5);
        translate([ch/8,0,0])sphere(5);
}}
module male_end(){
difference(){
cylinder_begin();
hull()union(){
    translate([0,0,hh*.9])rotate([0,90,0])cylinder(50,10/3,10/3,center=true);
    translate([0,0,hh*.95])rotate([0,90,0])cylinder(50,10/3,10/3,center=true);}}}
module snap_fit(){
difference(){
hull()union(){
translate([-ch/8,ch/8,0])sphere(7);
translate([-ch/8,-ch/8,0])sphere(7);
translate([ch/8,-ch/8,0])sphere(7);
translate([ch/8,ch/8,0])sphere(7);
translate([0,ch/4,0])sphere(7);
    }
hull()union(){
    translate([0,0,ch])male_end();
    male_end();}   
rotate([90,0,0])male_end();
translate([0,-5,0])rotate([90,0,0])male_end();    
translate([0,-4,0])rotate([90,0,0])male_end(); 
translate([0,-3,0])rotate([90,0,0])male_end(); 
translate([0,-2,0])rotate([90,0,0])male_end(); 
translate([0,-1,0])rotate([90,0,0])male_end(); 
translate([0,-ch/2,7-cd/2])cube([cd*1.9,ch,cd*1.5],center=true);}}
module custom_text(){
difference(){
    rotate([0,0,180])translate([0,0,6])snap_fit();
    translate(0,-2.5,0)rotate([180,0,0])linear_extrude(height=(2))text(Name,font=fonttype,size=Namesize,halign="center");   
    translate([0,2.5,0])rotate([180,0,0])linear_extrude(height=(2))text(Phone,font=fonttype,size=Phonesize,halign="center");   
}
}
difference(){
custom_text();

    hull()union(){
    translate([-20,-15,7])rotate([0,90,0])cylinder(40,10/3,10/3);
    translate([-20,-11,7])rotate([0,90,0])cylinder(40,10/3,10/3);}}