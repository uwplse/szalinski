/* [Box] */
//Box height
height=15;
//Box length
length=100;
//Box width
width=100;
//Radius for corners (minimum 2)
cornerrad=10;
//Wall thickness
outwalls=1.2;
//Box thickness for floor
thickness=1.2;

/* [Box Sections] */
//Amount of sections in the length
sectionsl=5;
//Amount of sections in the width
sectionsw=5;
//Sections height
sectionsh=14;
//Inner walls thickness
inwalls=0.8;

/* [Lid] */
//Tolerance for lid
tol=0.4; 
//Lid thickness for top
lidthickness=1.2;
//Lid height
lidheight=6;

l=length-(cornerrad*2);
w=width-(cornerrad*2);

translate([cornerrad, cornerrad, 0]){
    union(){
        difference() {
            hull() {
                h = (height/2);
                translate([0,0,h]) cylinder(h=height, r=cornerrad, $fn=80, center = true);
                translate([0,l,h]) cylinder(h=height, r=cornerrad, $fn=80, center = true);
                translate([w,l,h]) cylinder(h=height, r=cornerrad, $fn=80, center = true);
                translate([w,0,h]) cylinder(h=height, r=cornerrad, $fn=80, center = true);
            }
            hull() {
                h = (height/2) + thickness;
                translate([0,0,h]) cylinder(h=height, r=cornerrad-outwalls, $fn=80, center = true);
                translate([0,l,h]) cylinder(h=height, r=cornerrad-outwalls, $fn=80, center = true);
                translate([w,l,h]) cylinder(h=height, r=cornerrad-outwalls, $fn=80, center = true);
                translate([w,0,h]) cylinder(h=height, r=cornerrad-outwalls, $fn=80, center = true);
            }
        }
        
        if( sectionsl > 0 ){
            cutl = ((length) - (outwalls*2))/sectionsl;
            for(i = [cutl : cutl : length-cutl]) {
                translate([w/2,i+outwalls-cornerrad,sectionsh/2]) cube([width,inwalls,sectionsh], center=true);
            }
        }
        
        if( sectionsw > 0 ){
            cutw = ((width) - (outwalls*2))/sectionsw;
            for(i = [cutw : cutw : width-cutw]) {
                translate([i+outwalls-cornerrad,l/2,sectionsh/2]) cube([inwalls,length,sectionsh], center=true);
            }
        }
        
    }

    translate([w + (cornerrad*2) + 6, outwalls, 0]){
        difference() {
            hull() {
                h = (lidheight/2);
                translate([0,0,h]) cylinder(h=lidheight, r=cornerrad+tol+outwalls, $fn=80, center = true);
                translate([0,l,h]) cylinder(h=lidheight, r=cornerrad+tol+outwalls, $fn=80, center = true);
                translate([w,l,h]) cylinder(h=lidheight, r=cornerrad+tol+outwalls, $fn=80, center = true);
                translate([w,0,h]) cylinder(h=lidheight, r=cornerrad+tol+outwalls, $fn=80, center = true);
            }
            
            hull() {
                h = (lidheight/2) + lidthickness;
                translate([0,0,h]) cylinder(h=lidheight, r=(cornerrad)+tol, $fn=80, center = true);
                translate([0,l,h]) cylinder(h=lidheight, r=(cornerrad)+tol, $fn=80, center = true);
                translate([w,l,h]) cylinder(h=lidheight, r=(cornerrad)+tol, $fn=80, center = true);
                translate([w,0,h]) cylinder(h=lidheight, r=(cornerrad)+tol, $fn=80, center = true);
            }
        }
    }
}