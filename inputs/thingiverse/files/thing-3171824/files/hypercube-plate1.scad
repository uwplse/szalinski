//x carrage mount
//height
height = 65;
//length
length = 55;
//width
width = 10;
// hole size
holesize = 3;
//cutout height
Cheight = 35;
//cutout width
Cwidth = 10;
//cutout depth
Cdepth = 5;
//distance between hole for mounting hotend
mount_h_distance = 26;

//groovemount parts
//larger cylinder of groove mount
groove_large = 16;
//smaller cylinder of groove mount
groove_small = 12;
//groove large cylinder height mount
groove_large_h = 7;
//groove small cylinder height mount
groove_small_h = 6;
//bottom groove height
bottom_groove_h = 3.1;
//mount block distance away from surface
mount_width = 30;
//mount block height from bottom
mount_height = 50;

//pillar parts
//pillar height
p_height = 40;
//pillar width
p_width = 10;
//pillar hole
p_hole = 3;

difference(){//make final screw holes
    union(){ //combine groovemount to mounting plate
        difference(){ //make the groove mount
            
            translate([0,width,mount_height])cube([length, mount_width,15]);
            translate([length/2,width+mount_width,mount_height]) union(){ //grovemount to cut out
                
                cylinder(d=groove_large, h =bottom_groove_h);
                translate([0,0,bottom_groove_h]) cylinder(d=groove_small , h=groove_small_h);
                translate([0,0,groove_small_h+ bottom_groove_h]) cylinder(d=groove_large , h=groove_large_h);
            }
        }
        difference(){ //make the mounting plate
        
            
        
            //the cube
            cube([length, width, height]); 
            
            //the holes
            translate([15,0,20]) rotate([270,0,0]) cylinder( d=holesize , h = width);
            translate([40,0,20]) rotate([270,0,0]) cylinder( d=holesize , h = width);
            translate([40,0,45]) rotate([270,0,0]) cylinder( d=holesize , h = width);
            translate([15,0,45]) rotate([270,0,0]) cylinder( d=holesize , h = width);
            translate([length/2,0,height/2]) rotate([270,0,0]) cylinder( d=holesize , h = width);
            translate([12,0,5]) rotate([270,0,0]) cylinder( d=holesize , h = width);
            translate([43,0,5]) rotate([270,0,0]) cylinder( d=holesize , h = width);
            //the cutouts
            translate([0,0,10]) cube([Cwidth, Cdepth, Cheight]);
            translate([length-Cwidth,0,10]) cube([Cwidth, Cdepth, Cheight]);
            
        }

        difference(){//support riser/pillar thing
            union(){
                translate([length/2, 0, height]) cube([p_width, width, p_height]);
                translate([length/2+p_width/2,0, height+p_height]) rotate([270,0,0]) cylinder(d=p_width, h=width);
                }
                hole_offset = length/2+ (p_width-p_hole)/2;
                translate([hole_offset, 0, height]) cube([p_hole, width, p_height]);
                translate([length/2+p_width/2,0, height+p_height]) rotate([270,0,0]) cylinder(d=p_hole, h=width);
            }
    }
    translate([length/2 +mount_h_distance/2,0,mount_height+7.5]) rotate([270,0,0]) cylinder(d=holesize, h=width+mount_width);
    translate([length/2 -mount_h_distance/2,0,mount_height+7.5]) rotate([270,0,0]) cylinder(d=holesize, h=width+mount_width);
    
    //this is where the mounting screw holes to each side of the groovemoutn will go
}