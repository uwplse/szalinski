//CUSTOMIZER VARIABLES
//	Length of the hook
hooklength=20;
// Width of hook and clamp
height=15;
//CUSTOMIZER VARIABLES END

endthickness=5;
thickness=01.5;
doorheight=38.6;
correction_doorheight_inside=0.4;
door_thickness=16.7;
door_undercut=5.3;


module widerhaken(height=height)
{
    linear_extrude(height = height)
    rotate([0,0,0]) polygon(points=[[0,0],[door_undercut,0],[door_undercut,-thickness],[0,-1-thickness]], paths=[[0,1,2,3]],convexity=10);
}


module haken(height=height,hooklength=hooklength)
{translate([0,-2*thickness,0]) cube([thickness,doorheight+3*thickness,height]);
translate([door_thickness+thickness,-2*thickness-correction_doorheight_inside,0]) cube([thickness,doorheight+3*thickness+correction_doorheight_inside,height]);
translate([0,doorheight+thickness,0]) cube([door_thickness+2*thickness,thickness,height]);
    translate([thickness,1-thickness,0]) widerhaken(height);
    translate([door_thickness+thickness,-thickness+1-correction_doorheight_inside,height]) rotate([0,180,0]) widerhaken(height);
    translate([-hooklength,20,0]) cube([hooklength,10,height]);
    translate([-hooklength,20,0]) cube([endthickness,20,height]);
}

haken();