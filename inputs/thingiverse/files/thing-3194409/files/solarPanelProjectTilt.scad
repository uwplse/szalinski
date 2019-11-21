//Written by Remi Vansnickt
//Feel free to tip me : https://www.thingiverse.com/Remivans/about
//Thingiverse : https://www.thingiverse.com/thing:3194409

/* [Model setting] */
//(mm) the Height dimension of your solar panel
solarPanelHeight=120;

//(mm) the Width dimension of your solar panel
solarPanelWidth=120;

//(mm) the Thickness of your solar panel
solarPanelThickness=2;//[1.5:0.1:2.5]

//(mm) hole diameter 
mountHole=5.2;//[1.6:0.1:8.4]

//(GPS) My Latitude on this beautifull Earth
myLatitude=48.904335;

//(GPS) This parameter doesn't change anything on this model
myLongitude=2;

//you can change the tilt of earth, if you want live on mars put 25degre!!
tiltEarth=23.5;//[0:0.1:360]

//number of dot to display per day ( put higher value to get precise model )
nbPointPerDay=10;//[4:1:48]

//(day) Start of simulation ( it is solar time so day 0 = 24 December ) 
earthTrajectoryStart=0;//[1:1:365]

//number of day to simulate (recommended parameter : 5-60 for visual trajectory & 2 for scaled real )
earthTrajectoryLength=182.5;//[1:0.5:365]

//number of time you want change the position of solarPanel ( each month put 12 )
changePerYearth=12;//[1:1:12]

//precision for estimate the best angle for solarPanel ( 5 for fast test model / 0.2-1 for precise output part )
finessAngle=5;//[0.5:0.25:10]

/* [PVC TUBE] */
//( mm ) Width of the Nozzle model optimized for 3-6 shell
PrinterNozzleWidth=0.4; //[0.1:0.05:1]

//( mm ) Outer diameter of pvc tube
pvcOuterDiameter=40;

//( mm ) clearance beetween part and tube
pvcpartClearance=0.4;//[0.1:0.05:1]

//Wall's number determine Thickness PrinterNozzleWidth*WallLayerCount 0.4*3=1.2mm
PvcWallLayerCount=10;  //[1:1:10]

//( mm ) longueur mount on pvc tube
pvcLength=20;//[10:1:100]

//( mm ) Hole screw diameter
HoleScrew=4.05;  //[2:0.05:6]

/* [Output model] */
//( :-) )output type
PreviewModel=0;//[0:Earth Saisons,2:output Mounted Part,3:output part,4:Earth trajectory visual,5:Eath Trajectory scaled real (2day is good value),6:one day tilt display,7:daily Year tilt display,1:calculateAngle ]


pvcT=PvcWallLayerCount*PrinterNozzleWidth+0.01;

//function for 3D printing Part
//output the distance where to make Hole
function calculateKell(AngleConsigne=45)=
    let(
     L=solarPanelHeight/2, // placement de la quille
     Q=L,//longueur de la quille 
     //Second degre equation X*X-2*L*cos(AngleConsigne)X+L*L-Q*Q=0
     //if Q=L the solution is obvious...
     b=-2*L*cos(AngleConsigne),
     c=L*L-Q*Q,
     delta=b*b-4*c,

     x1=(-b-sqrt(delta))/2,
     x2=(-b+sqrt(delta))/2,
    
     x= (x1<=0)?x2:((x1>=solarPanelWidth)?x2:x1)
     )
     x;

//Earth model ( approximate ;-) )
//-the Earth isn't perfect sphere ( it isn't flat too !)
//-the sun isn't at infinite position
//-the atmospher absorption varie during day
//-atmospher Refraction too !
//-Yearth length isn't 365 !
//-...

//vecteur rotation Earth
vecteurEarth=rotate(+tiltEarth,[0,1,0])*[0,0,1];

//return myCustomVector on Earth
 function myGPSVector(mylat=0,mylong=0,day=365/2,hour=12)=
     let (
     //myposition referentiel Earth
     GPSEarth=[
        cos(mylat)*cos(-mylong),
        cos(mylat)*sin(-mylong),
        sin(mylat)],
     
    //The Earth is tilted !!    
    GPSTilted=rotate(+tiltEarth,[0,1,0])*GPSEarth,
    
    //I rotate all the day ;(
    GPSDay=rotate(-hour*360/24,vecteurEarth)*GPSTilted,
    
    //I rotate around the sun all the Yearth ;-)
    vecteurGPS=rotate(-day*360/365,[0,0,1])*GPSDay
    )
    //myPosition at all time
    vecteurGPS;   

//return sun position from Earth Azimuth
 function  calculateAngle(mylat=0,mylong=0,day=365/2,hour=12) =
     let (
     vecteurGPS=myGPSVector(mylat,mylong,day,hour),
     
    //this value can be use with arduino project : it's Azimuth
    tetaH=180-acos(vecteurGPS[0]),//Azimuth
    
    //this value isn't correct but is a good approximation in many case
    //I don't use it in my project
    tetaV=90-acos(vecteurGPS[1])
    )
    [tetaH,tetaV];  

//return sunPower at one time for all position on meridian
 function calculateSunPower(mylat=0,mylong=0,day=365/2,hour=12,consigne=[45,0]) =
    let (
    
    vecteurGPS=myGPSVector(mylat,mylong,day,hour),
     
    teta=calculateAngle(mylat,mylong,day,hour),
    
    // This vector represente the horizon, the solarPanel will be tilted along this vector
    vecteurOrthogonalHorizon=rotate(-day*360/365,[0,0,1])*rotate(-hour*360/24,vecteurEarth)*[0,1,0],
    
    //trackSun over horizon teta>90 the sun is underground... it's night we don't track
    vectorSolarPanelHorizonTilted=rotate(consigne[0],vecteurOrthogonalHorizon)*vecteurGPS,
       
    //If you want tilt you solar panel along vertical ( your vector )
    //To track the sun you should determine tetaV better than mine but its work pretty good for my location
    vecteurPanneauSolarFullyTilted=rotate(consigne[1],vecteurGPS)*vectorSolarPanelHorizonTilted,

    //it should be negative for day and positive for night
    scalarSun=vecteurPanneauSolarFullyTilted*[1,0,0]
    
    )
    (teta[0]<=90 && scalarSun<0  ) ? scalarSun:0;

function accumulateSunPower(mylat=0,mylong=0,dayStart=0,dayEnd=365,hour=0,nbPointPerDay=24,consigne=[45,0],accumulate=0) =
    let (
    step=24/(nbPointPerDay),
    scalarSun=calculateSunPower(mylat,mylong,dayStart,hour,consigne)/nbPointPerDay
    )
    (dayStart>=dayEnd)?accumulate+scalarSun:accumulateSunPower(mylat,mylong,dayStart+1/nbPointPerDay,dayEnd,hour+step,nbPointPerDay,consigne,scalarSun+accumulate);


function optimizeAngle(mylat=0,mylong=0,dayStart=0,dayEnd=365,hour=0,nbPointPerDay=24,consigne=[45,0],sunpower=0,minConsigne=90,maxConsigne=0) =
let(
    newSunpower=-accumulateSunPower(mylat,mylong,dayStart,dayEnd,hour,nbPointPerDay,consigne,0),
    minAngle=min(consigne[0],minConsigne),
    maxAngle=max(consigne[0],maxConsigne)
    )
    (newSunpower>=sunpower)?optimizeAngle(mylat,mylong,dayStart,dayEnd,hour,nbPointPerDay,[consigne[0]-finessAngle,0],newSunpower,minAngle,maxAngle):consigne;

function makingArrayAngle(mylat=0,mylong=0,dayStart=0,dayEnd=365,hour=0,nbPointPerDay=24,arrayAngle=[])=
                let(
                consigneBest=optimizeAngle(mylat,mylong,dayStart,dayEnd,0,nbPointPerDay,[mylat+(tiltEarth+10)*cos(dayStart/365),0]),
                holePosition=round(10*(calculateKell(consigneBest[0])))/10,
                consigneKell=acos((solarPanelHeight/2-holePosition*cos(consigneBest[0]))/(solarPanelHeight/2))
                    
                )
                (earthTrajectoryStart+earthTrajectoryLength>=dayStart)?makingArrayAngle(mylat,mylong,dayEnd,dayEnd+365/changePerYearth,hour,nbPointPerDay,concat(arrayAngle,[[["start",dayStart],["tilt",consigneBest[0]],["holePosition",holePosition],["kell",consigneKell]]])):arrayAngle;
                
function minMaxAngleFunction(arrayAngle,minMax,index)=
    let(
    newMinMax=[min(minMax[0],arrayAngle[index][1][1]),max(minMax[1],arrayAngle[index][1][1])]    
    )
    (index<len(arrayAngle)-1)?minMaxAngleFunction(arrayAngle,newMinMax,index+1):newMinMax;

//PVC model    
module tube(){
    
    scaleY=max(1,(solarPanelHeight/2 +12)/(2*(pvcOuterDiameter/2+pvcpartClearance+pvcT)));
    translate([0,0,-pvcLength])
difference(){
     translate([0,0,0])
        scale([1,scaleY,1])cylinder(r=pvcOuterDiameter/2+pvcpartClearance+pvcT,h=pvcLength,$fn=4*pvcOuterDiameter);

 translate([0,0,-1])
        cylinder(r=pvcOuterDiameter/2+pvcpartClearance,h=pvcLength,$fn=4*pvcOuterDiameter);
    }


}
module tubeScrew(){
    translate([0,0,-pvcLength])
    union(){
    translate ([-solarPanelHeight/2,0,pvcLength/2]) rotate([0,90,0]) cylinder(r=HoleScrew/2,h=solarPanelHeight,$fn=30);
     
        rotate([0,0,90])translate ([-solarPanelHeight/2,0,pvcLength/2]) rotate([0,90,0]) cylinder(r=HoleScrew/2,h=solarPanelHeight,$fn=30);
    } 
    }
     
                
//the trajectory View are approximative because the earth keep moving during day 
//Have you ever See Earth jumping every Month ! :-) but 1/365 for one day isn't a bad approximation
module previewConsigne(mylat=0,mylong=0,nbPointPerDay=24){   
    
    for(day=[earthTrajectoryStart:365/changePerYearth:earthTrajectoryStart+earthTrajectoryLength]){
         echo ("day",day);   
     consigneBest=optimizeAngle(mylat,mylong,day,day+365/changePerYearth,0,nbPointPerDay,[mylat+(tiltEarth+10)*cos(day/365),0,90,0]);
     totalSun=accumulateSunPower(mylat,mylong,day,day+365/changePerYearth,0,nbPointPerDay,consigneBest,0);
     echo ("consigne",consigneBest,"totalSun",totalSun);          

//sun Power       
        color("yellow")
        translate([length(day)*5/2,0,0])//text size*nbChar/2
        placeElement(day*12/365)
        translate([0,0,0])
        text("day :",size = 5);
        color("yellow")
        translate([length(day)*5/2,0,0])//text size*nbChar/2
        placeElement(day*12/365)
        translate([15,0,0])
        text(str(round(10*day*360/365 - 70)/10),size = 5);// -7 because 24 decembre sun reference day 0 
        color("yellow")
        translate([length(day)*5/2,0,0])//text size*nbChar/2
        placeElement(day*12/365)
        translate([35,0,0])
        text("angle :",size = 5);
        color("yellow")
        translate([length(day)*5/2,0,0])//text size*nbChar/2
        placeElement(day*12/365)
        translate([55,0,0])
        text(str(consigneBest[0]),size = 5);
        
    }//endLoop
    
//PowerfullSun
        translate([-7,5,0])
        text("SUN",center=true, size = 5);
        color("yellow")
            sphere(r=5); 
} 

//output part be aware that their are quit a lot of calcul to dertermine the right position by iteration !
module previewPart(mylat=0,mylong=0,nbPointPerDay=24){   
    widthPart=0.4*3*2*3*1.5;
    $fn=50;
    
    arrayAngle=makingArrayAngle(mylat,mylong,earthTrajectoryStart,earthTrajectoryStart+365/changePerYearth,0,nbPointPerDay,[]);
    minMaxAngle=minMaxAngleFunction(arrayAngle,[90,0],0);
    holePosition0=round(10*(calculateKell(max(minMaxAngle[0],0))))/10;
    holePosition1=round(10*(calculateKell(minMaxAngle[1])))/10;   
    
                    consigneKell0=acos((solarPanelHeight/2-holePosition0*cos(max(minMaxAngle[0],0)))/(solarPanelHeight/2));
                    consigneKell1=acos((solarPanelHeight/2-holePosition1*cos(minMaxAngle[1]))/(solarPanelHeight/2));
    
    
    module hullModule(partLength=0,partWidth=0,clearance=0.4,rayon=5){
          translate([-(partWidth-clearance*2)/2,0,0])rotate(90,[0,1,0])
                    hull(){
                        cylinder(r=rayon,h=partWidth-clearance*2);
                        translate([0,partLength,0])cylinder(r=rayon,h=partWidth-clearance*2);
                    }
              } 
    module mountHole(position){
        //mount Hole
            translate([-widthPart,0,0])rotate(90,[0,1,0])
            translate([0,position,-10])cylinder(r=mountHole/2,h=widthPart+20);
        }
    
        module kell(){
                //kell
                 difference(){
                    union(){
                        hullModule(solarPanelHeight/2,widthPart,0);
                    }
                    union(){
                    mountHole(0);
                    mountHole(solarPanelHeight/2);
                       
                    translate([0,solarPanelHeight/2,0])rotate(-consigneKell1-minMaxAngle[1],[1,0,0])hullModule(solarPanelHeight,widthPart/2,0,6);
                    translate([0,solarPanelHeight/2,0])rotate(-consigneKell0-minMaxAngle[0],[1,0,0])hullModule(solarPanelHeight,widthPart/2,0,6);
                    
                    translate([0,0,0])rotate(-consigneKell0,[1,0,0])hullModule(solarPanelHeight,widthPart/2,0,6);
                    translate([0,0,0])rotate(-consigneKell1,[1,0,0])hullModule(solarPanelHeight,widthPart/2,0,6);

                    }   
                }
            }      
        module floorSupport(){
            
             //mount
          translate([0,0,0])
            difference(){
                union(){
                    //support pvc pipe
                    translate([0,solarPanelHeight/4,-6])
                        difference(){
                            tube();
                            tubeScrew();
                        }
                    difference(){
                        union(){
                            hullModule(solarPanelHeight/2,widthPart,0,5);
                            translate([-widthPart/2,-5,-6])cube([widthPart,solarPanelHeight/2+10,6]);
                            }
                    //cut front solarMount
                    translate([0,solarPanelHeight/2,0])rotate(180-max(0,minMaxAngle[0]),[1,0,0])hullModule(solarPanelHeight,widthPart/2,0,6);
                   translate([0,solarPanelHeight/2,0])rotate(180-minMaxAngle[1],[1,0,0])hullModule(solarPanelHeight,widthPart/2,0,6);
                    //cut back kell min
                    translate([-widthPart/2,0,0])rotate(consigneKell0,[1,0,0])hullModule(solarPanelHeight/2,widthPart/2,-0.4,6);
                    translate([+widthPart/2,0,0])rotate(consigneKell0,[1,0,0])hullModule(solarPanelHeight/2,widthPart/2,-0.4,6);
                    
                            //cut back kell max
                            translate([-widthPart/2,0,0])rotate(consigneKell1,[1,0,0])hullModule(solarPanelHeight/2,widthPart/2,-0.4,6);
                    translate([+widthPart/2,0,0])rotate(consigneKell1,[1,0,0])hullModule(solarPanelHeight/2,widthPart/2,-0.4,6);
                    }
               hullModule(0,widthPart/2,0.4,5);
                    translate([-widthPart/4+0.4,-5,-7])cube([widthPart/2-0.8,10,7]);
                }
                mountHole(0);
                mountHole(solarPanelHeight/2);
            }
        
          }//floorSupport();
        
        module solarPanel(clearance=0){
            color("black")union(){
            translate([0,0,-5-solarPanelThickness-2-clearance/2])
            hull(){
                translate([-solarPanelWidth/2+5,solarPanelHeight-5,0])cylinder(r=5-clearance,h=solarPanelThickness-2*clearance);
                translate([solarPanelWidth/2-5,solarPanelHeight-5,0])cylinder(r=5-clearance,h=solarPanelThickness-2*clearance);
                translate([solarPanelWidth/2-5,5,0])cylinder(r=5-clearance,h=solarPanelThickness-2*clearance);
                translate([-solarPanelWidth/2+5,5,0])cylinder(r=5-clearance,h=solarPanelThickness-2*clearance);
                }
            }
        }
          
        module help(){
            difference(){
                        cube([2*solarPanelWidth/3,2*solarPanelWidth/3,4*0.4]);
                        translate([2*solarPanelWidth/3,2*solarPanelWidth/3,-1])scale([1,2,1])cylinder(r=solarPanelWidth/3,h=4*0.4+2,$fn=100); 
                        translate([0,2*solarPanelWidth/3,-1])scale([1,2,1])cylinder(r=solarPanelWidth/3,h=4*0.4+2,$fn=100); 
                        }
            
            }           
                        
        module solarSupport(){
        //solarSupport
        
        difference(){
        union(){
            //support
                 
            translate([0,0,0])
            difference(){
                union(){
                    hullModule(solarPanelHeight,widthPart/2,0.4,5);
                    translate([-(widthPart/2-0.8)/2,-5,-7])cube([widthPart/2-0.8,solarPanelHeight+10,7]);
                    
                    translate([-solarPanelWidth/3,solarPanelHeight-4*0.4+0.2,-7-(solarPanelThickness)/2-(5*0.4+solarPanelThickness+5*0.4)/2+0.6-1])cube([2*solarPanelWidth/3,4*(1+3)*0.4,5*0.4+solarPanelThickness+5*0.4]);
                    translate([-solarPanelWidth/3,-4*4*0.4+4*0.4-0.2,-7-(solarPanelThickness)/2-(5*0.4+solarPanelThickness+5*0.4)/2+0.6-1])cube([2*solarPanelWidth/3,4*(1+3)*0.4,5*0.4+solarPanelThickness+5*0.4]);
                    
                    translate([-solarPanelWidth/3,solarPanelHeight-3*0.4,-7+4*0.4/2+0.2-1])scale([1,-1,1])help();
                    translate([-solarPanelWidth/3,3*0.4,-7+4*0.4/2+0.2-1])help();
                    }
                
                
// hole from calculate solar position
                    mountHole(0);
                for(i=[0:1:len(arrayAngle)-1]){
                    mountHole(arrayAngle[i][2][1]);
                    }
                
                translate([0,0,-1])solarPanel(-0.4);
                rotate(max(minMaxAngle[0],0),[1,0,0])translate([0,solarPanelHeight/2,0])rotate(90,[1,0,0])hullModule(solarPanelHeight/2,widthPart/2,0,5.4);
                //rotate(minMaxAngle[1],[1,0,0])translate([0,solarPanelHeight/2,0])rotate(90,[1,0,0])hullModule(solarPanelHeight/2,widthPart/2,0,5.4);
                
                }    
            }
            
        }
            
      }
        for(i=[0:1:len(arrayAngle)-1]){
        echo("consigne :",arrayAngle[i],"keel0",consigneKell0,"kell1",consigneKell1,"minmax",minMaxAngle);
        }
        //output Min MAx position
      
      module outputMounted(tableData){
          module mounted(data){
                 union(){
                translate([0,0,0])floorSupport();
                rotate(data[3][1],[1,0,0])kell();
                translate([0,solarPanelHeight/2,0])rotate(180-abs(data[1][1]),[1,0,0])translate([0,0,0])union(){translate([0,0,-0.4])solarPanel();solarSupport();}
              }}
          for (i=[0:1:len(tableData)-1]){
              data=tableData[i];
             if(data[1][1]<0)
             {translate([i*(solarPanelHeight+40),0,0])rotate(180,[0,0,1]) mounted(data);} 
             else {translate([i*(solarPanelHeight+40),0,0]) mounted(data);}
             
               
          }
      }
       module supportHalf(){
                rotate(90,[0,-1,0])translate([0,0,10])
                difference(){
                    translate([widthPart,0,0])solarSupport();
                    translate([widthPart-solarPanelWidth+0.1,-1.5*solarPanelHeight,-50])cube([solarPanelWidth,3*solarPanelHeight,100]);//0.1 smallClearance
                    }
                }
      
      if(PreviewModel==2){outputMounted(arrayAngle);}
      if(PreviewModel==3){//output individual part             
                translate([-solarPanelHeight/2,0,pvcLength+1])floorSupport();
                translate([-solarPanelHeight/5,0,0])rotate(180,[0,1,0])kell();
                translate([0,0,-16])supportHalf();
                translate([10,0,-16])scale([-1,1,1])supportHalf();
          }         
        
              
        /*    */

} 
module previewMyLocationOnEarth(mylat=0,mylong=0,finessM=1,finessH=1){   
    for(month=[0:finessM:12]){
    if (month!=12) {
     totalSun=accumulateSunPower(mylat,mylong,month*365/12,month*365/12+30,0,nbPointPerDay,[90-(mylat/2),0],0);//5j

     echo ("totalSun",totalSun);          
//month number       
        color("yellow")
        translate([-2.5,-2.5,0])
        placeElement(month)
        rotate(-month*360/12)
        translate([-20*cos(month*360/12),-20*sin(month*360/12),0])
        text(str(month),size = 5); 
        
//sun Power    
        color("yellow")
        translate([length(month)*5/2,0,0])//text size*nbChar/2
        placeElement(month)
        translate([10,0,0])
        text(str(round(-totalSun*10)/10),size = 5); 
        
    for(i=[-0:finessH:360]){
     
    //myposition referentiel Sun 
    vecteurGPS=myGPSVector(mylat,mylong,day=month*365/12,hour=i*24/360);    
     
    //this value can be use with arduino project servo horizontale
    teta=calculateAngle(mylat,mylong,day=month*365/12,hour=i*24/360);
    
    //Calculate Sun receive on solar Panel
    scalarSun=calculateSunPower(mylat,mylong,month*365/12,hour=i*24/360);
    
        
  if (scalarSun!=0){echo ("teta",teta[0],"teta2",teta[1],"scalarSun",scalarSun,"month",month,"hour",24*i/360);}  
        
//output graph
        colorSun(scalarSun)
        placeElement(month)
        translate([10*vecteurGPS[0]-1/2,10*vecteurGPS[1]-1/2,10*vecteurGPS[2]-1/2]) 
          cube([1,1,1]); 
        
//earth
        color("lightblue")
        placeElement(month)
        rotate(-month*360/12)
        rotate(tiltEarth,[0,1,0])//yes i'm rotating a sphere :-) to make pattern more speaky 
            sphere(r=10);

    }}}//endLoop
    
//PowerfullSun
        translate([-7,5,0])
        text("SUN",center=true, size = 5);
        color("yellow")
            sphere(r=5); 
} 

//Trajectory
module preview2(mylat=0,mylong=0,finessM=1,finessH=1){   

    stepM=finessH/(365*24);
  
    for(month=[12*earthTrajectoryStart/365:stepM:12*(earthTrajectoryStart+earthTrajectoryLength)/365]){
    if (month!=12) {         
     
    //myposition referentiel Sun 
    vecteurGPS=myGPSVector(mylat,mylong,day=month*365/12,hour=24*365*month/12);    
     
    //this value can be use with arduino project servo horizontale
    teta=calculateAngle(mylat,mylong,day=month*365/12,hour=24*365*month/12);
    
    //Calculate Sun receive on solar Panel
    scalarSun=calculateSunPower(mylat,mylong,month*365/12,hour=24*365*month/12);
    
   scale=(PreviewModel==5)?6371/15000:10;
   scale2=(PreviewModel==5)?10000:700; 
        
//output graph
        colorSun(scalarSun,month)
        placeElement2(month,scale2)
        translate([scale*vecteurGPS[0]-1/2,scale*vecteurGPS[1]-1/2,scale*vecteurGPS[2]-1/2]) 
          cube([1,1,1]); 


    }}//endLoop
} 

module oneDayOptimisation(mylat=0,mylong=0,finessM=1,finessH=1){
    for(i=[180:-finessAngle:-180]){
    sunPower=-accumulateSunPower(mylat,mylong,earthTrajectoryStart,earthTrajectoryStart+1,0,nbPointPerDay,[i,0],0);
        echo ("angle",i,"power",sunPower);
        translate([i,0,0])cube([finessAngle,1,sunPower*100]);
        if(i%(finessAngle*6)==0)
        {translate([i,-10,0])rotate(90,[1,0,0])color("white")text(str(i));}
        if(sunPower>0.05)
        {translate([i,0,100])rotate(90,[1,0,0])color("red")cube([finessAngle,1,1]);}
    }  
    translate([-100,0,102])rotate(90,[1,0,0])color("red")text("theory max power with motorized Panel");  
}

module dayAfterDayOptimisation(mylat=0,mylong=0,finessM=1,finessH=1){
  for (j=[0:1:365])
  {
      for(i=[180:-finessAngle:-180]){
    sunPower=-accumulateSunPower(mylat,mylong,j,j+1,0,nbPointPerDay,[i,0],0);
        echo ("day",j,"angle",i,"power",sunPower);
        translate([i,j,0])cube([finessAngle,1,sunPower*100]);
        if(i%(finessAngle*6)==0)
        {translate([i,-10,0])rotate(90,[1,0,0])color("white")text(str(i));}
    }
      }
    
}
    module colorSun(value=0,month=0){
     //echo("values",1+value);
        value=(1+value)<=0 ? -1:value; // the approximation of openScad made a value = -2E-16 ok 0 !
        if(value==0)
            {color([month/12,month/12,month/12])children();}
        else{
            {color([1,1+value,1+value])children();}
        }   
     }
    
    module placeElement(month,finessM=1){
            rotate(month*360/12)
            translate ([50/finessM,0,0])
            children();
     } 
    module placeElement2(month,scale){
            rotate(month*360/12)
            translate ([scale,0,0])
            children();
     }

  
//outputVisual
     
     if(PreviewModel==0) previewMyLocationOnEarth(myLatitude,myLongitude,1,360/nbPointPerDay);
     if(PreviewModel==1) previewConsigne(myLatitude,myLongitude,nbPointPerDay);
     if(PreviewModel==2) previewPart(myLatitude,myLongitude,nbPointPerDay);
     if(PreviewModel==3) previewPart(myLatitude,myLongitude,nbPointPerDay);
     if(PreviewModel==4) preview2(myLatitude,myLongitude,1,360/nbPointPerDay);      
     if(PreviewModel==5) preview2(myLatitude,myLongitude,1,360/nbPointPerDay);
     if(PreviewModel==6) oneDayOptimisation(myLatitude,myLongitude,1,360/nbPointPerDay); 
     if(PreviewModel==7) dayAfterDayOptimisation(myLatitude,myLongitude,1,360/nbPointPerDay);  
     
//imported Function to play with Earth and Matrix     
function identity(d)        = d == 0 ? 1 : [for(y=[1:d]) [for(x=[1:d]) x == y ? 1 : 0] ];
function length(v)          = let(x=v[0], y=v[1], z=v[2]) sqrt(x*x + y*y + z*z);
function unit_vector(v)     = let(x=v[0], y=v[1], z=v[2]) [x/length(v), y/length(v), z/length(v)];
function skew_symmetric(v)  = let(x=v[0], y=v[1], z=v[2]) [[0, -z, y], [z, 0, -x], [-y, x, 0]];
function tensor_product1(u) = let(x=u[0], y=u[1], z=u[2]) [[x*x, x*y, x*z], [x*y, y*y, y*z], [x*z, y*z, z*z]];
 
 
// FUNCTION: is_String(x)
//   Returns true if x is a string, false otherwise.
function is_string(x) =
	x == undef || len(x) == undef
		? false // if undef, a boolean or a number
		: len(str(x,x)) == len(x)*2; // if an array, this is false

// FUNCTION: is_array(x)
//   Returns true if x is an array, false otherwise.
function is_array(x) = is_string(x) ? false : len(x) != undef; 
 
function rotate(a, v)
 = is_array(a)
	? let(rx=a[0], ry=a[1], rz=a[2])
		  [[1, 0, 0],              [0, cos(rx), -sin(rx)], [0, sin(rx), cos(rx)]]
		* [[cos(ry), 0, sin(ry)],  [0, 1, 0],              [-sin(ry), 0, cos(ry)]]
		* [[cos(rz), -sin(rz), 0], [sin(rz), cos(rz), 0],  [0, 0, 1]]
	: let(uv=unit_vector(v))
	  cos(a)*identity(3) + sin(a)*skew_symmetric(uv) + (1 - cos(a))*tensor_product1(uv);
      