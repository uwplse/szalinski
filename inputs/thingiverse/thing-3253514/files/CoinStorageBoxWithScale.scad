// preview[view:south, tilt:top diagonal]
/* [General Settings] */
// Do you want a Scale per cylinder to make it easier to count the coins?
CreateScale=true; 
// Distance between the coin stacks
Distance=3; 

// Thickness of the outer wall(s)
OuterWallThickness=3; //

//Additional Tolerance Value in mm to add to all coin diameters
Tolerance=1;

/* [Coin Stack #1] */
//Number  of coins in slot 1
Coin1Num=20;
//Diameter of coin 1
Coin1Dia=22.26;
//Thickness of coin 1
Coin1T=2.17;

/* [Coin Stack #2] */
//Number  of coins in slot 2
Coin2Num=20;
//Diameter of coin 2
Coin2Dia=24.25;
//Thickness of coin 2
Coin2T=2.34;

/* [Coin Stack #3] */
//50ct
//Number  of coins in slot 3
Coin3Num=20;
//Diameter of coin 3
Coin3Dia=23.26;
//Thickness of coin 3
Coin3T=2.39;


/* [Coin Stack #4] */
//Euro
//Number  of coins in slot 4
Coin4Num=20;
//Diameter of coin 4
Coin4Dia=25.74;
//Thickness of coin 4
Coin4T=2.34;

TotalWidth=Coin1Dia+Coin2Dia+Coin3Dia+Coin4Dia+3*Distance+2*OuterWallThickness+4*Tolerance;



   rotate([0,0,180])    difference()
    {
        hull()
        union()
        {
            //Coin1 Tower
            translate([OuterWallThickness+(Coin1Dia+Tolerance)/2,-((Coin1Dia+Tolerance)/2+OuterWallThickness),0])
            CoinTowerOutside(Dia=Coin1Dia+Tolerance,height=Coin1T,count=Coin1Num,WallT=OuterWallThickness,PushHoleHeight=2.4);        
            //Coin2 Tower
            translate([OuterWallThickness+Distance+Coin1Dia+Tolerance+(Coin2Dia+Tolerance)/2,-((Coin2Dia+Tolerance)/2+OuterWallThickness),0])
            CoinTowerOutside(Dia=Coin2Dia+Tolerance,height=Coin2T,count=Coin2Num,WallT=OuterWallThickness,PushHoleHeight=2.4);        
            //Coin3 Tower
            translate([OuterWallThickness+2*Distance+Coin1Dia+Tolerance+Coin2Dia+Tolerance+(Coin3Dia+Tolerance)/2,-((Coin3Dia+Tolerance)/2+OuterWallThickness),0]) 
            CoinTowerOutside(Coin3Dia+Tolerance,height=Coin3T,count=Coin3Num,WallT=OuterWallThickness,PushHoleHeight=2.4);        
            //Coin4 Tower
            translate([OuterWallThickness+3*Distance+Coin1Dia+Tolerance+Coin2Dia+Tolerance+Coin3Dia+Tolerance+(  Coin4Dia+Tolerance)/2,-((Coin4Dia+Tolerance)/2+OuterWallThickness),0]) 
            CoinTowerOutside(Coin4Dia+Tolerance,height=Coin4T,count=Coin4Num,WallT=OuterWallThickness,PushHoleHeight=2.4);        
        }
        //NegativeForm 2Euro
         translate([OuterWallThickness+(Coin1Dia+Tolerance)/2,-((Coin1Dia+Tolerance)/2+OuterWallThickness),0])
         CoinTowerInside(Dia=Coin1Dia+Tolerance,height=Coin1T,count=Coin1Num,WallT=OuterWallThickness,PushHoleHeight=OuterWallThickness+0.01,Scale=CreateScale);        
        //NegativeForm 1Euro
        translate([OuterWallThickness+Distance+Coin1Dia+Tolerance+(Coin2Dia+Tolerance)/2,-((Coin2Dia+Tolerance)/2+OuterWallThickness),0])
        CoinTowerInside(Dia=Coin2Dia+Tolerance,height=Coin2T,count=Coin2Num,WallT=OuterWallThickness,PushHoleHeight=OuterWallThickness+0.01,Scale=CreateScale);        
        //NegativeForm 50ct    
        translate([OuterWallThickness+2*Distance+Coin1Dia+Tolerance+Coin2Dia+Tolerance+(Coin3Dia+Tolerance)/2,-((Coin3Dia+Tolerance)/2+OuterWallThickness),0]) 
        CoinTowerInside(Coin3Dia+Tolerance,height=Coin3T,count=Coin3Num,WallT=OuterWallThickness,PushHoleHeight=OuterWallThickness+0.01,Scale=CreateScale);        
    
        translate([OuterWallThickness+3*Distance+Coin1Dia+Tolerance+Coin2Dia+Tolerance+Coin3Dia+Tolerance+(  Coin4Dia+Tolerance)/2,-((Coin4Dia+Tolerance)/2+OuterWallThickness),0]) 
        CoinTowerInside(Coin4Dia+Tolerance,height=Coin4T,count=Coin4Num,WallT=OuterWallThickness,PushHoleHeight=OuterWallThickness+0.01,Scale=CreateScale);       
       //Vorderkante begradigen
       if(CreateScale==true){
        translate ([0,-OuterWallThickness,-1])
        cube([TotalWidth,OuterWallThickness+1,100]); 
       }
    }

module CoinTowerOutside(Dia=23.26,height=2.4,count=20,WallT=2,PushHoleHeight=2.4){
        translate([0,0,0]) 
        cylinder(r=Dia/2+WallT,h=height*count+WallT,$fn=50);
        
}
module CoinTowerInside(Dia=23.26,height=2.4,count=20,WallT=2,PushHoleHeight=2.4,Scale=true){
        translate([0,0,WallT]) 
        cylinder(r=Dia/2,h=height*(count+1)*2,$fn=50);
        translate([0,0,-0.01]) 
        cylinder(r=(Dia/2)*.75,h=PushHoleHeight+0.01,$fn=50);
        translate([-(Dia/4),0,PushHoleHeight+0.02]) 
        cube([Dia/2,Dia/2+WallT+1,height*(count+1)*2]);
        
        if(Scale==true){
            //CoinScale
            c_height=Dia/2+2;
            c_radius=0.3;
            for (num=[1:count]){
                c_height=c_height+(num%5==0?3:0)+(num%10==0?3:0);
                translate([-c_height/2,Dia/2+c_radius*.1,WallT+num*height]) 
                rotate([0,90,0])
                cylinder(r=c_radius,h=c_height,$fn=20);
            }
        }
}
