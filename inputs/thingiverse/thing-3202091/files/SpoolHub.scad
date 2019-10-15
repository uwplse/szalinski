// Customizable hub for spool holder
// Vincent Groenhuis

// Nov 9, 2018: Spool diameter can now be customized; a rim connects to the spring
// Nov 7, 2018: Original version

spool_diameter = 49.6;

// Leave at 49.6 to match the spring
rim_diameter = 49.6;

// For taping to the spring
rim_width = 10;

// Total width of the hub (including rim)
hub_width = 50;

bearing_diameter = 22.2;

bearing_width = 8;

// Circle rendering parameter
$fn=100;

intersection(){
    union(){
        half_spool();
        mirror([0,0,1])half_spool();
    }
    union(){
        translate([0,0,-hub_width/2+rim_width])cylinder(d=spool_diameter,h=hub_width-rim_width+1);
        translate([0,0,-hub_width/2-1])cylinder(d=rim_diameter,h=rim_width+1);        
    }
}

module half_spool(){
    difference(){
        cylinder(d=max(spool_diameter,rim_diameter),h=hub_width/2);
        translate([0,0,hub_width/2-bearing_width])cylinder(d=bearing_diameter,h=bearing_width+1);
        translate([0,0,hub_width/2-bearing_width-0.2])cylinder(d=bearing_diameter,h=1,$fn=7);
        translate([0,0,-1])cylinder(d=bearing_diameter-bearing_diameter/10,h=hub_width/2+2);
    }
}