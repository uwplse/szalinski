totalHeight = 40;
width = 40;
radius = 4;
thickness = 2;

prullenbak(totalHeight,thickness,width,radius);

//This is how smooth the radius will be
$fn = 25*2;

///////JONGE VET DIT
module prullenbak(totalHeight=30, thickness = 2, width = 40, radius = 4 ){
    binnenradius = (radius > thickness) ? radius - thickness : 0;
    
    linear_extrude(height=totalHeight){
        difference(){
            offset(r=radius){
                square(width-(2*radius), center = true);
            }
            offset(r=binnenradius){
                square((width-(2*thickness)-(2*binnenradius)), center = true);
            }
        }
    }

translate([0,0,-thickness]){
    linear_extrude(height=thickness, scale = 1/0.95){
        scale(0.95){
        offset(r=radius){
           square(width-(2*radius), center = true);
        }
    }
    }
}
}