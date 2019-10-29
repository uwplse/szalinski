// This is a Bench Plate Mounting Block. The Bent Plate design
// is purely experimental. It will be difficult for most printers to
// render due to the extreme overhang.
//
// Warning -- some sanding and fitting may be required.
//
// This is licensed under the creative commons+attribution license
//
// This design was inspired by dhench's Lee Bench Plates design at
// https://www.thingiverse.com/thing:2933054
//
// To fulfill the attribution requirement, please link to:
// http://www.thingiverse.com/thing:3028704

/* [Main] */

// Number of facets (larger numbers provide better smoothing)
$fn=10;

// Define shape of object
shape=0;//[0:Block,1:Bent Plate]

// Define press type
device=0;//[0:Alignment Tabs Only,1:Classic Turret Press,2:Load-Master,3:Breech Lock Reloader Press,4:Breech Lock Challenger,5:Breech Lock Classic Cast,6:Classic Cast,7:Pro 1000,8:4 Hole Value Turret,9:2018+ Pro 1000,10:2018+ 4 Hole Value Turret,11:RCBS Rock Chucker,12:RCBS Partner,13:Brass Prep Station Mk I,14:Brass Prep Station Mk II,15:Brass Prep Station Mk III]

// Bolt hole diameter in mm
bolt_diameter=6.35;

// Bolt head diameter in mm
head_diameter=4*bolt_diameter;

// Bolt head thickness in mm
head_thickness=3.0;

// Base plate thickness in mm
thickness=18.0;

// Corner radius in mm
radius=3.0;

// Bottom base plate width in mm
bottom_width=196.85;

// Top base plate width in mm
top_width=90.0;

// Base plate length (top to bottom) in mm
length=96.425;

//rotation_angle=atan((bottom_width-top_width)/2*length)-30;

module lable(text_input)
{
    #translate([bottom_width/2-2*radius,0,0]) rotate([90,180,0]) linear_extrude(radius)
    {
        text(text_input,size=5,center=false);
    }
}

module corner(corner_height,corner_radius)
{
    hull()
    {
        translate([0,0,-(corner_height-4*corner_radius)]) sphere(r=corner_radius,center=true);
        translate([0,0,corner_radius]) sphere(r=corner_radius,center=true);
    }
}

module brace(brace_side,brace_radius)
{
    hull()
    {
        translate([0,-brace_side/2,0]) sphere(r=brace_radius,center=true);
        translate([0,brace_side/2],0)  sphere(r=brace_radius,center=true);
        translate([0,-brace_side/2,brace_side/2]) sphere(r=brace_radius,center=true);
        translate([0,brace_side/2,brace_side/2])  sphere(r=brace_radius,center=true);
        translate([brace_side/2,-brace_side/2,0]) sphere(r=brace_radius,center=true);
        translate([brace_side/2,brace_side/2],0)  sphere(r=brace_radius,center=true);
        
    }
}

module base()
{
    if(shape==0)
    {
        hull()
        {
            translate([-(bottom_width/2-radius),0,0])   corner(thickness,radius);
            translate([(bottom_width/2-radius),0,0])  corner(thickness,radius);
            translate([-(top_width/2-radius),(length-radius),0])  corner(thickness,radius);
            translate([(top_width/2-radius),(length-radius),0]) corner(thickness,radius);
        }
        // Add alignment tabs
        translate([-19,82,thickness/2-(bolt_diameter/2+1)])  sphere(r=bolt_diameter/2,center=true);
        translate([11.5,82,thickness/2-(bolt_diameter/2+1)]) sphere(r=bolt_diameter/2,center=true);
    }
    if(shape==1)
    {   
        union()
        {
            hull()
            {
                translate([-(bottom_width/2-radius),0,0])   corner(thickness,radius);
                translate([-(top_width/2-radius),(length-radius),0])  corner(thickness,radius);
            }
            hull()
            {
                translate([(bottom_width/2-radius),0,0])  corner(thickness,radius);
                translate([(top_width/2-radius),(length-radius),0]) corner(thickness,radius);
            }
            hull()
            {
                translate([-(bottom_width/2-radius),0,-head_thickness/2]) corner(radius,radius/2);
                translate([(bottom_width/2-radius),0,-head_thickness/2])  corner(radius,radius/2);
                translate([-(top_width/2-radius),(length-radius),-head_thickness/2]) corner(radius,radius/2);
                translate([(top_width/2-radius),(length-radius-radius),-head_thickness/2])  corner(radius,radius/2);
            }
            // Render braces
            translate([(bottom_width-top_width)/sqrt(3)-6,2*length/3,-radius/2]) rotate([0,90,211]) brace(5,radius);
            translate([-((bottom_width-top_width)/sqrt(3)-6),2*length/3,-radius/2]) rotate([0,90,-29]) brace(5,radius);
            translate([(4*(bottom_width-top_width)/sqrt(3)/3-8),length/3,-radius/2]) rotate([0,90,211]) brace(5,radius);
            translate([-(4*(bottom_width-top_width)/sqrt(3)/3-8),length/3,-radius/2]) rotate([0,90,-29]) brace(5,radius);
        }
    }
}

module ctp()
{
    union()
    {
        translate([-47.0,14.0,0]) cube([bolt_diameter+0.5,bolt_diameter+0.5,thickness+radius],center=true);
        translate([71.0,14.0,0])  cube([bolt_diameter+0.5,bolt_diameter+0.5,thickness+radius],center=true);
        translate([11.5,82,0])    cube([bolt_diameter+0.5,bolt_diameter+0.5,thickness+radius],center=true);
        if(shape==0)
        {
            lable("Lee Classic Turret Press");
            // Countersink carriage bolts
            translate([-47.0,14.0,head_thickness]) cylinder(r=head_diameter/2,h=head_thickness,center=false);
            translate([71.0,14.0,head_thickness])  cylinder(r=head_diameter/2,h=head_thickness,center=false);
            translate([11.5,82.0,head_thickness])  cylinder(r=head_diameter/2,h=head_thickness,center=false);
        }
    }
}

module lm()
{
    union()
    {
        translate([-70.0,10.0,0]) cube([bolt_diameter+0.5,bolt_diameter+0.5,thickness+radius],center=true);
        translate([32.0,10.0,0])  cube([bolt_diameter+0.5,bolt_diameter+0.5,thickness+radius],center=true);
        translate([-19.0,82.0,0]) cube([bolt_diameter+0.5,bolt_diameter+0.5,thickness+radius],center=true);
        if(shape==0)
        {
            lable("Lee Load-Master");
            // Countersink carriage bolts
            translate([-70.0,10.0,head_thickness]) cylinder(r=head_diameter/2,h=head_thickness,center=false);
            translate([32.0,10.0,head_thickness])  cylinder(r=head_diameter/2,h=head_thickness,center=false);
            translate([-19.0,82.0,head_thickness]) cylinder(r=head_diameter/2,h=head_thickness,center=false);   
        }
    }
}

module rp()
{
    union()
    {
        translate([-19.0,10.0,0]) cube([bolt_diameter+0.5,bolt_diameter+0.5,thickness+radius],center=true);
        translate([19.0,10.0,0])  cube([bolt_diameter+0.5,bolt_diameter+0.5,thickness+radius],center=true);
        translate([0.0,72.0,0])   cube([bolt_diameter+0.5,bolt_diameter+0.5,thickness+radius],center=true);
        if(shape==0)
        {
            lable("Lee Breech Lock Reloader Press");
            // Countersink carriage bolts
            translate([-19.0,10.0,head_thickness]) cylinder(r=head_diameter/2+0.5,h=head_thickness,center=false);
            translate([19.0,10.0,head_thickness])  cylinder(r=head_diameter/2+0.5,h=head_thickness,center=false);
            translate([0.0,72.0,head_thickness])   cylinder(r=head_diameter/2+0.5,h=head_thickness,center=false);
        }
    }
}

module blc()
{
    union()
    {
        translate([-37.0,37.0,0]) cube([bolt_diameter+0.5,bolt_diameter+0.5,thickness+radius],center=true);
        translate([8.0,13.0,0])   cube([bolt_diameter+0.5,bolt_diameter+0.5,thickness+radius],center=true);
        translate([-15.0,67.0,0]) cube([bolt_diameter+0.5,bolt_diameter+0.5,thickness+radius],center=true);
        if(shape==0)
        {
            lable("Lee Breech Lock Challenger Press");
            // Countersink carriage bolts
            translate([-37.0,37.0,head_thickness]) cylinder(r=head_diameter/2,h=head_thickness,center=false);
            translate([8.0,13.0,head_thickness])   cylinder(r=head_diameter/2,h=head_thickness,center=false);
            translate([-15.0,67.0,head_thickness]) cylinder(r=head_diameter/2,h=head_thickness,center=false);
        }
    }
}

module blcc()
{
    union()
    {
        translate([-53.0,39.5,0]) cube([bolt_diameter+0.5,bolt_diameter+0.5,thickness+radius],center=true);
        translate([32.0,10.0,0])  cube([bolt_diameter+0.5,bolt_diameter+0.5,thickness+radius],center=true);
        translate([-19.0,82.0,0]) cube([bolt_diameter+0.5,bolt_diameter+0.5,thickness+radius],center=true);
        if(shape==0)
        {
            lable("Lee Breech Lock Classic Cast");
            // Countersink carriage bolts
            translate([-53.0,39.5,head_thickness]) cylinder(r=head_diameter/2,h=head_thickness,center=false);
            translate([32.0,10.0,head_thickness])  cylinder(r=head_diameter/2,h=head_thickness,center=false);
            translate([-19.0,82.0,head_thickness]) cylinder(r=head_diameter/2,h=head_thickness,center=false);   
        }
    }
}

module cc()
{
    union()
    {
        translate([-70.0,10.0,0]) cube([bolt_diameter+0.5,bolt_diameter+0.5,thickness+radius],center=true);
        translate([32.0,10.0,0])  cube([bolt_diameter+0.5,bolt_diameter+0.5,thickness+radius],center=true);
        translate([-19.0,82.0,0]) cube([bolt_diameter+0.5,bolt_diameter+0.5,thickness+radius],center=true);
        if(shape==0)
        {
            lable("Lee Classic Cast");
            // Countersink carriage bolts
            translate([-70.0,10.0,head_thickness]) cylinder(r=head_diameter/2,h=head_thickness,center=false);
            translate([32.0,10.0,head_thickness])  cylinder(r=head_diameter/2,h=head_thickness,center=false);
            translate([-19.0,82.0,head_thickness]) cylinder(r=head_diameter/2,h=head_thickness,center=false);
        }
    }
}

module pro()
{
    union()
    {
        translate([-70.0,10.0,0]) cube([bolt_diameter+0.5,bolt_diameter+0.5,thickness+radius],center=true);
        translate([32.0,10.0,0])  cube([bolt_diameter+0.5,bolt_diameter+0.5,thickness+radius],center=true);
        translate([-19.0,82.0,0]) cube([bolt_diameter+0.5,bolt_diameter+0.5,thickness+radius],center=true);
        if(shape==0)
        {
            lable("Lee Pro 1000");
            // Countersink carriage bolts
            translate([-70.0,10.0,head_thickness]) cylinder(r=head_diameter/2,h=head_thickness,center=false);
            translate([32.0,10.0,head_thickness])  cylinder(r=head_diameter/2,h=head_thickness,center=false);
            translate([-19.0,82.0,head_thickness]) cylinder(r=head_diameter/2,h=head_thickness,center=false);
        }
    }
}

module vtp()
{
    union()
    {
        translate([-70.0,10.0,0]) cube([bolt_diameter+0.5,bolt_diameter+0.5,thickness+radius],center=true);
        translate([32.0,10.0,0])  cube([bolt_diameter+0.5,bolt_diameter+0.5,thickness+radius],center=true);
        translate([-19.0,82.0,0]) cube([bolt_diameter+0.5,bolt_diameter+0.5,thickness+radius],center=true);
        if(shape==0)
        {
            lable("Lee Value Turret Press");
            // Countersink carriage bolts
            translate([-70.0,10.0,head_thickness]) cylinder(r=head_diameter/2,h=head_thickness,center=false);
            translate([32.0,10.0,head_thickness])  cylinder(r=head_diameter/2,h=head_thickness,center=false);
            translate([-19.0,82.0,head_thickness]) cylinder(r=head_diameter/2,h=head_thickness,center=false);
        }
    }
}

module lee18vtp()
{
    union()
    {
        translate([-59.0,14.0,0]) cube([bolt_diameter+0.5,bolt_diameter+0.5,thickness+radius],center=true);
        translate([32.0,10.0,0])  cube([bolt_diameter+0.5,bolt_diameter+0.5,thickness+radius],center=true);
        translate([-15.0,67.0,0]) cube([bolt_diameter+0.5,bolt_diameter+0.5,thickness+radius],center=true);
        if(shape==0)
        {
            lable("2018+ Lee Value Turret Press");
            // Countersink carriage bolts
            translate([-59.0,14.0,head_thickness]) cylinder(r=head_diameter/2,h=head_thickness,center=false);
            translate([32.0,10.0,head_thickness])  cylinder(r=head_diameter/2,h=head_thickness,center=false);
            translate([-15.0,67.0,head_thickness]) cylinder(r=head_diameter/2,h=head_thickness,center=false);
         }
    }
}


module rc()
{
    union()
    {
        translate([-34.0,42.0,0]) cube([bolt_diameter+0.5,bolt_diameter+0.5,thickness+radius],center=true);
        translate([34.0,42.0,0])  cube([bolt_diameter+0.5,bolt_diameter+0.5,thickness+radius],center=true);
        if(shape==0)
        {
            lable("RCBS Rock Chucker");
            // Countersink carriage bolts
            translate([-34.0,42.0,head_thickness]) cylinder(r=head_diameter/2,h=head_thickness,center=false);
            translate([34.0,42.0,head_thickness])  cylinder(r=head_diameter/2,h=head_thickness,center=false);
        }
    }
}

module partner()
{
    union()
    {
        translate([-21.0,19.0,0]) cube([bolt_diameter+0.5,bolt_diameter+0.5,thickness+radius],center=true);
        translate([21.0,19.0,0])  cube([bolt_diameter+0.5,bolt_diameter+0.5,thickness+radius],center=true);
        translate([0.0,65.0,0]) cube([bolt_diameter+0.5,bolt_diameter+0.5,thickness+radius],center=true);
        if(shape==0)
        {
            lable("RCBS Partner");
            // Countersink carriage bolts
            translate([-21.0,19.0,head_thickness]) cylinder(r=head_diameter/2,h=head_thickness,center=false);
            translate([21.0,19.0,head_thickness])  cylinder(r=head_diameter/2,h=head_thickness,center=false);
            translate([0.0,65.0,head_thickness]) cylinder(r=head_diameter/2,h=head_thickness,center=false);
        }
    }
}

module brassprep_a()
{
    union()
    {
        #translate([0,65.0,0]) cylinder($fn=50,r=6.35,h=thickness+radius,center=true);
        #translate([-20,40.0,0]) cylinder($fn=50,r=7.2,h=thickness+radius,center=true);
        #translate([-20,40.0,-0.75*thickness]) cylinder($fn=50,r=8.86,h=thickness+radius,center=true);
        #translate([20,40.0,0]) cylinder($fn=50,r=7.2,h=thickness+radius,center=true);
        #translate([20,40.0,-0.75*thickness]) cylinder($fn=50,r=8.86,h=thickness+radius,center=true);
        #translate([0,15.0,-thickness]) cylinder($fn=6,r=3.65,h=thickness+radius,center=false);
        #translate([20,15.0,-thickness]) cylinder($fn=6,r=3.65,h=thickness+radius,center=false);
        #translate([-20,15.0,-thickness]) cylinder($fn=6,r=3.65,h=thickness+radius,center=false);
        #translate([40,15.0,-thickness]) cylinder($fn=6,r=3.65,h=thickness+radius,center=false);
        #translate([-40,15.0,-thickness]) cylinder($fn=6,r=3.65,h=thickness+radius,center=false);
        #translate([60,15.0,-thickness]) cylinder($fn=6,r=3.65,h=thickness+radius,center=false);
        #translate([-60,15.0,-thickness]) cylinder($fn=6,r=3.65,h=thickness+radius,center=false);
        if(shape==0)
        {
            lable("Brass Prep Station MK I");
        }
    }
}
module brassprep_b()
{
    union()
    {
        #translate([0,65.0,0]) cylinder($fn=50,r=6.35,h=thickness+radius+1,center=true);
        #translate([-20,40.0,0]) cylinder($fn=6,r=3.65,h=thickness+radius+1,center=true);
        #translate([20,40.0,0]) cylinder($fn=6,r=3.65,h=thickness+radius+1,center=true);
        
        #translate([0,15.0,-thickness]) cylinder($fn=6,r=3.65,h=thickness+radius+1,center=false);
        #translate([20,15.0,-thickness]) cylinder($fn=6,r=3.65,h=thickness+radius+1,center=false);
        #translate([-20,15.0,-thickness]) cylinder($fn=6,r=3.65,h=thickness+radius+1,center=false);
        #translate([40,15.0,-thickness]) cylinder($fn=6,r=3.65,h=thickness+radius+1,center=false);
        #translate([-40,15.0,-thickness]) cylinder($fn=6,r=3.65,h=thickness+radius+1,center=false);
        #translate([60,15.0,-thickness]) cylinder($fn=6,r=3.65,h=thickness+radius+1,center=false);
        #translate([-60,15.0,-thickness]) cylinder($fn=6,r=3.65,h=thickness+radius+1,center=false);
        if(shape==0)
        {
            lable("Brass Prep Station Mk II");
        }
    }
}

module brassprep_c()
{
    union()
    {
        #translate([0,65.0,0]) cylinder($fn=6,r=3.65,h=thickness+radius+1,center=true);
        #translate([-20,40.0,0]) cylinder($fn=6,r=3.65,h=thickness+radius+1,center=true);
        #translate([20,40.0,0]) cylinder($fn=6,r=3.65,h=thickness+radius+1,center=true);
        
        #translate([0,15.0,-thickness]) cylinder($fn=6,r=3.65,h=thickness+radius+1,center=false);
        #translate([20,15.0,-thickness]) cylinder($fn=6,r=3.65,h=thickness+radius+1,center=false);
        #translate([-20,15.0,-thickness]) cylinder($fn=6,r=3.65,h=thickness+radius+1,center=false);
        #translate([40,15.0,-thickness]) cylinder($fn=6,r=3.65,h=thickness+radius+1,center=false);
        #translate([-40,15.0,-thickness]) cylinder($fn=6,r=3.65,h=thickness+radius+1,center=false);
        #translate([60,15.0,-thickness]) cylinder($fn=6,r=3.65,h=thickness+radius+1,center=false);
        #translate([-60,15.0,-thickness]) cylinder($fn=6,r=3.65,h=thickness+radius+1,center=false);
        if(shape==0)
        {
            lable("Brass Prep Station Mk III");
        }
    }
}
//%translate([0,length/2,-thickness]) import_stl("./LeePlateComp.stl");

difference() // drill holes using correct pattern for each device
{
    base();
    if(device==1){ ctp(); }
    if(device==2){ lm(); }
    if(device==3){ rp(); }
    if(device==4){ blc(); }
    if(device==5){ blcc(); }
    if(device==6){ cc(); }
    if(device==7){ pro(); }
    if(device==8){ vtp(); }
    if(device==9){ lee18pro(); }
    if(device==10){ lee18vtp(); }
    if(device==11){ rc(); }
    if(device==12){ partner(); }
    if(device==13){ brassprep_a(); }
    if(device==14){ brassprep_b(); }
    if(device==15){ brassprep_c(); }
}
