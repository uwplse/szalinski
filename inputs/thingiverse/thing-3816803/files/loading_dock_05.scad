// Building Loading Dock by Eric Lindow

// This customizable rectangular deck supported with posts and risers
// optional steps/ramps

/* [Basic Parameters] */
// default: HO scale, # of mm to a foot.
scale = 3.5;        
//basic deck parameters:
// length of the dock (default: in feet)
length = 20.5;      
dl = length*scale;  // length of the model dock in mm
// width of the dock (default: in feet}
width =  7.5;       
dw = width*scale;   // width of the model dock in mm
// height from bottom of deck to ground (default: in feet0
height = 3.1;         
dh = height*scale-scale/6;  // height of the model dock in mm

/* [add-on options, ramp, steps] */
// make 0 if you only want a ramp or steps, no dock
has_dock = 1; //[1,0]
// full printed base, set to 1 if more area is needed on the printbed for good adhesion
full_printed_base = 0; //[0,1]
fpb = full_printed_base;
//option for adding a ramp to one end ot the dock
/*[ramp options]*/
has_ramp = 0; //[0,1]
// length of the ramp in scale units (feet)
ramp_length = 15.5; //
rlen = ramp_length * scale;
ramp_width = width*scale;
// ramp width will be 1 over this value of the overall width 
// ramp has small guide boards along each side;
has_guide_boards = 1 ; //[1,0]
rhgb = has_guide_boards;
// ramp divisor- width of the ramp will be the width of the dock divided by this number
ramp_div = 1; //[1,1.5,2,2.5,3,4,5,6]
rw = ramp_width/ramp_div; //make it narrower by increasing integer denominator
// ramp position- back,center,front of width
ramp_position = "b"; // ["back","center","front"]
rp = ramp_position;
/*[step options]*/
// check to add steps, choose location below
has_steps = 0; //[0,1]
// step width in scale units
step_width = 3;
sw = step_width * scale;
// where steps are placed around the platform ("lc"->left center)
step_pos = "lc"; //["lf","lc","lb","rf","rc","rb",">F","-F","<F"]
sp = step_pos;

// deck board parameters, allows for visible grooves between boards in both axes
// adjusting the maximum board length controls the number of widthwise bays
// for a heavier deck use a small number, lighter deck larger number
/*[Advanced- deck board parameters]*/
// the longest board to be used in planking the deck - suggested range 8-16 feet
maximumBoardLength = 12.5;
maxbl = maximumBoardLength*scale*1.5;   // no larger than the longest possible board * 1.5, reasonble range:12-24
//minimum printable gap in mm 
minimum_gap = .10;  
mg = minimum_gap;
// width of boards on deck,  
// board width divisor- width will be the scale unit divided by this, 2 gives 1/2 of a foot (6") for HO scale
board_width_divisor = 2; //[1:8]
bw = scale/board_width_divisor;       
// thickness of boards on deck, default 2"
// board thickness divisor
board_thickness_divisor = 6; //[3:12]
bt = scale/board_thickness_divisor;       
// Post thickness
post_thickness_divisor = 2; //[1:4]
pt = scale/post_thickness_divisor;       // posts, default 6"x6" 

// boards always run across the width, which should <= the length
// having multiple boards lengths below for uneven spacing of grooves across the width

// nwbays is the number of bays across the width
nwbays = (dw<(maxbl/3)) ? 0 : (dw<maxbl/2) ? 1 : (dw<maxbl) ? 2 : 3;                  

mf = (dw<=maxbl/2) ? .5 : (dw<=maxbl) ? .67 : .75;  // if not narrow, divided boards 2/3,1/3, else single board
mf1 = (dw<=maxbl/2) ? 1 : (dw<=maxbl) ? .67 : 1.5;
mf2 = (dw>maxbl) ? .75 : 0;
bla = (nwbays > 0) ? (dw*mf)/nwbays : dw;      // shorter deck board length a in mm (feet times scale)
blb = (nwbays > 0) ? (dw*mf1)/nwbays: dw;      // shorter board length b in mm (feet times scale)
blc = (nwbays > 0) ? (dw*mf2)/nwbays : dw;
    
bays = ceil(dl/bla-scale/3);
inc = dl/(bays+1);

// risers data
rt = scale/2; //riser thickness 6"
rh = scale*.67;   //riser height 1 foot
//base data
bbt = scale/3; //base thickness 4"
bh = scale/2;   //riser height 6"

full_dock(); //renders all the parts

//individual modules for testing/troubleshooting
//deck();
//risers();
//posts();
//base();
// if has_ramp ramp();
 
module full_dock() {
  if (has_dock) deck(dl,dw,dh,bla,blb,blc);
  if (has_dock) risers();
  if (has_dock) posts();
  if (has_dock) base();
  if (has_ramp) ramp(rlen,rw);
  if (has_steps) steps(sw,sp
);
}

module deck(dl,dw,dh,bla,blb,blc) {  // creates the actual deck board by board
    brds = floor(dl/bw);
    brdwidth = (brds+1)*bw;
    xtra = brdwidth-dl;
    for ( i=[0:1:brds-1] ) { // create boards along the width
        if (nwbays>0) {
            if (i%2) {          // alternate length of gaps along the width
                translate([i*bw,0,dh-.01]) cube([bw-mg,bla-mg,bt]);
                translate([i*bw,bla,dh-.01]) cube([bw-mg,dw-bla-blc,bt]);
                translate([i*bw,dw-blc+mg,dh-.01]) cube([bw-mg,blc-mg,bt]);
            } else {
                translate([i*bw,0,dh-.01]) cube([bw-mg,(dw-blb)-mg,bt]);
                translate([i*bw,dw-blb,dh-.01]) cube([bw-mg,blb,bt]);
            }
        } else
        translate([i*bw,0,dh-.01]) cube([bw-mg,dw,bt]);
    }
    translate([brds*bw,0,dh-.01]) cube([bw-xtra,dw,bt]);  //fill in remaining space with less wide board
}

module risers() {
    // visible outside risers
    translate([0,0,dh-rh]) cube([dl,rt,rh]); // long under deck outside riser 1
    translate([0,dw-rt,dh-rh]) cube([dl,rt,rh]); // long under deck outside riser 2
    translate([0,0,dh-rh]) cube([rt,dw,rh]); // short under deck outside riser 1
    translate([dl-rt,0,dh-rh]) cube([rt,dw,rh]); // short under deck outside riser 2
    // interior lengthwise risers
    for ( i=[1:1:nwbays] ) { // create long boards across the width
            translate([0,i*bla-scale/3,dh-rh]) cube([dl,rt,rh]);
        }
    // interior widthwise risers

    for ( i=[1:1:bays] ) { // create widthlong boards along the length
            translate([i*inc,0,dh-rh]) cube([rt,dw,rh]);
        }
}

module posts() {
   
    adjp = inc;
    oppp = dh-rh-bh;
    anglep = atan(adjp/oppp);
    xblen1 = (inc-pt)/sin(anglep);   // hypotenuse length of shorter bay
    xblen = (bays>0) ? inc/sin(anglep) : xblen1;   // hypotenuse length of normal bay
    adjw = bla-scale/3;
    anglew = atan(adjw/oppp);
    xblenw = adjw/sin(anglew); 
    for ( i=[1:1:bays] ) {        // internal posts
        for ( j=[1:1:nwbays] ) { // create internal posts along the length
            translate([i*inc,j*(bla)-scale/3,0]) cube([pt,pt,dh]);
        }
    }
    for ( i=[1:1:(bays-1)] ) { // posts along x axis
        translate([i*inc,bt,0]) cube([pt,pt,dh]);
        translate([i*inc+pt/5,0,bh*1.5]) rotate([0,anglep,0]) cube([bh*.75,bt,xblen*1.00]);        
        }
    translate([bays*inc,bt,0]) cube([pt,pt,dh]);    //last post before corner
    translate([bays*inc,0,bh*1.5]) rotate([0,anglep,0]) cube([bh*.75,bt,xblen1]); // last crossbar
    for ( j=[1:1:nwbays] ) { // inset posts/crossbars along the outside widths
        translate([dl-pt-bt,j*(bla)-scale/3,0]) cube([pt,pt,dh]);
        translate([dl-bt,(j+1)*(bla)-scale/4,bh*.75]) rotate([anglew,0,0]) cube([bt,bh*.75,xblenw*1.1]);
        translate([bt,j*(bla)-scale/3,0]) cube([pt,pt,dh]);
        translate([0,(j+1)*(bla)-scale/4,bh*.75]) rotate([anglew,0,0]) cube([bt,bh*.75,xblenw*1.1]);
        }
    for ( i=[1:1:bays-1] ) { // visible posts/crossbars away from x axis
        translate([i*inc,dw-pt-bt,0]) cube([pt,pt,dh]);
        translate([i*inc+pt/5,dw-bt,bh*1.5]) rotate([0,anglep,0]) cube([bh*.75,bt,xblen]);
        }
    translate([bays*inc,dw-pt-bt,0]) cube([pt,pt,dh]); // final post before corner
    translate([bays*inc,dw-bt,bh*1.5]) rotate([0,anglep,0]) cube([bh*.75,bt,xblen1]);  // final crossbar

    translate([bt, bt,0]) cube([pt,pt,dh]);       //visible corner post so inset
    translate([bt,dw-pt-bt,0]) cube([pt,pt,dh]);       //visible corner post so inset
    translate([dl-pt-bt,dw-pt-bt,0]) cube([pt,pt,dh]); // visible corner post so inset
    translate([dl-pt-bt,bt,0]) cube([pt,pt,dh]); // visible corner post so inset
    
    // angled crossbars at ends
    translate([0,bla*.95,bh*.75]) rotate([anglew,0,0]) cube([bt,bh*.75,xblenw*1.00]); //front width near origin
    translate([pt/2,0,bh*1.5]) rotate([0,anglep,0]) cube([bh*.75,bt,xblen]);  //front length near origin
    translate([dl-bt,bla*.95,bh*.75]) rotate([anglew,0,0]) cube([bt,bh*.75,xblenw*1.0]); //back width
    translate([pt/2,dw-bt,bh*1.5]) rotate([0,anglep,0]) cube([bh*.75,bt,xblen]);  //back length
}

module base() {
    if ( fpb ) {
        cube([dl,dw,bt]);
        }
    translate([0,0,0]) cube([dl,bbt,bh]); // long under deck outside riser 1
    translate([0,dw-bbt,0]) cube([dl,bbt,bh]); // long under deck outside riser 2
    translate([0,0,0]) cube([bbt,dw,bh]); // short under deck outside riser 1
    translate([dl-bbt,0,0]) cube([bbt,dw,bh]); // short under deck outside riser 2
    // interior lengthwise risers
    for ( i=[1:1:nwbays] ) { // create boards along the length
            translate([0,i*bla-scale/3,0]) cube([dl,bbt,bh]);
        }
    // interior widthwise risers
    for ( i=[1:1:bays] ) { // create boards along the length
            translate([i*inc,0,0]) cube([bbt,dw,bh]);
        }
}

module ramp(rlen,rw) {
    rangle = atan((dh+bt)/(rlen));
    echo("Ramp angle: ",rangle,"deg.");
    if (rangle>16.5) echo("Warning: Ramp angle is steeper than 16.5 deg. Increase of ramp length recommended.");
    rl = (dh+bt)/sin(rangle);    // length of deck (hypotenuse)
    shift1 = (dh+bt)*tan(rangle);       // amount to move ramp so it touches deck 
    innerl = (dh+bt-bw*2)/tan(rangle);
    yt = (rp[0]=="f") ? dw-rw : (rp[0]=="c") ? dw/2-rw/2 : 0;
    psub = tan(rangle)*pt*.6;  // post height increment

    //ramp deck
    bla = (rw<=blb) ? rw : bla;
    blb = (rw<=blb) ? rw : blb;
    blc = (rw<=blb) ? rw : blc;
    difference() {
        translate([-rlen,yt,-bt]) rotate([0,360-rangle,0]) deck(rl,rw,0,bla,blb,blc);
        translate([-rlen-bw,yt-bt,-bw]) cube([10,rw+2*bt,bw]);
    }
    if (rhgb) {     //if true, guide boards on each side of ramp
        translate([-rlen,yt,0]) rotate([0,360-rangle,0]) cube([rl,bt,bt]); // side guide
        translate([-rlen,rw-bt,0]) rotate([0,360-rangle,0]) cube([rl,bt,bt]); // side guide
        }
    // basic ramp supports and posts
    for (i=[0:1:2]) {
        // triangular cutouts form the main support
        translate([0,yt+(i*(rw-(2*bt))/2)+1.5*bt,0]) rotate([90,0,0]) linear_extrude(height=bt) 
            polygon(points =[[0,0],[0,dh],[-rlen,0],[0,bw],[0,dh-bw],[-innerl,bw]], 
            paths=[[0,1,2],[3,4,5]]);

        //support posts at end
        translate([-bt,yt+(i*(rw-(3+bt))/2)+1.5*bt,0]) cube([pt*.33,pt,dh-psub]);  // posts part1 near dock
        translate([-bt-pt*.33,yt+(i*(rw-(3+bt))/2)+1.5*bt,0]) cube([pt*.34,pt,dh-psub]);  // posts part2 near dock
        translate([-bt-pt*.67,yt+(i*(rw-(3+bt))/2)+1.5*bt,0]) cube([pt*.33,pt,dh-psub]);  // posts part3 near dock

        //support posts in middle
        np = (rlen < (bla*2)) ? 1 : (rlen < bla*3) ? 2 : 3;
        pof = (np==1) ? .33 : (np==2) ? .20 : .17; 
        for ( j=[1:1:np ]) {
            ph = tan(rangle)*(rlen*(1-(pof*j)))*.90;
            translate([(-rlen*pof*j)-pt,yt+(i*(rw-(3+bt))/2)+1.5*bt,0]) cube([pt*.33,pt,ph-psub]); //mid post p1
            translate([(-rlen*pof*j)-pt*1.33,yt+(i*(rw-(3+bt))/2)+1.5*bt,0]) cube([pt*.34,pt,ph-psub*2]); //mid post p2
            translate([(-rlen*pof*j)-pt*1.67,yt+(i*(rw-(3+bt))/2)+1.5*bt,0]) cube([pt*.33,pt,ph-psub*3]); //mid post p3
            translate([(-rlen*pof*j)-bt-pt/2,yt+bt,0]) cube([bt,rw-bt*2,bw]);
            }
        //end crosspiece
        translate([-bt,yt+bt,0]) cube([bt,rw-bt*2,bw]);   
    }
}

module steps(sw,sp) {
    sd = scale; // 12 inch deep stairs
    risers = round(dh/(scale*.75)); // find @num of 9 inch high risers
    sbh = (dh)/risers;
    xt = (sp[0]=="l") ? 0 : (sp[0]=="r") ? -dl : dw-dl;
    yt = (sp[1]=="f") ? dw-sw*1.25 : (sp[1]=="c") ? dw/2-sw/2 :(sp[1]=="b") ? bt : 
        (sp[0]==">") ? -bt-sw : (sp[0]=="-")? -dl/2-sw/2 : -dl+bt;
    adj = (sp[0]=="l") ? 0 : (sp[0]=="r") ? 1 : 0;
    rot = (sp[0]=="l") ? 0 : (sp[0]=="r") ? 180 : 90;

    rotate([0,0,rot]) translate([xt,yt,0]) {
        for (i = [1:1:risers-1]) {
            translate([dl,bt-(dw*adj),(i-1)*sbh]) cube([(risers-i)*scale,bt,sbh]);
            translate([dl,sw-bt-(dw*adj),(i-1)*sbh]) cube([(risers-i)*scale,bt,sbh]);
            translate([(risers-i-1)*scale+dl,-(dw*adj),(i)*sbh]) cube([scale,sw,bt]);
        }
        translate([dl,-(dw*adj),0]) cube([scale*(risers-1),sw,bt]);
    }
}

/*
difference() {
        union() {
            translate([-rlen,bt,0]) cube([rlen*.99,bt,dh+bt*.8]);
            translate([-rlen,dw-2*bt,0]) cube([rlen,bt,dh+bt]);
            }
        translate([-rlen,0,0]) rotate([0,360-rangle,0]) cube([rlen*1.25,dw,dh+bt]);
        translate([-rlen,0,-dh]) cube([rlen,dw,dh]);
        translate([0,0,0]) cube([rlen*.25,dw,dh+bt]);
        }
*/



