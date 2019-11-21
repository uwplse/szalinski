/*

    **** ROBUST PARAMETRIC KNOB FOR ROTARY CONTROLS *****

    Torbjorn Skauli (tskauli@gmail.com)
    August 2018, released in the public domain.

This is a rotary knob such as those used for volume controls. The shape of the knob can be adjusted, mainly by changing its outer diameter, height and taper towards the top. It is also possible to add an arrow indicator on the top surface, and the shape can be made faceted rather than round. A bevelled edge around the top is also adjustable in the code.

The knob normally uses a set screw from the side. The screw is held by a nut resting on a washer, to ensure strength that allows for tightening. Either a headless setscrew can be used, or an optional recess for a flat head screw can be enabled. It is also possible to disable the screw and nut holes, for press fit on the shaft The inner structures can be recessed into the knob to enclose the mounting nut of the shaft in the panel.

The knob is designed to be printed upside down, and does not need any support material on printers capable of printing a 45-degree overhang, thanks to teardrop-shaped holes.

To assemble, first insert a washer and a nut in their slots, and then thread the screw in from the side. The washer may need to be pressed in with some force using pliers, depending on the accuracy of the print. If using a headed screw, the knob looks nicest if the screw length is such that the head is approximately flush with the outer surface when tightened.

*/
has_setscrew=1; // [ 1:include a set screw, 0:only shaft hole ]
has_arrow=1;    // [ 1:include an indicator arrow, 2:plain top ]
has_screwhead=1;// [ 1:screw with head - enlarged hole, 0:hex socket set screw ]

// No. of outer facets, or =0 if smooth
facets=0;       

// Pot/encoder axis diameter
axdia=4.2;      

// Knob outer diameter
outdia=23;      

// Height of outer part of knob
outheig=13;     

// Recess depth inside outer shell to accommodate pot panel mount nut
innerrecess=2.5;

// Radius reduction for tapering of main part, =0 for cylindrical shape.
rtaper=2;       

// set screw diameter
scrdia=3;       

/* [Hidden] */
twall=1.2;      // outer wall thickness
thinwall=0.5;   // thickness at the bottom of the axis hole (to push in as far as possible)
taxis=5;        // thickness of material around axis
tol=0.025;      // tolerance for fit, adapt to printer
gap=0.1;        // loose fit, adapt to printer
cacc=3;         // SPEED / ACCURACY scaling factor for $fn etc. 1=draft, >1=final
rbevel=1.6;     // delta radius to bevel start, also depth of arrow

// Hardware dimensions (adapted from. http://www.metrication.com/engineering/fastener.html)
scrhdia=2*scrdia;       // screw head diameter
washdia=2.6*scrdia;     // washer diameter and thickness
washthic=0.5;           // washer thickness
nutdia=1.9*scrdia;      // nut smallest diameter
nutdiaouter=2.2*scrdia; // nut largest diameter and thickness (check)
nutthic=0.9*scrdia;     // nut thickness
axgapfac=0.06;          // factor to move nut room closer to axis, rel to axis radius to avoid thin walls between nut and axis

wscrbase=axdia+2*taxis; // width of screw base
lscrbase=4*scrdia;      // length of screw base
innheig=outheig-innerrecess;// height of inner part
scrheig=innheig-max(washdia/2, scrdia);// height of screw hole

module teardropHole(lh,rh){ // Hole with 45-degree teardrop shape, no support material
    rotate([0,0,-135])
    union(){
        cylinder(h=lh,r1=rh,r2=rh,$fn=8*cacc);
        cube([rh,rh,lh]);
    };
};
module outershape(){ // Outer shape of knob
    union(){
        if (facets){
            translate([0,0,rbevel])
            cylinder(r1=(outdia)/2-rtaper,r2=outdia/2,h=outheig-rbevel,$fn=facets);
            cylinder(r1=(outdia)/2-rbevel-rtaper,r2=(outdia)/2-rtaper,h=rbevel,$fn=facets);
        }
        else{
            translate([0,0,rbevel])
            cylinder(r1=(outdia)/2-rtaper,r2=outdia/2,h=outheig-rbevel,$fn=15*cacc);
            cylinder(r1=(outdia)/2-rbevel-rtaper,r2=(outdia)/2-rtaper,h=rbevel,$fn=15*cacc);
        };
        
    };
};
module cavity(){ // inner cavity, to save plastic
    translate([0,0,max(twall,rbevel+thinwall)]) // cavity to save plastic
    cylinder(r1=(outdia)/2-twall-rtaper,r2=(outdia)/2-twall,h=outheig,$fn=10*cacc);
};
module axismount(){ // axis hole and clamp screw block
    intersection(){
        union(){ 
            // axis tube
            cylinder(d=axdia+2*taxis,h=innheig,$fn=15*cacc);
            // block for nut
            if (has_setscrew)
                translate([-wscrbase/2,0,0])
                cube([wscrbase,outdia/2,innheig]);
        };
        // ensure fit within outer shape
        outershape();
    };
};
module holes(){ // shapes to be carved out of the knob
    // axis hole
    translate([0,0,thinwall]) 
    cylinder(d=axdia+tol,h=innheig,$fn=12*cacc);

    // arrow indicator
    if (has_arrow)
        translate([0,-outdia/8,0])
        rotate([90,0,0])
        cylinder(r=rbevel,h=outdia,$fn=4);
    
    // holes and recesses for screw, nut and washer
    if (has_setscrew) {
        // screw hole
        translate([0,0,scrheig])
        rotate([-90,0,0])
        teardropHole(rh=(scrdia+gap)/2,lh=outdia);
        
        //nut recess
        translate([-(nutdia+gap)/2,axdia*(0.5-axgapfac),scrheig-nutdiaouter/2-gap])
        cube([nutdia+gap,nutthic+axdia*axgapfac,outheig]);
        
        
        // washer recess
        translate([-(washdia+gap)/2,axdia/2+nutthic,scrheig-washdia/2-gap])
        cube([washdia+gap,washthic,outheig]);
        
        // screw head recess
        if (has_screwhead)
            translate([0,axdia/2+nutthic+washthic+scrdia,scrheig])
            rotate([-90,0,0]) 
            teardropHole(rh=(scrhdia+gap)/2,lh=outdia);
    };
  
};
difference(){ // screw holes and arrow erosion
    union(){ // shell and screw mount
        difference(){
            outershape();
            cavity();
        };
        axismount();    

    };
        holes();
};