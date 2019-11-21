//-----------------------------------------------------------------------------
// Nut Cover - for print in place or fitting after printing by Matt Kidd
// Adjust the parameters below to suit your purpose.
// You may wish to experiment with the nut tolerances for larger nut sizes.
//-----------------------------------------------------------------------------

// part diameter in mm
knob_diameter = 30; 

// outer diameter of the nut (point to point) in mm
nut_od = 8.6; 

// how tall is the nut in mm? (add 0.7 mm to the measurement or up to 1.2mm if you're fitting it during printing)
nut_h = 3.5; 

// 0.9 should be a tight fit - increase to 1.5 for a looser fit (better if placing during print) in mm
nut_tol = 0.9; 

// machine thread size in mm
nut_ts = 3; 

// how tall is the component? in mm
height = 10; 

// how wide is the dent? in mm
dent_width = 8; 

// how deep is the dent? in mm
dent_depth = 2;

// how many dents in the surface? in mm
num_dents =10; 

// how smooth are the curves? (multiplied by 18 or 36 in the part details.)
accuracy = 4; 

// are we chamfering the edges? 0 for no, >0 for chamfer height in mm
chamfer_edges = 1; 

// if true the nut hole will be in the centre of the part so that you can stop the print and fit the nut in the middle of the part. false and the hole will be at the top of the part.
pip = false; 

// a generic tolerance added to make union parts overlap with other parts of the union and extend slightly beyond the edge of the part to remove face fighting artifacts from preview. Setting this to a large value would significantly interfere with the bevel angle.
tol = 0.01;

//-----------------------------------------------------------------------------

// The knob body

module knob(){
    cylinder(h=height-chamfer_edges*2,r=knob_diameter/2,$fn=accuracy*36,center=true);
    translate([0,0,height/2-(chamfer_edges/2)]) cylinder(h=chamfer_edges,r1=knob_diameter/2,r2=knob_diameter/2-chamfer_edges,$fn=accuracy*36,center=true);
    translate([0,0,-(height/2-(chamfer_edges/2))]) cylinder(h=chamfer_edges,r2=knob_diameter/2,r1=knob_diameter/2-chamfer_edges,$fn=accuracy*36,center=true);
}

// The dent body

module dent(){
    union(){
        translate([0,-dent_width/2+dent_depth,-((height-(chamfer_edges*2))/2+chamfer_edges/2)-tol/2]) cylinder(h=chamfer_edges+tol,r1=dent_width/2+chamfer_edges,r2=dent_width/2,$fn=accuracy*18,center=true);
        translate([0,-dent_width/2+dent_depth,(height-(chamfer_edges*2))/2+chamfer_edges/2+tol/2]) cylinder(h=chamfer_edges+tol,r1=dent_width/2,r2=dent_width/2+chamfer_edges,$fn=accuracy*18,center=true);
        translate([0,-dent_width/2+dent_depth,0]) cylinder(h=height-(chamfer_edges*2)+tol,r=dent_width/2,$fn=accuracy*18,center=true);
        translate([0,-((dent_width+2)*4)/2+dent_depth-dent_width/2,0]) rotate([90,0,0]) linear_extrude(height=(dent_width+2)*4,center=true, convexity = 10){
            polygon(points=[[-dent_width/2-chamfer_edges,height/2],[dent_width/2+chamfer_edges,height/2],[dent_width/2,height/2-chamfer_edges],[dent_width/2,-(height/2-chamfer_edges)],[dent_width/2+chamfer_edges,-(height/2)],[-(dent_width/2)-chamfer_edges,-(height/2)],[-(dent_width/2),-(height/2)+chamfer_edges],[-(dent_width/2),(height/2)-chamfer_edges]],paths=[[0,1,2,3,4,5,6,7]]);
        }
    }
}

// Union of the through hole for the thread and nut cavity.

module nut_holes(){
    union(){
        translate([0,0,0]) cylinder(h=height+tol,r=(nut_ts+nut_tol)/2,$fn=accuracy*18,center=true);
        if(pip){
            translate([0,0,0]) cylinder(h=nut_h,r=(nut_od+nut_tol)/2,$fn=6,center=true);    
        }
        else{
            translate([0,0,((height-nut_h)/2)+tol/2]) cylinder(h=nut_h+tol,r=(nut_od+nut_tol)/2,$fn=6,center=true);
        };
    }
}

// Assembling our final part

difference(){
    knob();
    for (a =[1:1:num_dents]) rotate([0,0,(360/num_dents)*a]) translate([0,-knob_diameter/2,0]) dent();
    nut_holes();
}
