/* [Global] */
holdertype = "corner"; // [corner,side]

//The thickness of the glass
glass_thickness = 2.2;

//The width of the clamp
width = 30; 

//The size of the skrew
mountingholde = 5; 

// Nutsize of the glassplate thightner
nutsize = 6.6; 

//The size of the bolt
bolt_size = 3.6; 

//Wallthickess at the side of the glass
wallthickness = 2; 

/* [side holder] */
//Depth into the glassplate (Only for side holdertype)
dept = 15; 

/* [Hidden] */
totalthickness = glass_thickness + (2*wallthickness) < nutsize + (2*wallthickness) ? nutsize + (2*wallthickness) : glass_thickness + wallthickness;
actual_wallthickness = (totalthickness - glass_thickness) / 2;

module corner()
{
    rotate([0,-90,0])
    difference()
    {
        hull()
        {
            translate([width-1,1,0])
            cylinder(r=1,h=totalthickness,$fn=40);

            translate([1,1,0])
            cylinder(r=1,h=totalthickness,$fn=40);

            translate([1,width-1,0])
            cylinder(r=1,h=totalthickness,$fn=40);
        }
        
        translate([2+mountingholde,2+mountingholde,actual_wallthickness])
        cube([width,width,glass_thickness]);
        
        translate([2+mountingholde/2,2+mountingholde/2,-1])
        cylinder(r=mountingholde/2,h=20,$fn=30);

        translate([width-(2+mountingholde/2),width + 1,(totalthickness)/2])
        rotate([90,0,0])
        cylinder(r=nutsize/2,h=width,$fn=6);

        translate([width-(2+mountingholde/2),width/2,(totalthickness)/2])
        rotate([90,0,0])
        cylinder(r=bolt_size/2,h=width,$fn=28);


        mirror([1,0,0])
        rotate([0,0,90])
        {
            translate([width-(2+mountingholde/2),width + 1,(totalthickness)/2])
            rotate([90,0,0])
            cylinder(r=nutsize/2,h=width,$fn=6);

            translate([width-(2+mountingholde/2),width/2,(totalthickness)/2])
            rotate([90,0,0])
            cylinder(r=bolt_size/2,h=width,$fn=28);
        }
    }
}

module side()
{
    rotate([90,0,0])
    difference()
    {
        hull()
        {
            translate([width-1,1,0])
            cylinder(r=1,h=totalthickness,$fn=40);

            translate([width-1,dept-1,0])
            cylinder(r=1,h=totalthickness,$fn=40);

            translate([1,1,0])
            cylinder(r=1,h=totalthickness,$fn=40);

            translate([1,dept-1,0])
            cylinder(r=1,h=totalthickness,$fn=40);
        }
        
        translate([-0.1,2+mountingholde,actual_wallthickness])
        cube([width+1,width,glass_thickness]);
        
        translate([width/2,2+mountingholde/2,-1])
        cylinder(r=mountingholde/2,h=20,$fn=30);

        {
            translate([width-(2+mountingholde/2),width + 1,(totalthickness)/2])
            rotate([90,0,0])
            cylinder(r=nutsize/2,h=width,$fn=6);

            translate([width-(2+mountingholde/2),width/2,(totalthickness)/2])
            rotate([90,0,0])
            cylinder(r=bolt_size/2,h=width,$fn=28);
        }

        {
            translate([(2+mountingholde/2),width + 1,(totalthickness)/2])
            rotate([90,0,0])
            cylinder(r=nutsize/2,h=width,$fn=6);

            translate([(2+mountingholde/2),width/2,(totalthickness)/2])
            rotate([90,0,0])
            cylinder(r=bolt_size/2,h=width,$fn=28);
        }
    }
}

if(holdertype == "side")
{
    side();
}

if(holdertype == "corner")
{
    corner();
}