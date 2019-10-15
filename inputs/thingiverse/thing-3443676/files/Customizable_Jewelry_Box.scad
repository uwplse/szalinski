/* [Box] */
//Box height
height=20;
//Box length
length=100;
//Box width
width=75;
//Radius for corners (minimum 2)
cornerrad=10*1;
//Wall thickness
outwalls=1.2*1;
//Box thickness for floor
thickness=1.2;
//divider thickness
divider_thickness=1;

/* [Lid] */
//Tolerance for lid
tol=0.4*1; 
//Lid thickness for top
lidthickness=1.2;
//Lid height
lidheight=6;

//
/*[type of divider arrangement;]*/
type=4;

//////
if (type==1)
{   
/* [Box Sections1] */
//across long (Y)
 translate([.4*width,0,0])
    cube([divider_thickness,length,height]);
 //top big divider (X)
 translate([.4*width,1/2*length,0])
    cube([.6*width,divider_thickness,height]);
 //top small divider (Y)
 translate([1/2*length,1/2*length,0])
    cube([divider_thickness,1/2*length,height]); 
 //top small divider (X)
 translate([1/2*length,width,0])
    cube([1/4*length,divider_thickness,height]);
}
//////
if (type==2)
{
/* [Box Sections2] */
//across top left (Y)
 translate([.25*width,.5*length,0])
    cube([divider_thickness,.5*length,height]);
 // across long (X)
 translate([0,.5*length,0])
    cube([.5*length,divider_thickness,height]);
//across top right (Y)
 translate([.665*width,.5*length,0])
    cube([divider_thickness,.5*length,height]);
 //bottom big divider (Y)
 translate([.5*length,0,0])
    cube([divider_thickness,1/2*length,height]); 
 //bottom small divider (X)
 translate([0,.25*length,0])
    cube([1/2*length,divider_thickness,height]);
 //bottom small divider (Y)
 translate([0,.25*length,0])
    cube([divider_thickness,1/2*length,height]); 
}
/////////

if (type==3)
{
/* [Box Sections3] */
//across long (Y)
 translate([.4*width,0,0])
    cube([divider_thickness,length,height]);
 //top small divider (Y)
 translate([1/2*length,0,0])
    cube([divider_thickness,length,height]); 
 //top small divider (X)
 translate([.3*length,.35*width,0])
    cube([.43*length,divider_thickness,height]);
 //bottom small divider (X)
 translate([.3*length,width,0])
    cube([.43*length,divider_thickness,height]);
}
/////////

if (type==4)
{
/* [Box Sections4] */
//across long (Y)
 translate([.2*width,0,0])
    cube([divider_thickness,length,height]);
 //top big divider (X)
 translate([.2*width,1/2*length,0])
    cube([.8*width,divider_thickness,height]);
 //top small divider (Y)
 translate([1/2*length,1/2*length,0])
    cube([divider_thickness,1/2*length,height]); 
 //top small divider (X)
 translate([1/2*length,width,0])
    cube([.25*length,divider_thickness,height]);
}
/////


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
      
  ///      if( sectionsl > 0 ){
  //          cutl = ((length) - (outwalls*2))/sectionsl;
  //          for(i = [cutl : cutl : length-cutl]) {
  //              translate([w/2,i+outwalls-cornerrad,sectionsh/2]) ///cube([width,inwalls,sectionsh], center=true);
     ///       }
    //    }
        
   //     if( sectionsw > 0 ){
   //         cutw = ((width) - (outwalls*2))/sectionsw;
    //        for(i = [cutw : cutw : width-cutw]) {
    //            translate([i+outwalls-cornerrad,l/2,sectionsh/2]) //cube([inwalls,length,sectionsh], center=true);
   //         }
    //    }
        
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

 





 
