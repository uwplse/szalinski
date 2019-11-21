// - Diameter of the D20 (overestimated)
DDie = 22;

// - Number of dice sets to store
Sets = 7;

// - Length of a set of dice (line a set up randomly and see how well they pack together)
LSet = 115;

// - Diameter of your disc magnets
DMag = 2.4; //diam = 2.0

// - Thickness of your disc magnets
TMag = 1.2; //thickness = 1

// - Include cutouts in model?
Cutouts = true; // [true:Yes,false:No]

// - Include decorative textures in model?
Deco = true; // [true:Yes,false:No]

// - Thickness of most walls/floors
thk = 1.5;

// - Thickness of high stress walls/floors
THK = 2.5; //To be used for stress areas

// - Which part would you like to see?
part = "All_Assembled"; // [    Lower_Tray,Upper_Tray,Drawer,Tower,Tower_Back,Tower_Front,All_Packed,All_Assembled]


/* [Hidden] */

Clr = .3; //for the drawer basically
Tab = 2*Clr+ 4*Clr; //Tab to prevent the drawer falling out
 
DPin = THK*0.7; //Must be less than thk.
PinZ = DPin; //Doesn’t need to be huge. Just for alignment.
MagBoss = DMag*2;

DrawX = Sets*DDie + (Sets-1)*thk + 2*thk;
DrawY = LSet + 2*thk;
DrawZ = DDie + thk; //Use wall thickness for base thickness
DiamHandle = DDie; //should be just enough to fit my finger in
 
TrayX = DrawX +2*(Tab+ THK + Clr); //two off clearance
TrayY = DrawY + THK; //no clearance as draw rear should be flush
LTrayZ= DrawZ + THK + Clr; //one clearance above drawer
 
TowerZ = DrawX + 2*Tab; //tower should fit neatly inside Tray, as with the drawer. Clearance defined in TrayX
TowerX = (TrayY -2*THK -2*Clr)/2-Clr; //two halves should neatly fill the Tray. 2off clrX sum
TowerY = max(TowerX*TrayY/TrayX,50); //XY ratio should match trays but tower must be at least 50mm deep or it looks wrong
UTrayZ = THK + TowerY/2; //flush with packed tower

TowerDiag = sqrt(pow(TowerX,2)+pow(TowerY,2)); //Major diag
TowerDiag2 = 2*TowerX*TowerY/TowerDiag; //Minor diag
TowerAng = 90-atan(TowerY/TowerX); //angle to opp corner
BaffleAng = atan((TowerZ-2.5*DDie)/(3*TowerDiag)); //slope
BaffleRise = TowerDiag * tan(BaffleAng); //height of baffle
BaffleLen = sqrt(pow(TowerDiag,2)+pow(BaffleRise,2));

ExitX = DDie;
ExitY = max(TowerY/2,DDie);
ExitZ = DDie*1.8;

BrkTargWid = 20;
BrkTargHt = BrkTargWid*0.4;
DetDep = 0.2; //Depth of etchings
 
if (part=="Drawer") Drawer();
if (part=="Lower_Tray") LTray();
if (part=="Upper_Tray") UTray();
if (part=="Tower") Tower();
if (part=="Tower_Front") FTower();
if (part=="Tower_Back") BTower();
if (part=="All_Packed") PackedConfig();
if (part=="All_Assembled") AssembledConfig();

//Drawer();
//Dice size is perfect.
//Divider thickness is more than sufficient. Reduce divider height.
//Curved exit doesnt do much.
//00 dice label should be 'C'. 20 10 4 12 10 6 8
//Magnet holes almost penetrate :/
//Could also cut reducers in walls
//Think about a solution to prevent tipping when drawer is open. Ignore. This is not an issue.
module Drawer() {
     SlotLen = LSet; //DrawY – thk - thk;
     dividerZ = 0.5*DrawZ;
     //body – slots + curved exit – handle -decal + Tab + Exit
     difference() {
        //body
        cube([DrawX, DrawY, DrawZ]);
        //slots
        for(n = [0:Sets-1]) {
            translate([thk+n*(DDie+thk), thk, thk]) 
                cube([DDie,   SlotLen, DDie]);
            //arches
            if(Cutouts) {
            difference() {
                translate([thk+DDie/2+n*(DDie+thk),thk,thk])
                rotate([90,0,0]) 
                linear_extrude(thk) 
                    Arch(DDie*0.3,DDie*0.8);
                translate([thk+DDie/2+3*(DDie+thk),thk,thk])
                rotate([90,0,0]) 
                linear_extrude(thk) 
                    Arch(DDie*0.3,DDie*0.8);
                }
            }
        }
        //handle
        translate([DrawX/2, 0, DrawZ]) rotate([90,0,0])
            cylinder(d=DiamHandle, 30, center=true);
        //reduce divider height leaving some material
        translate([thk,thk+DDie,dividerZ]) {
            cube([DrawX-2*thk,SlotLen-DDie,DrawZ]);
        }
        translate([thk,DDie+thk,DrawZ]) rotate([0,90,0]) {
            cylinder(r=DrawZ-dividerZ, DrawX-2*thk);
        }
        //magnets
        for (i=[0.1:0.1:0.9]) {
            translate([DrawX*i,DrawY,DrawZ/2]) {
                rotate([90,0,0]) MagHole();
            }
        }
        
        //Labels
        if (Deco) { 
        //optimal dice order 20 10 4 12 10 6 8
        TxtSz=DDie*0.5;
        TxtFont = "Arial Narrow";
        OrderFwd = "XX X IV XII X VI IIX";
        OrderRev = "XX X VI IIX X IV XII";
        translate([0,DrawY/2,DrawZ/2]) rotate([90,0,90]) {
            linear_extrude(DetDep) {
                text(OrderRev, font=TxtFont, size=TxtSz, halign="center", valign                            ="center");
                }
        }
        translate([DrawX-DetDep,DrawY/2,DrawZ/2]) rotate([90,0,90]) {
            linear_extrude(DetDep) {
                text(OrderFwd, font=TxtFont, size=TxtSz, halign="center", valign                            ="center");
                }
        }
        }
    }
        
    //Tabs
    translate([-Tab, DrawY-thk, 0]) {
       cube([Tab, thk, DrawZ]);
    }
    translate([DrawX, DrawY-thk, 0]) {
       cube([Tab, thk, DrawZ]);
    }
}


//LTray();
//TrayLower is not centered
//Consider making large cutouts in base to save material
module LTray() {
     //body – Draw cavity - diamonds + pins
    difference() {
        //Body
        cube([TrayX, TrayY, LTrayZ]);
        //Cavity
        translate([THK, THK, THK]) 
            cube([TrayX-2*THK, TrayY-2*THK,LTrayZ]);
        translate([THK+Tab, 0, THK])
            cube([DrawX+2*Clr, THK, LTrayZ]);
        //Diamonds
        if (Cutouts) {
            linear_extrude(THK) {
                translate([THK*2,2*THK]) {
                    DiamondX =(TrayX-4*THK)/5; //width of a diamond
                    DmSpanX=TrayX-4*THK; //span of diamonds
                    DmSpanY=TrayY-4*THK; //Span of diamonds
                    Diamonds(DiamondX,0.15,DmSpanX,DmSpanY);
                }
            }
        }
        
        //Magnet holes
        for (i=[0.1:0.1:0.9]) {
        translate([THK+Clr+Tab+DrawX*i,TrayY-THK,THK+Clr+DrawZ/2]) {
            rotate([270,0,0]) {
                MagHole();
            }
        }
        }
    
        //Side details
        if (Deco) {
            //left face bricks
            rotate([90,0,90]) linear_extrude(DetDep) {
                Bricks(BrkTargWid,LTrayZ/3,TrayY,LTrayZ-1);
            } 
            translate([0,0,LTrayZ-1]) cube([DetDep,TrayY,1]);
            //right face bricks
            translate([TrayX-DetDep,0,0]) {
                rotate([90,0,90]) linear_extrude(DetDep) {
                    Bricks(BrkTargWid,LTrayZ/3,TrayY,LTrayZ-1);
                }
            }
            translate([TrayX-DetDep,0,LTrayZ-1]) cube([DetDep,TrayY,1]);
        }
        if (Cutouts) {
            //back face arches
            translate([THK,TrayY,THK]) rotate([90,0,0]) linear_extrude(DetDep) {
                ArchPattern(DDie*0.6,LTrayZ-THK,THK,TrayX-2*THK);
            }
        }
    }
    
    //Pins
//    translate([THK/2, THK/2, LTrayZ])
//        cylinder(d1=DPin-0.2, d2=DPin/2, PinZ, $fn=20);
//    translate([THK/2, TrayY/2, LTrayZ])
//        cylinder(d1=DPin-0.2, d2=DPin/2, PinZ, $fn=20);
//    translate([THK/2, TrayY-THK/2, LTrayZ])
//        cylinder(d1=DPin-0.2, d2=DPin/2, PinZ, $fn=20);
//     
//    translate([TrayX/2, TrayY-THK/2, LTrayZ])
//        cylinder(d1=DPin-0.2, d2=DPin/2, PinZ, $fn=20);
//     
//    translate([TrayX-THK/2, THK/2, LTrayZ])
//        cylinder(d1=DPin-0.2, d2=DPin/2, PinZ, $fn=20);
//    translate([TrayX-THK/2, TrayY/2, LTrayZ])
//        cylinder(d1=DPin-0.2, d2=DPin/2, PinZ, $fn=20);
//    translate([TrayX-THK/2, TrayY-THK/2, LTrayZ])
//        cylinder(d1=DPin-0.2, d2=DPin/2, PinZ, $fn=20);
}


//UTray();
//Tray upper is not centered
module UTray() {
    //body - cavity – fingerholes - pins -reducers-bricks
    difference() {
        //body
        cube([TrayX, TrayY, UTrayZ]);
        //cavity
        translate([THK,THK,THK])
            cube([TrayX-2*THK, TrayY -2*THK, UTrayZ-THK]);
        //finger holes
        translate([TrayX/2, .25*TrayY, UTrayZ]) rotate([0,90,0])
            cylinder(d=DDie, TrayX, center=true);
        translate([TrayX/2, .75*TrayY, UTrayZ]) rotate([0,90,0])
            cylinder(d=DDie, TrayX, center=true);
        //Arches
        if (Cutouts) {
        translate([THK,TrayY,THK]) rotate([90,0,0]) {
            linear_extrude(TrayY) {
                ArchPattern(DDie*0.6,UTrayZ-2*THK,THK,TrayX-2*THK);
            }
        }
        }
        //magnet holes. R&C from bottom left
        MagZ = THK -TMag;
        MagY1 = THK +Clr +MagBoss/2;
        MagY2 = MagY1 +(TowerX -MagBoss);
        MagY3 = TrayY -MagY2;
        MagY4 = TrayY -MagY1;
        MagY_ = MagY4 -TowerY +MagBoss;
        MagX1 = MagY1;
        MagX2 = TrayX -MagX1;
        MagX_ = MagX1 +TowerX -2*DMag;
        echo(MagY3-MagY2);
        translate([MagX1, MagY1, MagZ]) {
            color("white") MagHole();
        }
        translate([MagX1, MagY2, MagZ]) {
            color("red") MagHole();
        }
        translate([MagX1, MagY3, MagZ]) {
            color("red") MagHole();
        }
        translate([MagX1, MagY4, MagZ]) {
            color("white") MagHole();
        }
        translate([MagX2, MagY1, MagZ]) {
            color("black") MagHole();
        }
        translate([MagX2, MagY2, MagZ]) {
            color("yellow") MagHole();
        }
        translate([MagX2, MagY3, MagZ]) {
            color("yellow") MagHole();
        }
        translate([MagX2, MagY4, MagZ]) {
            color("black") MagHole();
        }
        translate([MagX_, MagY4, MagZ]) {
            color("blue") MagHole();
        }
        translate([MagX_, MagY_, MagZ]) {
            color("purple") MagHole();
        }
        translate([MagX1, MagY_, MagZ]) {
            color("pink") MagHole();
        }         

        //Brick details
        if (Deco) {
            rotate([90,0,90]) linear_extrude(DetDep) {
                Bricks(BrkTargWid,BrkTargHt,TrayY,UTrayZ);
            } //left face
            translate([TrayX-DetDep,0,0]) {
                rotate([90,0,90]) linear_extrude(DetDep) {
                    Bricks(BrkTargWid,BrkTargHt,TrayY,UTrayZ);
                }
            } //right face
        }

        //Pins
        translate([THK/2, THK/2, 0])
            cylinder(d=DPin, PinZ, $fn=20);
        translate([THK/2, TrayY/2, 0])
            cylinder(d=DPin, PinZ, $fn=20);
        translate([THK/2, TrayY-THK/2, 0])
            cylinder(d=DPin, PinZ, $fn=20);
         
        translate([TrayX/2, TrayY-THK/2, 0])
            cylinder(d=DPin, PinZ, $fn=20);
         
        translate([TrayX-THK/2, THK/2, 0])
            cylinder(d=DPin, PinZ, $fn=20);
        translate([TrayX-THK/2, TrayY/2, 0])
            cylinder(d=DPin, PinZ, $fn=20);
        translate([TrayX-THK/2, TrayY-THK/2, 0])
            cylinder(d=DPin, PinZ, $fn=20);
    }
}

//Tower();
//Tower is on origin
module Tower() {
     //body – (cavity-magnetbosses) – (exit-corner fillers) - arches - mag holes + baffles
     difference()  {
        //body
        cube([TowerX, TowerY, TowerZ]);
        //cavity - magbosses
        difference() {
            //cavity
            translate([thk,thk,0]) {
                cube([TowerX-2*thk,TowerY-2*thk,TowerZ]);
            }
            //magnet bosses
            translate([0,0,0]) {
                cube([MagBoss,TowerY,MagBoss]);
            }
            translate([TowerX-MagBoss,0,0]) {
                cube([MagBoss,TowerY,MagBoss]);
            }
            translate([0,0,TowerZ-DMag*2]) {
                cube([MagBoss,TowerY,MagBoss]);
            }
            translate([TowerX-MagBoss,0,TowerZ-MagBoss]) {
                cube([MagBoss,TowerY,MagBoss]);
            }
        }
        
        //exit-corner triangles
        difference() {
            translate([TowerX-DDie,0,2*DMag]) 
                cube([ExitX,ExitY,ExitZ-2*DMag]);
            //front triangle
            translate([0,thk,0]) rotate([90,0,0]) linear_extrude(thk) {
                X1 = TowerX-DDie;
                X2 = TowerX;
                Y1 = (X1/TowerX)*(BaffleRise/2);
                Y2 = 0;
                Pgon=[[X1,Y1-thk+4],[X2,Y2+thk+4],[X2,Y2],[X1,Y2]];
                polygon(points = Pgon);
            }
            //side triangle
            translate([TowerX,0,0]) rotate([0,270,0]) linear_extrude(thk) {
                Y1 = ExitY;
                Y2 = 0;
                X1 = 0;
                X2 = (Y1/TowerY)*(BaffleRise/2);
                Pgon=[[X1,Y2],[X1+thk+4,Y2],[X2+thk+3,Y1],[X1,Y1]];
                polygon(points = Pgon);
            }
        }
            
        
        //Mag holes
        //Tower-Tower magnet holes
        translate([DMag,TowerY/2,DMag]) 
        rotate([90,0,0]) 
        color("red") {
            MagHole();
            rotate([180,0,0]) MagHole();
        }
        translate([DMag,TowerY/2,TowerZ-DMag])
        rotate([90,0,0])
        color("yellow") {
            MagHole();
            rotate([180,0,0]) MagHole();
        }
        translate([TowerX-DMag,TowerY/2,DMag])
        rotate([90,0,0]) 
        color("white") {
            MagHole();
            rotate([180,0,0]) MagHole();
        }
        translate([TowerX-DMag,TowerY/2,TowerZ-DMag])
        rotate([90,0,0]) 
        color("black") {
            MagHole();
            rotate([180,0,0]) MagHole();
        }
        //Tower-tray magnet holes
        translate([DMag,DMag,0]) color("pink")
            MagHole();
        translate([DMag,TowerY-DMag,0]) color("orange")
            MagHole();
        translate([TowerX-DMag,DMag,0]) color("purple")
            MagHole();
        translate([TowerX-DMag,TowerY-DMag,0]) color("blue")
            MagHole();
        
        //windows
        if (Cutouts) {
        WinX=6; //maximum print bridge span
        WinHt=TowerZ/5; //aesthetically pleasing size
        AboveWin=DMag*2; //distance between top and arch
        WinZPos=TowerZ-AboveWin-WinHt; //Zpos of wondows
        WinSill = thk; //arch frame sizes
        ArchFtHt=(WinZPos-ExitZ)/2-4*thk;
        ArchBkHt=(WinZPos)/3-3*thk;
        ArchesSpan=TowerX-2*thk;
        translate([thk, TowerY, WinZPos]) {
            rotate([90,0,0]) {
                linear_extrude(TowerY+1) {
                    ArchPattern(WinX,WinHt,WinSill,ArchesSpan);
                }
            }
        }
        translate([thk*2, TowerY, BaffleRise+DDie/2]) {
            rotate([90,0,0]) {
                linear_extrude(TowerY+1) {
                    ArchPattern(WinX*2,WinX*3,WinSill*2,ArchesSpan-2*thk);
                }
            }
        }
        translate([0, TowerY/2, WinZPos]) {
            rotate([90,0,90]) {
                linear_extrude(TowerX+1) {
                    Arch(WinX,WinHt);
                }
            }
        }
        translate([0, TowerY/2, BaffleRise+DDie/2]) {
            rotate([90,0,90]) {
                linear_extrude(TowerX+1) {
                    Arch(WinX,WinHt);
                }
            }
        }
        }
        
        //bricks. Left/Right only
        if (Deco) {
            rotate([90,0,90]) 
            linear_extrude(DetDep)
                Bricks(BrkTargWid, BrkTargHt, TowerY, TowerZ);
            translate([TowerX-DetDep,0,0]) 
            rotate([90,0,90])
            linear_extrude(DetDep*2) 
                Bricks(BrkTargWid, BrkTargHt, TowerY, TowerZ);
        }
    }
    
     //lowest baffle
    translate([TowerX,0,0+3]) intersection() {
        rotate([BaffleAng, 0, TowerAng]) 
        translate([-TowerDiag2,0,0])
            cube([TowerDiag2*2,BaffleLen,thk]);
        translate([thk-TowerX, thk, 0])
            cube([TowerX-2*thk,TowerY-2*thk,TowerZ]);
    }
    //middle baffle with space for dicefall. Slope is negative
    translate([TowerX,0, 2*BaffleRise+DDie]) {
        intersection() {
            //panel
            rotate([-BaffleAng, 0, TowerAng])
            translate([-TowerDiag2,0,0])
                cube([TowerDiag2*2,BaffleLen,thk]);
            //control volume
            union() {
                //standard volume
                translate([-TowerX+thk+DDie, thk, -BaffleRise])
                    cube([  TowerX-2*thk-DDie, 
                            TowerY-2*thk, 
                            TowerZ]);
                //exit reduction
                translate([-TowerX+thk, thk, -BaffleRise])
                    cube([  TowerX-2*thk,
                            TowerY-thk-ExitY, 
                            TowerZ]);
            }
        }
    }
    //top baffle with space for dicefall
    translate([TowerX,0, TowerZ-.5*DDie-BaffleRise+3]) {
        intersection() {
            //panel
            rotate([BaffleAng, 0, TowerAng]) 
            translate([-TowerDiag2,0,0])
                cube([TowerDiag2*2,BaffleLen,thk]);
            //control volume
            union() {
                //Standard volume
                translate([-TowerX+thk, thk, 0])
                    cube([  TowerX-DDie-2*thk, 
                            TowerY-2*thk, 
                            TowerZ]);
                //exit reduction
                translate([-TowerX+thk, ExitY, 0])
                    cube([  TowerX-2*thk, 
                            TowerY-thk-ExitY, 
                            TowerZ]);
                }
            }
    }
}


//Front of Tower
//FTower();
module FTower() {
    difference() {
        Tower();
        translate([0,TowerY/2,0]) cube([TowerX, TowerY/2, TowerZ]);
    }
}

//Back of Tower
//BTower();
module BTower() {
    difference() {
        Tower();
        cube([TowerX, TowerY/2, TowerZ]);
    }
}


module PackedConfig() {
    TraysOnly();
    translate([Tab+Clr+THK,0, THK]) Drawer();
    translate([THK+Clr,THK+TowerX+Clr,THK+TowerY/2+LTrayZ])
    rotate([-90,0,-90]) 
        FTower();
    translate([ THK+Clr,
                THK+TowerX+Clr+1,
                THK+LTrayZ-TowerY/2+1e-2])
    rotate([90,0,90]) 
        BTower();
}


module AssembledConfig() {
    TraysOnly();
    translate([Tab+Clr+THK,-DrawY+2*THK, THK]) Drawer();
    translate([ THK+Clr,
                TrayY-THK-Clr-TowerY,
                LTrayZ+THK+1e-2])
        Tower();
}


module TraysOnly() {
    translate([0,0,-1e-2]) LTray();
    translate([0,0,LTrayZ]) UTray();
}


module ArchesTestConfig() {
    intersection() {
        cube([DDie*2+thk,12,UTrayZ]);
        UTray();
    }   
}


//2D Arch on origin centered on Yaxis
module Arch(Wid,Ht) {
    Rad=1.5*Wid; //1.5->H=1.1
    union() {
        translate([0, Ht-1.1*Wid]) intersection() {
            translate([-Wid/2,0]) square([Wid,Ht]);
            intersection(){
                translate([Rad-Wid/2,0]) circle(Rad,$fn=50);
                translate([-Rad+Wid/2,0]) circle(Rad,$fn=50);
            }
        }
        //Column
        translate([-Wid/2,0]) square([Wid,Ht-1.1*Wid]);
    }
}


//!ArchPattern(3, 10, 3, 22);
//creates a 2D linear pattern of arches in region ++
module ArchPattern(MaxWid, Ht, Gap, TotalLen) {
    //Add a gap to the length
    //Divide and round up to get number of units
    Count=ceil((TotalLen+Gap)/(MaxWid+Gap)); //number of instances
    W=(TotalLen+Gap)/Count-Gap; //new arch width
    //translate copies into place
    for(n=[0:1:Count-1]) {
        //locate originals as desired
        translate([n*(W+Gap)+W/2,0]) {
            Arch(W,Ht);
        }
    }
}


//Diamonds(10,0.15,35,55);
//2D pattern of diamonds on the origin
module Diamonds(DX, Dens, SpanX, SpanY) {
    DY = 2*DX; //Diamonds are double ht
    //Dens=0.15; //density of material
    P1 = [[0,0], [1+Dens,1+Dens], [1+Dens,1], [0,-Dens]];
    P2 = [[1,0], [0,1], [0,1+Dens], [1+Dens,0]];
    difference() {
        square([SpanX,SpanY]);
        union(){
            //lay matrix of pattern
            for (X=[-1:1:SpanX/DX]) for(Y=[-1:1:SpanY/DY])
            translate([X*DX,Y*DY]) {
                //stretch to suit selected unit size
                scale([DX,DY]) {
                    //unit shape (An 'X')
                    intersection(){
                        square(1+Dens);
                        union(){
                            polygon(points=P1);
                            polygon(points=P2);
                        }      
                    }
                }
            }
        }
    }
}


//!Bricks(3,1.1,10,10);
//2D negative brick pattern in ++ quad
module Bricks(BX, BY, WalX, WalY) {
    Mort = 0.15*BY; //mortar percentage
    nX = ceil((WalX+Mort)/(BX));
    nY = ceil((WalY+Mort)/(BY));
    BX_= (WalX+Mort)/nX;
    BY_= (WalY+Mort)/nY;
    for(X=[0:nX-1]) for(Y=[0:2:nY-1])
    translate([X*BX_,Y*BY_]) {
        difference() {
            square([BX_,BY_*2]);
            square([BX_-Mort, BY_-Mort]);
            translate([0, BY_]) square([(BX_-Mort)/2, BY_-Mort]);
            translate([BX_/2+Mort, BY_]) square([BX_,BY_-Mort]);
        }
    }
}


//Magnet hole
module MagHole() {
    cylinder(D=DMag+Clr, TMag, $fn =20);
}


//Creates an arch detail 
//!ArchDet(4,8,1);
module ArchDet(W,H,gap) {
    difference() {
        Arch(W+2*gap,H+3*gap);
        translate([0,gap,0])
            Arch(W,H);
    }    
}


//!ArchDetPat(4,10,1,12);
module ArchDetPat(W,H,gap,span) {
    count=ceil((span+gap)/(W+gap));
    W_ = (span+gap)/count-gap;
    for(i=[0:count-1]) {
        translate([W_/2+i*(W_+gap),0]) ArchDet(W_,H,gap);
    }
}



echo("Drawer=",DrawX, DrawY, DrawZ);
echo("Trays=",TrayX, TrayY, LTrayZ, UTrayZ);
echo("Tower=",TowerX, TowerY/2, TowerZ);