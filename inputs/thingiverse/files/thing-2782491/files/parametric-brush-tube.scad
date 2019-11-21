// VERSION 2.02 redid the knurling to remove the knurling lib
// VERSION 2.01 adjusted wall thickness of the join for better stability
// VERSION 2.0 initial release


/*************************************************************************
/ Variables - these settings can be modified to fit the need */
diameter = 46;                  // minimum 8, inside_diameter
height = 133;                    // height of the tube
vent_height = 0;                // if vent height is set (brush loft) use it
venting_height_percentage = 55;  // percentage of the height that is venting
parts = "all";                  // all, lid, lids, tube, join (a piece that can join two tubes)
double_open = 1;                // allow printing a tube with a solid bottom

/* [Hidden] */
/*************************************************************************
/ Constants - these are constants used in the build */
holesPerRow = 8;                // the number of vent holes per row
vent_diameter =2;               // the diameter of the vent holes
$fn=150;                         // quality default
wall = -1;                      // default the wall diamter 2mm up to 60 diameter, 2.5mm 61-100, 3mm larger
thread_height=(getInsideDiameter()>20?getInsideDiameter()/6:20/6); // calulate an optimum thread height
roundabout=-1;                  // set a default for the lid dimension

/*************************************************************************
/ Code - this does the object build (one tube and two lids */
if(parts == "tube" || parts == "all" || parts == "parts") {
    translate([0,0,0]) getTube();       // draw the tube
}
if(parts == "lid" || parts == "all" || parts == "parts") {
    translate([getOutsideDiameter()+7,(getOutsideDiameter()+20)/2,0]) getLid(); // draw lid 1
}
if ((parts == "lids" || parts == "all" || parts == "parts") && double_open) {
    translate([getOutsideDiameter()+7,(getOutsideDiameter()+20)/2*-1,0]) getLid(); // draw lid 2
} 
if(parts == "join" || parts == "parts") {
    translate([0-getOutsideDiameter()-7,0,0]) getJoin();       // draw the join
}
if(parts == "vents") {
    getVenting();       // draw the tube
}

echo(getOutsideDiameter());

/*************************************************************************
/ Functions, Modules and all relevant code */

// functions 
function roundabout()=roundabout==-1?getThickness()/4:max(0.2,roundabout);
function getInsideDiameter()=max(8,diameter);
function getOutsideDiameter()=getInsideDiameter()+getThickness();
function getHeight()=height;
function getThickness()=( 
	wall!=-1 ? max(1.0,wall) : (
	getInsideDiameter() <= 20 ? 1.5 : (
	getInsideDiameter() <= 60 ? 2.0 : (
	getInsideDiameter() <= 100 ? 2.5 : 
   3.0))));
function getLidHeight()=thread_height+getThickness();
function getUnthreadedHeight()= getHeight()-(getLidHeight()*2);

// modules
// getVenting = get the venting tubes for the cylinder
module getVenting() {
    $fn=10;
    rowHeight=vent_diameter*2;
    
    vent_rows= vent_height ? floor(vent_height / (rowHeight)) : floor((getUnthreadedHeight()+vent_diameter)/rowHeight) * (venting_height_percentage*.01);   

    
//    if (venting_height_percentage > 0 || venting_hgiht) {
        for (loopA =[0:rowHeight:((rowHeight*vent_rows)-rowHeight)])
        translate([0,0,loopA+vent_diameter+thread_height+(vent_diameter/2)])
        rotate([0,0,(loopA/rowHeight)*(90/holesPerRow)])
                for (loopB =[0:180/holesPerRow:180])
                color("lime") rotate([0,90,loopB]) cylinder(h=getOutsideDiameter()+(thread_height*2), d=vent_diameter, center=true);
    //}
}

// get the brush tube structure
module getTube() {
   if (double_open) {
        difference() {
            union() {
                translate([0,0,0]) cylinder(h=getHeight(), d=getOutsideDiameter());
                translate([0,0,thread_height]) cylinder(h=getHeight()-(thread_height*2), d=getOutsideDiameter()+getThickness());
                translate([0,0,getHeight()-thread_height]) thread(getInsideDiameter()/2+getThickness(),thread_height,outsideThread=false);
                translate([0,0,thread_height]) rotate(a=[0,180,0]) thread(getInsideDiameter()/2+getThickness(),thread_height,outsideThread=false);
            }
            translate([0,0,0]) cylinder(h=getHeight(), d=getInsideDiameter());
            getVenting();
        }
   } else {
        difference() {
            union() {
                translate([0,0,0]) cylinder(h=getHeight(), d=getOutsideDiameter());
                translate([0,0,0]) cylinder(h=getHeight()-(thread_height), d=getOutsideDiameter()+getThickness());
                translate([0,0,getHeight()-thread_height]) thread(getInsideDiameter()/2+getThickness(),thread_height,outsideThread=false);
            }
        translate([0,0,getThickness()]) cylinder(h=getHeight()-getThickness(), d=getInsideDiameter());
        getVenting();
        }
     
    }       
}

// get the tube structure
module thread(r,h,outsideThread=false) {
    $fn=100; // set a thread quality
	linear_extrude(height=h,twist=-250,convexity=10)
	for(a=[0:360/2:359])
        rotate([0,0,a])
        if(outsideThread) {
            difference() {
                translate([0,-r])
                square(2*r);

                offset=.8;
                translate([r*(1-1/offset),0])
                circle(r=1/offset*r);	
            }
        } else {
            offset=.8;
            translate([(1-offset)*r,0,0])
            circle(r=r*offset);
        }
}

module getLid() {
    r=getInsideDiameter()/2+getThickness()/2+roundabout();
    r0=(getInsideDiameter()>=20?r:20/2+getThickness()/2+roundabout()); 
    h=thread_height+getThickness();
    
    translate([0,0,h+getThickness()]) rotate(a=[0,180,0]) union() {
        intersection() {
            translate([0,0,getThickness()])
            thread(r,thread_height,outsideThread=true);

            cylinder(r=r+getThickness()/2,h=h);
        }

        difference() {
            a=1.05; b=1.1;
            ra=a*r+b*getThickness();
            ra0=a*r0+b*getThickness();
            h1=h+getThickness();
 
            knurl(ra,ra0,h1);

            translate([0,0,-.1])
            cylinder(r=r+getThickness()/2,h=h+.1);
        }
    }
}

// make a join for 2 tubes 
module getJoin() {
    r=getInsideDiameter()/2+getThickness()/2+roundabout();
    r0=(getInsideDiameter()>=20?r:20/2+getThickness()/2+roundabout()); 
    h=thread_height+getThickness();
    joinHeight = h+getThickness();
    
    translate([0,0,(joinHeight*2)-(getThickness())])
    rotate([0,180,0])    
    union() {
        intersection()  {
            translate([0,0,getThickness()])
            thread(r,thread_height,outsideThread=true);

            cylinder(r=r+getThickness()/2,h=h);
        }

        difference() {
            a=1.05;
            b=1.1;
            ra=a*r+b*getThickness();
            ra0=a*r0+b*getThickness();
            h1=h+getThickness();
 
                     
            knurl(k_cyl_hg	= h1,	k_cyl_od = (r+getThickness()*1.1)*1.95, e_smooth=0, s_smooth=100);

            translate([0,0,-.1])
            cylinder(r=r+getThickness()/2,h=h+.1);
            
            
        }   

    } 

    translate([0,0,0])
    union() {
        intersection()  {
            translate([0,0,getThickness()])
            thread(r,thread_height,outsideThread=true);

            cylinder(r=r+getThickness()/2,h=h);
        }

        difference() {
            a=1.05;
            b=1.1;
            ra=a*r+b*getThickness();
            ra0=a*r0+b*getThickness();
            h1=h+getThickness();
 
                     
            knurl(k_cyl_hg	= h1,	k_cyl_od = (r+getThickness()*1.1)*1.95, e_smooth=0, s_smooth=100);

            translate([0,0,-.1])
            cylinder(r=r+getThickness()/2,h=h+.1);
            
            
        }   

    }
}





module knurl(r,r0,height) {
    knurl_h=[0,0.1757073594,0.5271220782,0.7116148055,0.9007198511,1];
    knurl_rdelta=[.2,0,0.1,.3,.6,1.0];

    n=round(sqrt(120*(r+2*getThickness())*2)/5)*5;
    h_steps=len(knurl_h)-1;
    r_delta=-1.6*getThickness()/2;

    intersection_for(a=[-1,1]) {
        for(i=[0:h_steps-1]) {
            
            hr0=knurl_h[i];
            hr1=knurl_h[i+1];
            hr=hr1-hr0;
            rr0=knurl_rdelta[i];
            rr1=knurl_rdelta[i+1];
            rr=rr1-rr0;
                                    
            
            translate([0,0,hr0*height])
            rotate([0,0,35*height/r*hr0*a])
            linear_extrude(convexity=10,height=hr*height,twist=-35*height/r*hr*a,scale=(r+r_delta*rr1)/(r+r_delta*rr0)) 
            for(j=[0:n/4-1]) {
                rotate([0,0,360/n*j])
                circle(r=r+r_delta*rr0,$fn=5);
             }
        }
   }
}