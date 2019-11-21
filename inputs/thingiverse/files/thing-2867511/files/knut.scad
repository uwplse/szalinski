
/* [Main] */
// Length of piece with two slots (default is 80)
length = 80; // [60:200]

// Width of the log (default is 12)
width = 12; // [8:30]

// Main component type
type = "log"; //[log:Log, post:Post (experimental only works with flat timber)]

// Style of the base timber
log_style = "flat"; // [flat:Flat, rounded:Rounded, hex:Hexagon (experimental)]

// Style of the timber notch/slot
notch_style = "basic"; // [basic:Basic, dala:Dalaknut (experimental), none:No notches]

// Number of slots
slots = 1;

// Chop off one of the ends of the log
chopped = "no"; // [no:No,yes:Yes]

// Peg holes in the slots
slot_holes = "no"; // [no:No,yes:Yes]

// Number of extra slots on top side
extra_slots_top = 0; // [0:2]

// Number of extra slots on bottom side
extra_slots_bottom = 0; // [0:2]

// Special functions
special = ""; // [:Nothing, brio: Brio wood track slot, lego: Top side lego studs (not supported yet) ]


/* [Post] */

// Post height (in number of logs)
post_height = 7; // [2:20]

/* [Hidden] */
_n = slots; 
_w = width;
_chamfer = 1.6;
_l_knot = 5;
_slot_depth_tolerance = 0.4;
_slot_width_tolerance = 0.6;
_slot_depth = _w/4+_slot_depth_tolerance;
_slot_l = _w+_slot_width_tolerance; // Slot length
_slot_spacing = length - 2* _l_knot - 2*_slot_l;

_chop_length_tolerance = 0.5;

_min_length = 2*_l_knot + _slot_l; // Length of piece with one slot
_extending_length = length - _min_length;

_l = _min_length + (_n-1)*_extending_length; // Total length

_slot_distance = length-2*_l_knot-_slot_l;

_chopped = chopped;
_slot_holes = slot_holes;
_special = special;

_hex_width = _w*0.2;

print();

module print() {
    //translate([0,0,0]) half_timber();
    //translate([_w*2,0,0]) half_timber();
    //translate([-_w/2,0,0]) rotate([0,-90,0])
    if (type == "post") {
        full_timber(top_slots=false);

        translate([0,0,(_w/2)*(post_height-1)])
        translate([_w/2,_l_knot+_slot_l/2,0])
        rotate([0,0,90*(post_height-1)]) 
        translate([-_w/2,-_l_knot-_slot_l/2,0]) 
            full_timber(bottom_slots=false);
        
        translate([0,_w+_l_knot+(_slot_l-_w)/2,_slot_depth])
        rotate([90,0,0])
            timber((_w/2)*(post_height) - _slot_depth_tolerance*2);
        
    } else {
        if (log_style == "flat") {
            //rotate([0,-90,0]) 
                full_timber();
        } else {
            full_timber();
        }
    }
    //translate([-_w*2,0,0]) rotate([0,-90,0]) full_timber();    
}

module half_timber() {
    translate([0,0,-_w/2])
    difference() {
        full_timber();
        translate([-1,-1,-2]) cube([_w+2,_l+2,_w/2+2]);
    }
}

module post() {
    
}

module full_timber(top_slots=true,bottom_slots=true) {
    difference() {
        timber(_l);
        
        slots() slot(top_slots=top_slots,bottom_slots=bottom_slots);
        /*
        for (i = [1:_n]) {
            translate([0,_l_knot + (i-1)*_slot_distance,0]) {
                slot();
                if (_slot_holes == "yes") {
                    translate([_w/2,_slot_l/2,0]) cylinder(r=2.5,h=_w,$fn=20);
                }
            }
        }
        */
        if (log_style == "rounded") {
            slots() cutouts();
        }
        
        if (_slot_holes == "yes") {
            slots() translate([_w/2,_slot_l/2,0]) cylinder(r=2.5,h=_w,$fn=20);
        }
        
        if (_chopped == "yes") {
            translate([-_w*0.5,(_n-1)*_extending_length-_chop_length_tolerance,-1]) cube([_w*2,_min_length+2,_w+2]);
        }
        
        if (_special == "brio") {
            _brio_slot_width = 40;
            if (_n > 1) {
                for (i = [1:_n-1]) {
                    translate([-_w/2, length/2 - _brio_slot_width/2 + (i-1)*(_extending_length),_w/2]) cube([_w*2,_brio_slot_width,_w+2]);
                }
            }
        }
        
        extra_slots(extra_slots_top) slot_top();
        extra_slots(extra_slots_bottom) slot_bottom();
        
        if (log_style == "rounded") {
            extra_slots(extra_slots_top) cutout_top();
            extra_slots(extra_slots_bottom) cutout_bottom();
        }
        
    }
}

module slots() {
     for (i = [1:_n]) {
        translate([0,_l_knot + (i-1)*_slot_distance,0]) {
            children();
        }
    }
}

module extra_slots(extra_slots) {
     if (extra_slots > 0) {
            _extra_slot_spacing = (_slot_spacing - _slot_l*extra_slots) / (extra_slots+1);
            for (i = [0:_n-2]) {
                //slot_top();
                translate([0,_l_knot + _slot_l  + _extra_slot_spacing + i*_extending_length ,0])
                    for (i = [0:extra_slots-1]) {
                        translate([0,i*(_slot_l + _extra_slot_spacing),0]) children();
                    }
            }
        }
}



module slot(top_slots=true,bottom_slots=true) {
    //translate([-1,0,-2]) cube([_w+2,_slot_l,_w/4+_slot_depth_tolerance+2]);
    if (top_slots) {
        slot_top();
    }
    if (bottom_slots) {
        slot_bottom();
    }
    
}

module slot_top() {
    if (notch_style == "basic") {
        translate([-_w/2-1,0,_w/4*3-_slot_depth_tolerance]) cube([2*_w+2,_slot_l,_w/4+2]);
    } else if (notch_style == "dala") {
        slot_top_dala();

    }
}

module slot_top_dala() {
    if (log_style == "hex") {
        difference() {
            translate([_min_length-1,0,_w/2]) rotate([0,0,90]) hex_timber(_min_length,width_tolerance=0.2);
            translate([_w/2-_w/4,0,_w/2]) cube([_w/2,_w,_w/4]);
        }
        //translate([-_w+_w/4,0,_w/2]) cube([_w,_slot_l,_w]);
        //translate([-_w/2 -1,0,_w*(3/4)]) cube([_w*2+2,_slot_l,_w]);
        //translate([_w-_w/4,0,_w/2-_slot_depth_tolerance]) cube([_w,_slot_l,_w]);
    } else {
        translate([-_w+_w/4,0,_w/2-_slot_depth_tolerance]) cube([_w,_slot_l,_w]);
        translate([-_w/2 -1,0,_w*(3/4)]) cube([_w*2+2,_slot_l,_w]);
        translate([_w-_w/4,0,_w/2-_slot_depth_tolerance]) cube([_w,_slot_l,_w]);
    }
}

module slot_bottom() {
    if (notch_style == "basic") {
        translate([-_w/2-1,0,-2]) cube([2*_w+2,_slot_l,_w/4+_slot_depth_tolerance+2]);
    } else if (notch_style == "dala") {
        slot_bottom_dala();
    }
}

module slot_bottom_dala() {
    if (log_style == "hex") {
        translate([-_w/2,_w/2-_w/4-_slot_width_tolerance/2,-_w/4+_slot_depth_tolerance]) cube([_w*2,_w/2+_slot_width_tolerance,_w/2]);
    } else {
        translate([-_w/2,_w/2-_w/4-_slot_width_tolerance/2,-_w/4+_slot_depth_tolerance]) cube([_w*2,_w/2+_slot_width_tolerance,_w/2]);
    }
}

module cutouts() {
    cutout_top();
    cutout_bottom();
}

module cutout_top() {
    translate([_w,0,_w/2-_slot_depth_tolerance]) slot_cut();
    translate([0,0,_w/2-_slot_depth_tolerance]) mirror([1,0,0]) slot_cut();
}

module cutout_bottom() {
    translate([_w,0,-_w/2+_slot_depth_tolerance]) slot_cut();
    translate([0,0,-_w/2+_slot_depth_tolerance]) mirror([1,0,0]) slot_cut();
}

module slot_cut() {
    translate([0,0,0]) cube([_w,_slot_l,_w]);
    rotate([0,0,-45]) cube([_w,_slot_l,_w]);
    translate([0,_slot_l,0]) rotate([0,0,-45]) cube([_w,_slot_l,_w]);
}

//timber(_l);
module timber(length) {
    if (log_style == "rounded") {
        rounded_timber(length);
    } else if (log_style == "hex") {
        hex_timber(length);
    } else {
        square_timber(length);
    }
}

module rounded_timber(length) {

    translate([_w/2,0,_w/2])
    rotate([0,90,0])
    rotate([-90,0,0])
    difference() {
        cylinder(r=sqrt(2*pow(_w,2))/2,h=length);
        translate([_w/2,-_w/2,-1]) cube([_w,_w,length+2]);
        translate([-_w/2-_w,-_w/2,-1]) cube([_w,_w,length+2]);
    }
    
}


module square_timber(length) {
    translate([0,length,0])
    rotate([90,0,0])
    linear_extrude(height=length) {
    polygon([
        [_chamfer,0],
        [0,_chamfer],
        [0,_w-_chamfer],
        [_chamfer,_w],
        [_w-_chamfer,_w],
        [_w,_w-_chamfer],
        [_w,_chamfer],
        [_w-_chamfer,0]
    ]);
    }
    
    //cube([_w,length,_w]);
}

module hex_timber(length,width_tolerance=0) {
    translate([0,length,0])
    rotate([90,0,0])
    linear_extrude(height=length) {
    polygon([
        [_hex_width-width_tolerance,0],
        [-width_tolerance,_w/2],
        [_hex_width-width_tolerance,_w],
        [_w-_hex_width+width_tolerance,_w],
        [_w+width_tolerance,_w/2],
        [_w-_hex_width+width_tolerance,0]
    ]);
    }
    
    //cube([_w,length,_w]);
}




