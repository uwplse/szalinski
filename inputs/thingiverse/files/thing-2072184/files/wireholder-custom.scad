////////////////////////////////////////VARIABLES///////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////

Plate_width = 20; //[10:30]
Tie_pos = 2; //[1:0.5:3]
Holder_height = 20; //[18:30]
Holder_blk = 4; //[3.5:0.5:6] 
Tie_thickness = 2; //[1:0.5:3] 
Tie_width = 6; // [3:0.5:6] 
Holder_type = "flat"; // [flat,curve] 
Center_hole = "yes"; // [yes,no]

/* [Hidden] */
holedia = 3 ; // center hole

//////////////////////////////////////////RENDER////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////

if (Holder_type == "curve")
{curvedholder();}
else if (Holder_type == "flat")
{flatholder();}

//////////////////////////////////////////MODULES///////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////

module flatholder()
{
    difference()
    {
        union()
        {
        translate([-Holder_blk-(Holder_blk/2),0,0])straight();
        difference()
        {
            hull()
            {
                translate([0,-((Plate_width/2)-(Holder_blk/2)),0])cylinder(h=Holder_height,d=Holder_blk,center=true,$fn=50);
                translate([0,((Plate_width/2)-(Holder_blk/2)),0])cylinder(h=Holder_height,d=Holder_blk,center=true,$fn=50);
            }
            translate([Holder_blk/2,0,0])cube([Holder_blk,Plate_width+Holder_blk,Holder_height+1],center=true);
        }
        }
        translate([Plate_width/2,0,0]) holes();
    }
}

module curvedholder()
{
    difference()
    {
        union()
        {
            curve();
            translate ([-((Plate_width/2)+(Tie_pos/2)+(Holder_blk)),0,0]) straight();
        }
        holes();
    }
}

module holes()
{
translate([-((Plate_width/2)+Tie_pos+(Holder_blk/2)),0,Holder_height/4]) cube([Tie_thickness,Holder_blk*2,Tie_width],center=true);
translate([-((Plate_width/2)+Tie_pos+(Holder_blk/2)),0,-Holder_height/4]) cube([Tie_thickness,Holder_blk*2,Tie_width],center=true);
if (Center_hole == "yes") {translate([-((Plate_width/2)+(Tie_pos/2)+(Holder_blk/2)),0,0]) rotate([0,90,0]) cylinder(h=Holder_blk*3, d=holedia,center=true,$fn=50);}
}
module straight()
{
    hull()
    {
    translate([0,0,((Holder_height/2)-(Holder_blk/2))]) rotate([90,0,0]) cylinder(h=Holder_blk,d=Holder_blk,center=true,$fn=50);
    translate([0,0,-((Holder_height/2)-(Holder_blk/2))]) rotate([90,0,0]) cylinder(h=Holder_blk,d=Holder_blk,center=true,$fn=50);
    }

    translate([Holder_blk/2,0,0])cube([Holder_blk,Holder_blk,Holder_height],center=true);
}

module curve()
{
    difference()
    {
        union()
        {
            cylinder(h=Holder_height,d=Plate_width+(Tie_pos*2),center=true,$fn=150);
            
        }
        union()
        {
            cylinder(h=Holder_height+1,d=Plate_width,center=true,$fn=150);
            translate([15,0,0]) cube([30,40,26],center=true);
        }
    }
    
    translate([0,-(Plate_width/2+(Tie_pos/2)),0])cylinder(h=Holder_height,d=Tie_pos,center=true,$fn=50);
            translate([0,(Plate_width/2+(Tie_pos/2)),0])cylinder(h=Holder_height,d=Tie_pos,center=true,$fn=50);
    
}