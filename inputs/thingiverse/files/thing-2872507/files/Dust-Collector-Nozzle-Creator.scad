// Parametric tool to create adapters between your vacuum hose and various tools in your shop.  
// Adjust the parameters below to customize the nozzle creator to match your 
// (C) CC BY-SA 2017 by Vincent S. Chernesky under a Creative Commons - Attribution - Sharealike License

SawInnerDia=57.3;  // Saw port interior diameter, will be the outer diameter of the adapter we are producing.  57.3mm will fit a 2.5" discharge.
SawInsertionDepth = 20; // Depth of the part that will be inserted into the saw, 20-40 is a good range
Thk=3; // Thickness of the adapter we are producing, I used 3mm and it worked great.
HoseTipDia=30.9; // Dip diameter of your vacuum hose
HoseTaperDia=32;// Diameter of your vacuum hose at HoseTaperLen from the tip of the hose (presumes tapered hose nozzle). 
HoseTaperLen=50;  //Distance from the vacuum hose tip to the measurement point of HoseTaperDia.  This length sets the insertion distance of the vacuum hose into the part we are producing
SawStopDist=5; // Length of the angled stopper to prevent overinsertion into the saw
AngledSectionLength = 30; //Length of the angled section between the saw and the vacuum hose

// Comment out the below rotate_extrude and a curly bracket at the end to see the shape you are building- It makes visusalizing the end product easier.
rotate_extrude(convexity = 10,$fn=200){
        union(){
    color("Red") {polygon(points=[[SawInnerDia/2,0],[SawInnerDia/2,SawInsertionDepth],[SawInnerDia/2,SawInsertionDepth-1],[(  SawInnerDia/2)+Thk,SawInsertionDepth],[(SawInnerDia/2)+Thk,SawInsertionDepth],[SawInnerDia/2,SawInsertionDepth+SawStopDist],[(SawInnerDia/2)-Thk,SawInsertionDepth+SawStopDist],[SawInnerDia/2-Thk,0]], path=[1,2,3,4,5,6],convexity=10);}
    color("Green"){polygon(points=[[SawInnerDia/2,SawInsertionDepth+SawStopDist], [HoseTaperDia/2+Thk,SawInsertionDepth+SawStopDist+AngledSectionLength],[HoseTipDia/2,SawInsertionDepth+SawStopDist+AngledSectionLength],[SawInnerDia/2-Thk,SawInsertionDepth+SawStopDist]],path=[1,2,3,4],convexity=20);}
    color("Blue"){polygon(points=[[HoseTaperDia/2+Thk,SawInsertionDepth+SawStopDist+AngledSectionLength],[HoseTaperDia/2+Thk,SawInsertionDepth+SawStopDist+AngledSectionLength+HoseTaperLen],[HoseTaperDia/2,SawInsertionDepth+SawStopDist+AngledSectionLength+HoseTaperLen],[HoseTipDia/2,SawInsertionDepth+SawStopDist+AngledSectionLength]],path=[1,2,3,4],convexity=10);}
}}