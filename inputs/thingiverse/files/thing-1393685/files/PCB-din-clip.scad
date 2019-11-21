// Remix of http://www.thingiverse.com/thing:806093

//Clip thickness
CLIP_H = 6;
// Holes diameter
HOLE_DIAMETER = 2.9;
// Distance between the 2 holes
PILLAR_PITCH = 62.23;

// Height of the mounting bar
MOUNT_H = 5;
// Height of pillars
PILLAR_H = 2;

PILLAR_1_Y_OFFSET = PILLAR_PITCH/2;
PILLAR_2_Y_OFFSET = -PILLAR_PITCH/2;

module shape()
{
    p = [[9.403850,21.092300],[9.584450,20.854000],[9.593250,20.554200],[9.427250,20.305200],[5.756350,17.154800],[5.495650,17.124500],[5.354950,17.347200],[5.354950,19.249500],[-5.295400,19.249500],[-5.647940,19.095200],[-5.769030,18.756400],[-5.654770,18.417500],[-5.295400,18.264200],[2.869650,18.264200],[3.253450,18.186000],[3.566950,17.975100],[3.777850,17.661600],[3.854950,17.277800],[3.854950,-17.249500],[5.354950,-17.249500],[6.381350,-13.599100],[6.745650,-13.189900],[7.271050,-13.038600],[7.819850,-13.038600],[8.168450,-13.183100],[8.312950,-13.531700],[8.312950,-17.211400],[8.162650,-19.965300],[7.735850,-20.605000],[7.096250,-21.032700],[6.341350,-21.183100],[-9.593250,-21.183100],[-9.593250,21.183100],[9.118650,21.183100]];
    
    xm = min([ for (x=p) x[0] ]);
    ym = min([ for (x=p) x[1] ]); 
    echo([xm, ym]);
    translate([0,22.183,0]) // This offset is know by displaying 
                            // DXF file a CAD software
        rotate([180,0,0])
            translate([-xm, -ym])
                polygon(p);
}

module din_clip() {

	difference() {
		
		union() {
            linear_extrude(height=CLIP_H, center=true, convexity=5) {
                //import(file="PCB_din_clip.dxf", $fn=64);
                shape();
            }
		      
            translate([-MOUNT_H/2, 0, 0]) {
                cube([MOUNT_H,PILLAR_PITCH+6,CLIP_H], center=true);
            }
            
            translate([-PILLAR_H/2-MOUNT_H, PILLAR_1_Y_OFFSET, 0]) {
				rotate([0, 0, 0]) {
					cube([PILLAR_H,6,CLIP_H], center = true);
				}
            }

            translate([-PILLAR_H/2-MOUNT_H, PILLAR_2_Y_OFFSET, 0]) {
				rotate([0, 0, 0]) {
					cube([PILLAR_H,6,CLIP_H], center = true);
				}
            }
		}

		union() {
			translate([-PILLAR_H-MOUNT_H-0.5, PILLAR_2_Y_OFFSET, 0]) {
				rotate([0, 90, 0]) {
					cylinder(h= PILLAR_H+MOUNT_H+1, r = HOLE_DIAMETER / 2, $fn = 16);
				}
			}
			translate([-PILLAR_H-MOUNT_H-0.5, PILLAR_1_Y_OFFSET, 0]) {
				rotate([0, 90, 0]) {
					cylinder(h= PILLAR_H+MOUNT_H+1, r = HOLE_DIAMETER / 2, $fn = 16);
				}
			}
		}
    }
}

din_clip();

