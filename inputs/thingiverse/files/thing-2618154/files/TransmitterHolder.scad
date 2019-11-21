//Text to be displayed
_TEXT = ""; //
//Diameter of handle
_HANDLE_DIAMETER = 6.2;
//Spacing between hooks
_HOOK_SPACING = 60;
//Mount hole diameter
_MOUNT_HOLE_DIAMETER = 4.2;


_HOOK_WIDTH = 5;
_MOUNT_HOLE_SPACING = _HOOK_SPACING - _MOUNT_HOLE_DIAMETER  * 3;


$fs = 0.5;

module hook_space(){
    hull(){
        circle(d=_HANDLE_DIAMETER);
        translate([0,_HANDLE_DIAMETER*5])
        circle(d=_HANDLE_DIAMETER*3);
    }    
    translate([0,3])
    square(50);
}



module hook(){
    base_size = _HANDLE_DIAMETER * 3.5;
    end_size = _HANDLE_DIAMETER * 2.5;
    end_position = [10,5];
    
    rotate([0,-90,0])
    linear_extrude(_HOOK_WIDTH)
    difference(){
        hull(){
            translate(end_position)circle(d = end_size);
            circle(d = base_size);
        }
        
        translate(end_position + [0,1])hook_space();
        translate([-base_size,-base_size/2])
        square([base_size,base_size*2]);
    }
}

module screw_hole(){
    
    cylinder(d=_MOUNT_HOLE_DIAMETER,1,$fn=20);
    translate([0,0,1])
    hull(){
        cylinder(d=_MOUNT_HOLE_DIAMETER,1,$fn=20);
        translate([0,0,10])
        cylinder(d=_MOUNT_HOLE_DIAMETER*10,1,$fn=20);
    }
}

module base_text(){
    linear_extrude(1)
    text(_TEXT, font="Verdana:style=Bold", valign="center", halign="center");
}


module base_plate(){
    width = _HOOK_SPACING + _HOOK_WIDTH*2;
    height = _HANDLE_DIAMETER * 3.5;
    
    union(){
        difference(){
            linear_extrude(2)
            square([width,height],center=true);
            
            translate([_MOUNT_HOLE_SPACING/2,0])screw_hole();
            translate([-_MOUNT_HOLE_SPACING/2,0])screw_hole();
        }
        
        translate([-_HOOK_SPACING/2,0,2])hook();
        mirror([1,0,0])
        translate([-_HOOK_SPACING/2,0,2])hook();
        
        translate([0,0,2])
        base_text();
    }
    
}

base_plate();