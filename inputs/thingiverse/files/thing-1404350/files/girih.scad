// mathgrrl and larum 3D Girih tiles

/////////////////////////////////////////////////////////////////////
// facts

// https://en.wikipedia.org/wiki/Girih
// https://en.wikipedia.org/wiki/Girih_tiles
// five tiles: decagon, elongated hexagon, bow tie, rhombus, pentagon
// all sides the same length
// all angles multiples of 36 degrees (pi/5)
// each has unique strapwork pattern
// except decagon has two possible strapwork patterns
// strapwork always meets edges at 54 degrees (3pi/10)

// SXSW SIZES
// 40,2,2,3,1.5,5,1,2,.5,1

////////////////////////////////////////////////////////
// user-defined parameters

/* [Type] */

// Choose a tile shape
shape = "HEX"; //[PEN:Pentagon,DEC:Decagon,BOW:Bowtie,RHO:Rhombus,HEX:Irregular Hexagon,SPECIAL:Cross-Tile Mosaic Pieces]
// Choose tile, strapwork, or mosaic
kind = "FULLSTRIPES"; //[TILE:Plain Tile,ETCH:Etched Tile,LINES:Strapwork,STRIPES:Fancy Strapwork,FULLPLAIN:Tile with Strapwork,FULLSTRIPES:Tile with Fancy Strapwork,MOSAIC:Mosaic Piece(s)

/* [Size] */

// Length of tile side
sideLength = 40; 

// Height of tile base
tileHeight = 2;

// Height of plain strapwork
strapHeight = 2;

// Additional height for fancy strapwork
ridgeHeight = 3;

// Thickness of mosaic pieces
mosaicHeight = 1.5;

/* [Style] */

// Thickness of plain strapwork
strapThick = 5; 

// Thickenss of fancy strapwork stripes
ridgeThick = 1;

// Amount of strapwork fanciness
ridgeNumber = 2; //[2,3]

/* [Tolerance] */

// Clearance between etching, strapwork, and mosaic pieces
clearance = .5; 

// Depth of tile etching
embed = 1; 

////////////////////////////////////////////////////////
// invisible parameters

s = sideLength*1; // shorter name :)

cover = 6*1; // for cuts to go far enough out

ridgeGap = (strapThick-3*ridgeThick)/2; 

m = s - strapThick; // magic number for scaling

//preview[view:south, tilt:top]

////////////////////////////////////////////////////////
// renders

makeThing();

////////////////////////////////////////////////////////
// module for picking the render

module makeThing(){
    
    // PENTAGON PIECES
    if (shape=="PEN" && kind=="TILE") PENtile();
    if (shape=="PEN" && kind=="ETCH") PENetch();
    if (shape=="PEN" && kind=="LINES") PENlines();
    if (shape=="PEN" && kind=="STRIPES") PENstripes();
    if (shape=="PEN" && kind=="FULLPLAIN") PENfullplain();
    if (shape=="PEN" && kind=="FULLSTRIPES") PENfullstripes();
    if (shape=="PEN" && kind=="MOSAIC") mosaicPEN();
        
    // DECAGON PIECES
    if (shape=="DEC" && kind=="TILE") DECtile();
    if (shape=="DEC" && kind=="ETCH") DECetch();
    if (shape=="DEC" && kind=="LINES") DEClines();
    if (shape=="DEC" && kind=="STRIPES") DECstripes();
    if (shape=="DEC" && kind=="FULLPLAIN") DECfullplain();
    if (shape=="DEC" && kind=="FULLSTRIPES") DECfullstripes();
    if (shape=="DEC" && kind=="MOSAIC") {mosaicDEC(); mosaicDEC2();}
        
    // BOWTIE PIECES
    if (shape=="BOW" && kind=="TILE") BOWtile();
    if (shape=="BOW" && kind=="ETCH") BOWetch();
    if (shape=="BOW" && kind=="LINES") BOWlines();
    if (shape=="BOW" && kind=="STRIPES") BOWstripes();
    if (shape=="BOW" && kind=="FULLPLAIN") BOWfullplain();
    if (shape=="BOW" && kind=="FULLSTRIPES") BOWfullstripes();
    if (shape=="BOW" && kind=="MOSAIC") mosaicBOW();
        
    // RHOMBUS PIECES
    if (shape=="RHO" && kind=="TILE") RHOtile();
    if (shape=="RHO" && kind=="ETCH") RHOetch();
    if (shape=="RHO" && kind=="LINES") RHOlines();
    if (shape=="RHO" && kind=="STRIPES") RHOstripes();
    if (shape=="RHO" && kind=="FULLPLAIN") RHOfullplain();
    if (shape=="RHO" && kind=="FULLSTRIPES") RHOfullstripes();
    if (shape=="RHO" && kind=="MOSAIC") mosaicRHO();
        
    // HEXAGON PIECES
    if (shape=="HEX" && kind=="TILE") HEXtile();
    if (shape=="HEX" && kind=="ETCH") HEXetch();
    if (shape=="HEX" && kind=="LINES") HEXlines();
    if (shape=="HEX" && kind=="STRIPES") HEXstripes();
    if (shape=="HEX" && kind=="FULLPLAIN") HEXfullplain();
    if (shape=="HEX" && kind=="FULLSTRIPES") HEXfullstripes();
    if (shape=="HEX" && kind=="MOSAIC") mosaicHEX();
        
    // CROSS-TILE MOSAIC PIECES
    if (shape=="SPECIAL"){
        translate([1.4*s,-.45*s,0]) mosaicYYVV();
        translate([1.2*s,.5*s,0]) mosaicYVYV();
        translate([.35*s,.9*s,0]) mosaicYYYYY();
        translate([.2*s,0,0]) mosaicYYXYY();
    }
}

////////////////////////////////////////////////////////
// modules for multi-tile mosaic pieces

// YYVV mosaic piece
// in other words, PEN PEN RHO RHO
module mosaicYYVV(){
    clear = .25*clearance;
    color("gray")
    intersection(){
        // assemble the shape
        union(){
            color("orange")
                translate([-.01,0,0])
                difference(){
                    PENcomplement(clear);
                    mosaicPEN(clear);
                }
            color("green")
                translate(2*PENmids[2])
                rotate(180)
                difference(){
                    PENcomplement(clear);
                    mosaicPEN(clear);
                }
            color("red")
                translate([-8.6*s/40,46.1*s/40,0])
                rotate(36+18)
                difference(){
                    RHOcomplement(clear);
                    mosaicRHO(clear);
                }
            color("violet")
                translate([(-8.5-38)*s/40,46.1*s/40,0])
                mirror([0,1])
                rotate(36+18)
                difference(){
                    RHOcomplement(clear);
                    mosaicRHO(clear);
                }
        }
        // intersect to get just the interior part
        translate([-27*s/40,20*s/40,0])
                cylinder(r=.45*m*40/35);  
    }
}
// YVYV mosaic piece
// in other words, PEN RHO PEN RHO
module mosaicYVYV(){
    clear = .25*clearance;
    color("gray")
    intersection(){
        // assemble the shape
        union(){
            color("orange")
                difference(){
                    PENcomplement(clear);
                    mosaicPEN(clear);
                }
            color("green")
                translate(2*PENmids[2])
                translate([0,s,0])
                rotate(180)
                difference(){
                    PENcomplement(clear);
                    mosaicPEN(clear);
                }
            color("red")
                translate([-8.6*s/40,46.1*s/40,0])
                rotate(36+18)
                difference(){
                    RHOcomplement(clear);
                    mosaicRHO(clear);
                }
            color("violet")
                translate([(-8.5-38)*s/40,33.84*s/40,0])
                translate([0,-s,0])
                mirror([0,1])
                rotate(-36-18)
                difference(){
                    RHOcomplement(clear);
                    mosaicRHO(clear);
                }
        }
        // intersect to get just the interior part
        translate([-27*s/40,20*s/40,0])
                cylinder(r=.45*m*40/35);  
    }
}

// YYYYY mosaic piece
// in other words, RHO RHO RHO RHO RHO
module mosaicYYYYY(){
    clear = .25*clearance;
    color("gray")
    intersection(){
        // assemble the shape
        color("violet")
        union(){
            for (i=[0:5]){
                translate([-s*sin(54),0,0])
                rotate(72*i)
                translate([s*sin(54),0,0])
                difference(){
                    RHOcomplement(clear);
                    mosaicRHO(clear);
                }
            }
        }
        // intersect to get just the interior part
        translate([-32.5*s/40,0,0])
                cylinder(r=.45*m*40/35);  
    }
}

// YYXYY mosaic piece
// in other words, RHO RHO on both ends with BOW middle
module mosaicYYXYY(){
    clear = .25*clearance;
    color("gray")
    mosaicYYYYY();
    translate([-49.5*(s/40),0,0]) // total hack
    //translate([1.4*(BOWmids[2][0]+(5-strapThick*40/s)),0,0]) 
        rotate(180) mosaicYYYYY();
}

////////////////////////////////////////////////////////
// modules for interior mosaic pieces
// customizable but may not work with wide-variety customization

// inside of pentagon piece
module mosaicPEN(clear=.75*clearance){
    color("gray")
    difference(){
        PENcomplement(clear);
        // take out the extra
        translate([0,0,-1]) 
        linear_extrude(mosaicHeight+2) 
            union(){
                for (i=[0:4]){
                    rotate(72*i,[0,0,1])
                        translate([-.82*m,.59*m,0]) 
                            rotate(9,[0,0,1]) 
                                circle(r=s/2,$fn=8);
                }
        }
    }
}

// large inside of decagon piece
module mosaicDEC(clear=.75*clearance){
    color("gray")
    difference(){
        DECcomplement(clear);
        // take out the extra
        translate([0,0,-1]) 
        linear_extrude(mosaicHeight+2) 
            union(){
                for (i=[0:9]){
                    rotate(36*i,[0,0,1])
                        rotate(-2,[0,0,1])
                        translate([-1.4*m,1.7*m,0]) 
                            rotate(-12,[0,0,1]) 
                                circle(r=s,$fn=10);
                }
        }
    }
}


// small inside of decagon piece
module mosaicDEC2(clear=.75*clearance){
    color("gray")
    difference(){
        DECcomplement(clear);
        // take out the extra
        mosaicDEC(clear);
        translate([0,0,-1]) 
        linear_extrude(mosaicHeight+2) 
            union(){
                for (i=[0:9]){
                    rotate(36*i,[0,0,1])
                        translate([-1.25*m,1.6*m,0]) 
                            rotate(-26,[0,0,1]) 
                                square(m);
                }
        }
    }
}

module mosaicBOW(clear=.75*clearance){
    color("gray")
    difference(){
        BOWcomplement(clear);
        // take out the extra
        translate([0,0,-1]) 
        linear_extrude(mosaicHeight+2) 
            union(){
                translate([-.5*(.69*m+2*strapThick),-.5*(.69*m+2*strapThick)]) 
                    square(.69*m+2*strapThick);
                translate([-1.15*m,-.1*m])
                    rotate(36) 
                        square(.86*s);
                mirror([0,1])
                    translate([-1.15*m,-.1*m])
                        rotate(36) 
                            square(.86*s);
                mirror([1,0])
                    translate([-1.15*m,-.1*m])
                        rotate(36) 
                            square(.86*s);
                mirror([1,0]) mirror([0,1])
                    translate([-1.15*m,-.1*m])
                        rotate(36) 
                            square(.86*s);
            }
    }
}

// inside of rhombus piece
module mosaicRHO(clear=.75*clearance){
    color("gray")
    difference(){
        RHOcomplement(clear);
        // take out the extra
        translate([0,0,-1]) 
        linear_extrude(mosaicHeight+2) 
            union(){
                translate([0,.7*m]) 
                    rotate(-10) circle(r=s/2,$fn=9);
                mirror([0,1])
                    translate([0,.7*m]) 
                        rotate(-10) circle(r=s/2,$fn=9);
                translate([-.81*m,0])
                    square(.7*s,center=true);
                translate([.81*m,0])
                    square(.7*s,center=true);
            }
        
    }
}

// inside of hexagon piece
module mosaicHEX(clear=.75*clearance){
    color("gray")
    difference(){
        HEXcomplement(clear);
        // take out the extra
        translate([0,0,-1]) 
        linear_extrude(mosaicHeight+2) 
            union(){
                translate([-.55*m,.61*m,0]) 
                    circle(r=s/2,$fn=5);
                mirror([0,1]) 
                    translate([-.55*m,.61*m,0]) 
                        circle(r=s/2,$fn=5);
                mirror([1,0]) 
                    translate([-.55*m,.61*m,0]) 
                        circle(r=s/2,$fn=5);
                mirror([0,1]) 
                    mirror([1,0]) 
                        translate([-.55*m,.61*m,0]) 
                            circle(r=s/2,$fn=5);
                translate([1.42*m,.0,0]) 
                    circle(r=s/2,$fn=5);
                mirror([1,0])
                    translate([1.42*m,.0,0]) 
                        circle(r=s/2,$fn=5);
        }
    }
}

////////////////////////////////////////////////////////
// general modules

module strapCut(A,B,h){
    hull(){
        translate(go(A,B,-cover)) 
            translate(h*normal(A,B))
                cylinder(r=ridgeThick/2,h=ridgeHeight,$fn=48);
        translate(go(B,A,-cover)) 
            translate(h*normal(A,B))
                cylinder(r=ridgeThick/2,h=ridgeHeight,$fn=48);
    }
}

////////////////////////////////////////////////////////
// definitions and modules for PEN tiles
// regular pentagon

// calculate pentagon radius given side length
PENradius = (sin(54)/sin(72))*s; 

// list of pentagon vertex points
PENpoints = [for (i=[0:4]) PENradius*[cos(i*360/5),sin(i*360/5)]];
    
// extruded plain pentagon tile
module PENtile(){
    color("violet")
    linear_extrude(height=tileHeight)
    polygon(points=PENpoints, paths=[[for (i=[0:4]) i]]);
}

// list of pentagon midpoints
PENmids = [for (i=[0:4]) move(PENpoints[i%5],PENpoints[(i+1)%5],.5)];
    
// inside points for the pentagon strapwork
// used trig to calculate that these points are halfway in
PENinside = [for (i=[0:4]) (PENradius/2)*[cos(i*360/5),sin(i*360/5)]];

// path of the pentagon strapwork
// alternates between vertex points and interior points
PENpath = [for (i=[0:9]) 
    i%2==0 ?
        // outside points of star for even i
        move(PENpoints[(i/2)%5],PENpoints[(i/2+1)%5],.5) :
        // inside points of star for odd i
        PENinside[((i+1)/2)%5]
];

// 2D polygon whose boundary is the pentagon strapwork line
module PENshape(){
    polygon(points=PENpath, paths=[[for (i=[0:9]) i]]);
}
    
// extruded and thickened pentagon strapwork line 
module PENstrap(strap=strapThick){
    // default is strapThick
    // but can specify others for clearance
    intersection(){
        linear_extrude(strapHeight)
            difference(){
                offset(delta=strap/2) PENshape();
                offset(delta=-strap/2) PENshape();
            }
        scale([1,1,strapHeight/tileHeight]) 
            PENtile();
    }
}

// pentagon tile with enlarged strapwork etching
module PENetch(){
    color("violet")
    difference(){
        PENtile();
        translate([0,0,tileHeight-embed])
            PENstrap(strapThick+clearance);
    }
}

// pentagon strapwork alone
module PENlines(){
    color("white") 
    PENstrap(strapThick-.5*clearance);
}

// one piece of the pentagon stripes
module PENchunk(){
    // first pair, with end cut
    intersection(){
        union(){
            strapCut(PENmids[0],PENinside[1],ridgeGap+ridgeThick);
            if (ridgeNumber==3) 
                strapCut(PENmids[0],PENinside[1],0);
            strapCut(PENmids[0],PENinside[1],-1*(ridgeGap+ridgeThick));
        }
        linear_extrude(strapHeight+ridgeHeight+1)
        polygon(points=[
                    go(PENmids[0],[0,0],4.3*strapThick/5),
                    go(PENmids[0],PENpoints[1],3.1*strapThick/5),
                    PENpoints[1],
                    [0,0]],
                paths=[[0,1,2,3]]);
    }
    // second pair, no cut
    intersection(){
        union(){
            strapCut(PENinside[1],PENmids[1],ridgeGap+ridgeThick);
            if (ridgeNumber==3) 
                strapCut(PENinside[1],PENmids[1],0);
            strapCut(PENinside[1],PENmids[1],-1*(ridgeGap+ridgeThick));
        }
        linear_extrude(strapHeight+ridgeHeight+1)
        polygon(points=[
                    PENpoints[1],
                    PENpoints[2],
                    [0,0]],
                paths=[[0,1,2]]);
    }
}

// all of the pentagon stripes
module PENstripes(){
    color("white")
    union(){
        PENlines();
        translate([0,0,strapHeight])
            for (i=[0:4]) 
                rotate(i*360/5,[0,0,1]) PENchunk();
    }
}

// pentagon tile with plain strapwork attached
module PENfullplain(){
    union(){
        color("violet") PENtile();
        translate([0,0,tileHeight-embed])
            color("white") PENlines();
    }
}

// pentagon tile with striped strapwork attached
module PENfullstripes(){
    union(){
        color("violet") PENtile();
        translate([0,0,tileHeight-embed])
            color("white") PENstripes();
    }
}

// pentagon tile with lines + offset clearance removed
module PENcomplement(clear=.75*clearance){
    difference(){
        // pentagon tile
        linear_extrude(mosaicHeight)
            projection([0,0,1])
                PENtile();
        // remove lines with clearance
        translate([0,0,-1]) 
            linear_extrude(mosaicHeight+2) 
            offset(delta=clear) 
            projection([0,0,1]) 
                PENlines();
    }
}

////////////////////////////////////////////////////////
// definitions and modules for DEC tiles
// regular decagon

// calculate decagon radius given side length
DECradius = (sin(72)/sin(36))*s;

// list of decagon vertex points
DECpoints = [for (i=[0:9]) DECradius*[cos(i*360/10),sin(i*360/10)]];
    
// extruded plain decagon tile
module DECtile(){
    color("lightgreen")
    linear_extrude(height=tileHeight)
    polygon(points=DECpoints, paths=[[for (i=[0:9]) i]]);
}

// list of decagon midpoints
DECmids = [for (i=[0:9]) move(DECpoints[i%10],DECpoints[(i+1)%10],.5)];

// inside points for the decagon strapwork
// CHECK LATER this might break slightly upon scaling
DECinside = 
    [for (i=[0:9]) 
        go( DECmids[i%10],
            DECmids[i%10]-normal(DECpoints[i%10],DECpoints[(i+1)%10]),
            23.49*s/40)];

// path of the decagon strapwork
// alternates between vertex points and interior points
DECpathA = [for (i=[0:9]) 
    i%2==0 ?
        // outside points of star for even i
        DECmids[i] :
        // inside points of star for odd i
        DECinside[i]
];

// 2D polygon whose boundary is the decagon strapwork line
module DECshape(){
    polygon(points=DECpathA, paths=[[for (i=[0:9]) i]]);
}
    
// extruded and thickened decagon strapwork line 
module DECstrap(strap=strapThick){
    // default is strapThick
    // but can specify others for clearance
    intersection(){
        linear_extrude(height=strapHeight)
            difference(){
                offset(delta=strap/2) DECshape();
                offset(delta=-strap/2) DECshape();
            }
        scale([1,1,strapHeight/tileHeight]) 
            DECtile();
    }
}

// decagon tile with enlarged strapwork etching
module DECetch(){
    color("lightgreen")
    difference(){
        DECtile();
        translate([0,0,tileHeight-embed])
            DECstrap(strapThick+clearance);
        rotate(36,[0,0,1])
            translate([0,0,tileHeight-embed])
                DECstrap(strapThick+clearance);
    }
}

// decagon strapwork alone
module DEClines(){
    color("white")
    union(){
        DECstrap(strapThick-.5*clearance);
        rotate(36,[0,0,1])
            DECstrap(strapThick-.5*clearance);
    }
}

// first piece of the decagon stripes
// 0th mid with cut, overcrossing, end at 1st mid
module DECchunkA1(){
    intersection(){
        union(){
            strapCut(DECmids[0],DECinside[1],ridgeGap+ridgeThick);
            if (ridgeNumber==3) 
                strapCut(DECmids[0],DECinside[1],0);
            strapCut(DECmids[0],DECinside[1],-1*(ridgeGap+ridgeThick));
        }
        linear_extrude(strapHeight+ridgeHeight+1)
        polygon(points=[
                    go( DECmids[0],
                        DECmids[0]-normal(DECpoints[0],DECpoints[1]),
                        4.1*strapThick/5),
                    go(DECmids[0],DECpoints[1],3*strapThick/5),
                    DECmids[1],
                    [0,0]],
                paths=[[0,1,2,3]]);
    }
}

// second piece of the decagon stripes
// 1st mid, before undercrossing, pointed at 2nd mid
// CHECK LATER this may break on scaling
module DECchunkA2(){
    intersection(){
        union(){
            strapCut(DECinside[1],DECmids[2],ridgeGap+ridgeThick);
            if (ridgeNumber==3) 
                strapCut(DECinside[1],DECmids[2],0);
            strapCut(DECinside[1],DECmids[2],-1*(ridgeGap+ridgeThick));
        }
        linear_extrude(strapHeight+ridgeHeight+1)
        polygon(points=[
                    [0,0],
                    go( DECmids[1],
                        DECmids[1]-normal(DECpoints[1],DECpoints[2]),
                        4.1*strapThick/5),
                    go([0,0],DECmids[2],
                        35.57*DECradius/64.72 // why not 28.45? see below
                        -(.5*strapThick/DECradius)*(sin(72)/sin(36))*s+2.5)],
                paths=[[0,1,2,3]]);
    }
}

// third piece of the decagon stripes
// 1st mid, after undercrossing, ending at 2nd mid with no cut
module DECchunkA3(){
    intersection(){
        union(){
            strapCut(DECinside[1],DECmids[2],ridgeGap+ridgeThick);
            if (ridgeNumber==3) 
                strapCut(DECinside[1],DECmids[2],0);
            strapCut(DECinside[1],DECmids[2],-1*(ridgeGap+ridgeThick));
        }
        linear_extrude(strapHeight+ridgeHeight+1)
        polygon(points=[
                    go( [0,0],DECmids[2],
                        35.57*DECradius/64.72
                        +(.5*strapThick/DECradius)*(sin(72)/sin(36))*s+2.5),
                    go(DECmids[1],DECpoints[2],2.7*strapThick/5),
                    DECpoints[2],
                    DECpoints[3]],
                paths=[[0,1,2,3]]);
    }
}

// all of the decagon stripes
module DECstripes(){
    color("white")
    union(){
        DEClines();
        translate([0,0,strapHeight])
            for (i=[0:9]){
                rotate(36*i,[0,0,1]) DECchunkA1();
                rotate(36*i,[0,0,1]) DECchunkA2();
                rotate(36*i,[0,0,1]) DECchunkA3();
            }
    }
}
            
// decagon tile with strapwork attached
// 5-fold symmetry version
module DECfullplain(){
    union(){
        color("lightgreen") DECtile();
        translate([0,0,tileHeight-embed])
            color("white") DEClines();
        rotate(36,[0,0,1])
            translate([0,0,tileHeight-embed])
                color("white") DEClines();
    }
}

// decagon tile with striped strapwork attached
module DECfullstripes(){
    union(){
        color("lightgreen") DECtile();
        translate([0,0,tileHeight-embed])
            color("white") DECstripes();
    }
}

// decagon tile with lines + offset clearance removed
module DECcomplement(clear=.75*clearance){
    difference(){
        // pentagon tile
        linear_extrude(mosaicHeight)
            projection([0,0,1])
                DECtile();
        // remove lines with clearance
        translate([0,0,-1]) 
            linear_extrude(mosaicHeight+2) 
            offset(delta=clear) 
            projection([0,0,1]) 
                DEClines();
    }
}

////////////////////////////////////////////////////////
// definitions and modules for BOW tiles
// a certain irregular non-convex hexagon

// calculate bowtie radius given side length
// bowtie positioned vertically
// "radius" from center to right edge
BOWradius = s*sin(72); 

// list of bowtie vertex points
BOWpoints = [[BOWradius,s/2],[0,(s/2)-s*sin(18)],
             [-BOWradius,s/2],[-BOWradius,-s/2],
             [0,-((s/2)-s*sin(18))],[BOWradius,-s/2]];
    
// extruded plain bowtie tile
module BOWtile(){
    color("skyblue")
    linear_extrude(height=tileHeight)
    polygon(points=BOWpoints, paths=[[for (i=[0:5]) i]]);
}

// list of bowtie midpoints
BOWmids = [for (i=[0:5]) move(BOWpoints[i%6],BOWpoints[(i+1)%6],.5)];

// inside points for the bowtie strapwork
// used trig to calculate the interior point coordinates
BOWinside = [[BOWradius-(s/2)*sin(72)/sin(54),0],
             [-(BOWradius-(s/2)*sin(72)/sin(54)),0]];

// paths of the bowtie strapwork
// alternates between vertex points and interior points
BOWpath = [[BOWradius,0],
           BOWmids[0],
           BOWinside[0],
           BOWmids[4]
          ];

// 2D polygon whose boundary is the bowtie strapwork line
module BOWshape(){
    polygon(points=BOWpath, paths=[[0,1,2,3]]);
    mirror([1,0,0]) polygon(points=BOWpath, paths=[[0,1,2,3]]);
}
    
// extruded and thickened bowtie strapwork line 
module BOWstrap(strap=strapThick){
    // default is strapThick
    // but can specify others for clearance
    intersection(){
        linear_extrude(strapHeight)
            difference(){
                offset(delta=strap/2) BOWshape();
                offset(delta=-strap/2) BOWshape();
            }
        scale([1,1,strapHeight/tileHeight]) 
            BOWtile();
    }
}

// bowtie tile with enlarged strapwork etching
module BOWetch(){
    difference(){
    color("skyblue") BOWtile();
        translate([0,0,tileHeight-embed])
            color("white") BOWstrap(strapThick+clearance);
    }
}

// bowtie strapwork alone
module BOWlines(){
    color("white")
    BOWstrap(strapThick-.5*clearance);
}

// first piece of the bowtie stripes
// starting position to top right midpoint, with cut
module BOWchunk1(){
    intersection(){
        union(){
            strapCut(BOWmids[5],BOWmids[0],ridgeGap+ridgeThick);
            if (ridgeNumber==3) 
                strapCut(BOWmids[5],BOWmids[0],0);
            strapCut(BOWmids[5],BOWmids[0],-1*(ridgeGap+ridgeThick));
        }
        linear_extrude(strapHeight+ridgeHeight+1)
        polygon(points=[
                    go(BOWmids[5],[0,0],4.3*strapThick/5),
                    go(BOWmids[5],BOWpoints[0],3.1*strapThick/5),
                    BOWpoints[0],
                    BOWpoints[1]],
                paths=[[0,1,2,3]]);
    }
}

// second piece of the bowtie stripes
// top right midpoint to inside, with cut
module BOWchunk2(){
    intersection(){
        union(){
            strapCut(BOWmids[0],BOWinside[0],ridgeGap+ridgeThick);
            if (ridgeNumber==3) 
                strapCut(BOWmids[0],BOWinside[0],0);
            strapCut(BOWmids[0],BOWinside[0],-1*(ridgeGap+ridgeThick));
        }
        linear_extrude(strapHeight+ridgeHeight+1)
        polygon(points=[
                    go( BOWmids[0],
                        BOWmids[0]-normal(BOWpoints[0],BOWpoints[1]),
                        4.3*strapThick/5),
                    go(BOWmids[0],BOWpoints[1],3.1*strapThick/5),
                    [0,0],
                    BOWmids[5]],
                paths=[[0,1,2,3]]);
    }
}

// third piece of the bowtie stripes
// inside to bottom, no cut
module BOWchunk3(){
    intersection(){
        union(){
            strapCut(BOWinside[0],BOWmids[4],ridgeGap+ridgeThick);
            if (ridgeNumber==3) 
                strapCut(BOWinside[0],BOWmids[4],0);
            strapCut(BOWinside[0],BOWmids[4],-1*(ridgeGap+ridgeThick));
        }
        linear_extrude(strapHeight+ridgeHeight+1)
        polygon(points=[
                    BOWpoints[4],
                    BOWpoints[5],
                    BOWmids[5],
                    [0,0]],
                paths=[[0,1,2,3]]);
    }
}

// fourth piece of the bowtie stripes
// bottom to starting position, with cut
module BOWchunk4(){
    intersection(){
        union(){
            strapCut(BOWmids[4],BOWmids[5],ridgeGap+ridgeThick);
            if (ridgeNumber==3) 
                strapCut(BOWmids[4],BOWmids[5],0);
            strapCut(BOWmids[4],BOWmids[5],-1*(ridgeGap+ridgeThick));
        }
        linear_extrude(strapHeight+ridgeHeight+1)
        polygon(points=[
                    go( BOWmids[4],
                        BOWmids[4]-normal(BOWpoints[4],BOWpoints[5]),
                        4.3*strapThick/5),
                    go(BOWmids[4],BOWpoints[5],3.1*strapThick/5),
                    BOWpoints[5],
                    BOWpoints[0]],
                paths=[[0,1,2,3]]);
    }
}

// all of the bowtie stripes
module BOWstripes(){
    color("white")
    union(){
        BOWlines();
        union(){
            translate([0,0,strapHeight]) BOWchunk1();
            translate([0,0,strapHeight]) BOWchunk2();
            translate([0,0,strapHeight]) BOWchunk3();
            translate([0,0,strapHeight]) BOWchunk4();
        }
        rotate(180,[0,0,1])
        union(){
            translate([0,0,strapHeight]) BOWchunk1();
            translate([0,0,strapHeight]) BOWchunk2();
            translate([0,0,strapHeight]) BOWchunk3();
            translate([0,0,strapHeight]) BOWchunk4();
        }
    }
}

// bowtie tile with strapwork attached
module BOWfullplain(){
    color("skyblue") BOWtile();
    translate([0,0,tileHeight-embed])
        color("white") BOWstrap(strapThick-.5*clearance);
}

// bowtie tile with striped strapwork attached
module BOWfullstripes(){
    union(){
        color("skyblue") BOWtile();
        translate([0,0,tileHeight-embed])
            color("white") BOWstripes();
    }
}

// bowtie tile with lines + offset clearance removed
module BOWcomplement(clear=.75*clearance){
    difference(){
        // pentagon tile
        linear_extrude(mosaicHeight)
            projection([0,0,1])
                color("skyblue") BOWtile();
        // remove lines with clearance
        translate([0,0,-1]) 
            linear_extrude(mosaicHeight+2) 
            offset(delta=clear) 
            projection([0,0,1]) 
                color("white") BOWlines();
    }
}

////////////////////////////////////////////////////////
// definitions and modules for RHO tiles
// a certain rhombus

// calculate rhombus radius given side length
RHOradius = s*sin(54); 

// list of rhombus vertex points
RHOpoints = [[RHOradius,0],[0,s*sin(36)],
             [-RHOradius,0],[0,-s*sin(36)]];
    
// extruded plain rhombus tile
module RHOtile(){
    color("orange")
    linear_extrude(height=tileHeight)
    polygon(points=RHOpoints, paths=[[for (i=[0:5]) i]]);
}

// list of bowtie midpoints
RHOmids = [for (i=[0:3]) move(RHOpoints[i%4],RHOpoints[(i+1)%4],.5)];

// inside points for the rhombus strapwork
// used trig to calculate the interior point coordinates
RHOinside = [[0,s*sin(36)-(s/2)*sin(54)/sin(72)],
             [0,-(s*sin(36)-(s/2)*sin(54)/sin(72))]];

// paths of the rhombus strapwork
// alternates between vertex points and interior points
RHOpath = [RHOmids[0],
           RHOinside[0],
           RHOmids[1],
           RHOmids[2],
           RHOinside[1],
           RHOmids[3]
          ];

// 2D polygon whose boundary is the rhombus strapwork line
module RHOshape(){
    polygon(points=RHOpath, paths=[[for (i=[0:5]) i]]);
}
    
// extruded and thickened rhombus strapwork line 
module RHOstrap(strap=strapThick){
    // default is strapThick
    // but can specify others for clearance
    intersection(){
        linear_extrude(strapHeight)
            difference(){
                offset(delta=strap/2) RHOshape();
                offset(delta=-strap/2) RHOshape();
            }
        scale([1,1,strapHeight/tileHeight]) 
            RHOtile();
    }
}

// rhombus tile with enlarged strapwork etching
module RHOetch(){
    color("orange")
    difference(){
        RHOtile();
        translate([0,0,tileHeight-embed])
            RHOstrap(strapThick+clearance);
    }
}

// rhombus strapwork alone
module RHOlines(){
    color("white")
    RHOstrap(strapThick-.5*clearance);
}

// first piece of the rhombus stripes
// left vertical piece, with cut
module RHOchunk1(){
    intersection(){
        union(){
            strapCut(RHOmids[3],RHOmids[0],ridgeGap+ridgeThick);
            if (ridgeNumber==3) 
                strapCut(RHOmids[3],RHOmids[0],0);
            strapCut(RHOmids[3],RHOmids[0],-1*(ridgeGap+ridgeThick));
        }
        linear_extrude(strapHeight+ridgeHeight+1)
        polygon(points=[
                    [0,0],
                    go( RHOmids[3],
                        RHOmids[3]-normal(RHOpoints[3],RHOpoints[0]),
                        4.3*strapThick/5),
                    go(RHOmids[3],RHOpoints[0],3.1*strapThick/5),
                    RHOpoints[0],
                    RHOpoints[1]],
                paths=[[0,1,2,3,4]]);
    }
}

// second piece of the rhombus stripes
// top left to top inside, with cut
module RHOchunk2(){
    intersection(){
        union(){
            strapCut(RHOmids[0],RHOinside[0],ridgeGap+ridgeThick);
            if (ridgeNumber==3) 
                strapCut(RHOmids[0],RHOinside[0],0);
            strapCut(RHOmids[0],RHOinside[0],-1*(ridgeGap+ridgeThick));
        }
        linear_extrude(strapHeight+ridgeHeight+1)
        polygon(points=[
                    [0,0],
                    go( RHOmids[0],
                        RHOmids[0]-normal(RHOpoints[0],RHOpoints[1]),
                        4.3*strapThick/5),
                    go(RHOmids[0],RHOpoints[1],3.1*strapThick/5),
                    RHOpoints[0],
                    RHOpoints[1]],
                paths=[[0,1,2,3,4]]);
    }
}

// third piece of the rhombus stripes
// top inside to top right, no cut
module RHOchunk3(){
    intersection(){
        union(){
            strapCut(RHOmids[1],RHOinside[0],ridgeGap+ridgeThick);
            if (ridgeNumber==3) 
                strapCut(RHOmids[1],RHOinside[0],0);
            strapCut(RHOmids[1],RHOinside[0],-1*(ridgeGap+ridgeThick));
        }
        linear_extrude(strapHeight+ridgeHeight+1)
        polygon(points=[
                    [0,0],
                    RHOpoints[1],
                    RHOpoints[2]],
                paths=[[0,1,2,3,4]]);
    }
}

// all of the rhombus stripes
module RHOstripes(){
    color("white")
    union(){
        RHOlines();
        union(){
            translate([0,0,strapHeight]) RHOchunk1();
            translate([0,0,strapHeight]) RHOchunk2();
            translate([0,0,strapHeight]) RHOchunk3();
        }
        rotate(180,[0,0,1])
        union(){
            translate([0,0,strapHeight]) RHOchunk1();
            translate([0,0,strapHeight]) RHOchunk2();
            translate([0,0,strapHeight]) RHOchunk3();
        }
    }
}

// rhombus tile with strapwork attached
module RHOfullplain(){
    union(){
        color("orange") RHOtile();
        translate([0,0,tileHeight-embed])
            color("white") RHOstrap(strapThick-.5*clearance);
    }
}

// rhombus tile with striped strapwork attached
module RHOfullstripes(){
    union(){
        color("orange") RHOtile();
        translate([0,0,tileHeight-embed])
            color("white") RHOstripes();
    }
}

// rhombus tile with lines + offset clearance removed
module RHOcomplement(clear=.75*clearance){
    difference(){
        // pentagon tile
        linear_extrude(mosaicHeight)
            projection([0,0,1])
                RHOtile();
        // remove lines with clearance
        translate([0,0,-1]) 
            linear_extrude(mosaicHeight+2) 
            offset(delta=clear) 
            projection([0,0,1]) 
                RHOlines();
    }
}

////////////////////////////////////////////////////////
// definitions and modules for HEX tiles
// a certain squashed convex hexagon

// calculate hexagon radius given side length
HEXradius = s/2 + s*sin(54);

// this is the shorter "radius"
HEXshort = (s/2)*sin(72)/sin(54);

// list of hexagon vertex points
HEXpoints = [[HEXradius,0],[s/2,HEXshort],[-s/2,HEXshort],
             [-HEXradius,0],[-s/2,-HEXshort],[s/2,-HEXshort]];

// extruded plain hexagon tile
module HEXtile(){
    color("gold")
    linear_extrude(height=tileHeight)
    polygon(points=HEXpoints, paths=[[for (i=[0:5]) i]]);
}

// ugh, sucked to calculate these
// x and y lengths of interior points
xPoint = sin(36)*(s/2)*sin(72)/sin(54);
yPoint = HEXshort - sin(54)*(s/2)*sin(72)/sin(54);

// inside points for the hexagon strapwork
// used trig to calculate the interior point coordinates
HEXinside = [[xPoint,yPoint],[-1*xPoint,yPoint],
             [-1*xPoint,-1*yPoint],[xPoint,-1*yPoint]];

// list of hexagon midpoints
HEXmids = [for (i=[0:5]) move(HEXpoints[i%6],HEXpoints[(i+1)%6],.5)];

// paths of the hexagon strapwork
// alternates between vertex points and interior points
HEXpath = [HEXmids[0],
           HEXinside[0],
           HEXmids[1],
           HEXinside[1],
           HEXmids[2],
           HEXmids[3],
           HEXinside[2],
           HEXmids[4],
           HEXinside[3],
           HEXmids[5],
          ];

// 2D polygon whose boundary is the hexagon strapwork line
module HEXshape(){
    polygon(points=HEXpath, paths=[[for (i=[0:9]) i]]);
}
    
// extruded and thickened hexagon strapwork line 
module HEXstrap(strap=strapThick){
    // default is strapThick
    // but can specify others for clearance
    intersection(){
        linear_extrude(strapHeight)
            difference(){
                offset(delta=strap/2) HEXshape();
                offset(delta=-strap/2) HEXshape();
            }
        scale([1,1,strapHeight/tileHeight]) 
            HEXtile();
    }
}

// hexagon tile with enlarged strapwork etching
module HEXetch(){
    color("gold")
    difference(){
        HEXtile();
        translate([0,0,tileHeight-embed])
            HEXstrap(strapThick+clearance);
    }
}

// hexagon strapwork alone
module HEXlines(){
    color("white")
    HEXstrap(strapThick-.5*clearance);
}

// first piece of the hexagon stripes
// vertical on right with bottom cut off
module HEXchunk1(){
    intersection(){
        union(){
            strapCut(HEXmids[5],HEXmids[0],ridgeGap+ridgeThick);
            if (ridgeNumber==3) 
                strapCut(HEXmids[5],HEXmids[0],0);
            strapCut(HEXmids[5],HEXmids[0],-1*(ridgeGap+ridgeThick));
        }
        linear_extrude(strapHeight+ridgeHeight+1)
        polygon(points=[
                    go( HEXmids[5],
                        HEXmids[5]-normal(HEXpoints[5],HEXpoints[0]),
                        4.3*strapThick/5),
                    go(HEXmids[5],HEXpoints[0],3.1*strapThick/5),
                    HEXpoints[0],
                    HEXpoints[1]],
                paths=[[0,1,2,3,4]]);
    }
}

// second piece of the hexagon stripes
// from first midpoint to first inside, with cut
module HEXchunk2(){
    intersection(){
        union(){
            strapCut(HEXmids[0],HEXinside[0],ridgeGap+ridgeThick);
            if (ridgeNumber==3) 
                strapCut(HEXmids[0],HEXinside[0],0);
            strapCut(HEXmids[0],HEXinside[0],-1*(ridgeGap+ridgeThick));
        }
        linear_extrude(strapHeight+ridgeHeight+1)
        polygon(points=[
                    go( HEXmids[0],
                        HEXmids[0]-normal(HEXpoints[0],HEXpoints[1]),
                        4.3*strapThick/5),
                    go(HEXmids[0],HEXpoints[1],3.1*strapThick/5),
                    HEXpoints[1],
                    move(HEXinside[0],HEXpoints[1],-.25)],
                paths=[[0,1,2,3,4]]);
    }
}

// third piece of the hexagon stripes
// from first inside to top midpoint, no cut
module HEXchunk3(){
    intersection(){
        union(){
            strapCut(HEXmids[1],HEXinside[0],ridgeGap+ridgeThick);
            if (ridgeNumber==3) 
                strapCut(HEXmids[1],HEXinside[0],0);
            strapCut(HEXmids[1],HEXinside[0],-1*(ridgeGap+ridgeThick));
        }
        linear_extrude(strapHeight+ridgeHeight+1)
        polygon(points=[
                    HEXpoints[1],
                    HEXpoints[2],
                    move(HEXinside[0],HEXpoints[1],-.25)],
                paths=[[0,1,2,3,4]]);
    }
}

// fourth piece of the hexagon stripes
// from top midpoint to second inside, with cut
module HEXchunk4(){
    intersection(){
        union(){
            strapCut(HEXmids[1],HEXinside[1],ridgeGap+ridgeThick);
            if (ridgeNumber==3) 
                strapCut(HEXmids[1],HEXinside[1],0);
            strapCut(HEXmids[1],HEXinside[1],-1*(ridgeGap+ridgeThick));
        }
        linear_extrude(strapHeight+ridgeHeight+1)
        polygon(points=[
                    [0,0],
                    go( HEXmids[1],
                        HEXmids[1]-normal(HEXpoints[1],HEXpoints[2]),
                        4.3*strapThick/5),
                    go(HEXmids[1],HEXpoints[2],3.1*strapThick/5),
                    HEXpoints[2],
                    move(HEXinside[1],HEXpoints[2],-.25)],
                paths=[[0,1,2,3,4]]);
    }
}

// fifth piece of the hexagon stripes
// from second inside to third midpoint, no cut
module HEXchunk5(){
    intersection(){
        union(){
            strapCut(HEXmids[2],HEXinside[1],ridgeGap+ridgeThick);
            if (ridgeNumber==3) 
                strapCut(HEXmids[2],HEXinside[1],0);
            strapCut(HEXmids[2],HEXinside[1],-1*(ridgeGap+ridgeThick));
        }
        linear_extrude(strapHeight+ridgeHeight+1)
        polygon(points=[
                    move(HEXinside[1],HEXpoints[2],-.25),
                    HEXpoints[2],
                    HEXpoints[3]],
                paths=[[0,1,2,3,4]]);
    }
}

// all of the hexagon stripes
module HEXstripes(){
    color("white")
    union(){
        HEXlines();
        union(){
            translate([0,0,strapHeight]) HEXchunk1();
            translate([0,0,strapHeight]) HEXchunk2();
            translate([0,0,strapHeight]) HEXchunk3();
            translate([0,0,strapHeight]) HEXchunk4();
            translate([0,0,strapHeight]) HEXchunk5();
        }
        rotate(180,[0,0,1])
        union(){
            translate([0,0,strapHeight]) HEXchunk1();
            translate([0,0,strapHeight]) HEXchunk2();
            translate([0,0,strapHeight]) HEXchunk3();
            translate([0,0,strapHeight]) HEXchunk4();
            translate([0,0,strapHeight]) HEXchunk5();
        }
    }
}

// hexagon tile with plain strapwork attached
module HEXfullplain(){
    color("gold") HEXtile();
    translate([0,0,tileHeight-embed])
        color("white") HEXlines();
}

// hexagon tile with striped strapwork attached
module HEXfullstripes(){
    union(){
        color("gold") HEXtile();
        translate([0,0,tileHeight-embed])
            color("white") HEXstripes();
    }
}

// hexagon tile with lines + offset clearance removed
module HEXcomplement(clear=.75*clearance){
    difference(){
        // pentagon tile
        linear_extrude(mosaicHeight)
            projection([0,0,1])
                color("gold") HEXtile();
        // remove lines with clearance
        translate([0,0,-1]) 
            linear_extrude(mosaicHeight+2) 
            offset(delta=clear) 
            projection([0,0,1]) 
                color("white") HEXlines();
    }
}

////////////////////////////////////////////////////////
// vector traveling (tested only in 2D)

//distance from A to B
function dist(A,B) = 
    sqrt((B[0]-A[0])*(B[0]-A[0])+(B[1]-A[1])*(B[1]-A[1]));

// start at A and move to B
// stay in the AB segment as t goes from 0 to 1
function move(A,B,t) = A+t*(B-A);

// start at A and move in the direction of B for a distance d
function go(A,B,d) = 
    A+d*(B-A)/dist(A,B);

// 2D vector normal to line from A to B
function normal(A,B) = (1/dist(A,B))*[B[1]-A[1],A[0]-B[0]];


