/* [PCB Parameters] */
// PCB Width
pcb_width=40;
// PCB Length (slides in this way)
pcb_length=40;
// PCB Thickness (groove size)
pcb_thickness=1.5; 
// Space between board and shield
pcb_space=5; // [1:20]
// Extra Supports
extra_supports=0; // [0:5]

/* [Shield Parameters] */
// Wall Thickness (
wall_thickness=3;  // [3:7]
// Bottom Thickness
bottom_thickness=1; // [1:7]
// PCB Groove Depth
inset=1.5; // [1,1.5,2]



/* [Hidden] */
// Below are not parameters

wall_thin=wall_thickness - inset;

shield_w = pcb_width + (2 * wall_thin);
shield_l = pcb_length + wall_thin;
shield_h = pcb_space + bottom_thickness + pcb_thickness + wall_thin; 

module shield() {
    cube([shield_w, shield_l, shield_h]);
}

module shield_cut() {
    w = pcb_width - (2*inset);
    l = pcb_length - inset + 0.01;
    h = shield_h - bottom_thickness + 0.01;   
    cube([w, l, h]); 
}

module pcb_cut() {
    cube([pcb_width, pcb_length+0.01, pcb_thickness]);
}

module support() { 
    cube([inset/2,inset/2,pcb_thickness]);
}

module supports() { 
    h = bottom_thickness + pcb_space;
    l1 = wall_thickness - (inset/2);
	l2 = pcb_length + (inset/2);
	w2 = pcb_width;
	
    translate([l1, l1, h]) { support(); }
    translate([l1, l2, h]) { support(); }
    translate([w2, l2, h]) { support(); }
    translate([w2, l1, h]) { support(); }
	
	wd = (w2 - l1);
	ld = (l2 - l1);
	
	for (s = [0 : extra_supports])
	{
		translate([s * (wd / (extra_supports+2)) + (wd / (extra_supports+2)) + l1, l1, h]) { support(); }
		translate([l1, s * (ld / (extra_supports+2)) + (ld / (extra_supports+2)) + l1, h]) { support(); }
		translate([w2, s * (ld / (extra_supports+2)) + (ld / (extra_supports+2)) + l1, h]) { support(); }
	}

}



module part_shield() {
    
	union() { 
		difference()
		{
			shield();
			
			translate([wall_thickness, wall_thickness, bottom_thickness]) {
				shield_cut();
			}
			
			translate([wall_thin, wall_thin, bottom_thickness+pcb_space]) {
				pcb_cut();
			}
		}
		color([1,0,0]) supports();
	}
}

part_shield();