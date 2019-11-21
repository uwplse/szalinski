/* [Text] */

enterName =           "Name"; 

enterNumber =      "0123456789"; 

showPart = "tag";           // [shape,text,tag]


/* [Dimensions] */


shapeWidth = 40; // mm [30:40]

shapeHeight = 29.2; // mm [20:35]

thickness = 3; // mm [1:3]


textDepth = 0.6; // mm [0.2:1.0] 




/* [Hidden] */

z=thickness;
holeDia = 3; // Hole [1:4]





textSize = 8;
textSize2 = 8;

//---------------------------

myFont2 = "Arimo:style=Bold";
myFont = "Arimo:style=Bold";

myColor = "White"; 
myColorbase = "Blue"; 
holeRad = holeDia/2;

baseSize = [shapeWidth, shapeHeight, thickness];

//include<shape1.scad>;

module textExtrude() {
color(myColor)
    resize([28.4,6.8,textDepth], auto=true) 
linear_extrude(height = textDepth) 
translate( [-0.3,5, 0]) 
text(enterName, halign = "center", valign = "center", size = textSize,spacing = 0.92, font = myFont); 
}

module textExtrude2() {
color(myColor) 
translate( [0,-1, 0]) 
        resize([36.4,4.4,textDepth], auto=true) 
linear_extrude(height = textDepth) 
text(enterNumber, halign = "center", valign = "center", size = textSize2,spacing = 1, font = myFont2); 
}


module base() {    
    union() {   

difference () {
 union()  {
  //  translate( [0,0,0.5])          

resize(newsize=[shapeWidth,shapeHeight,thickness])
           rotate(180,0,0)
       linear_extrude(height=1)
      polygon(Tpoints, convexity = 3);

  }
  //  import("T:\\Tag.stl", convexity=3);

    border();
  }
   //  ring();

}

}

module border() {
union()  {
    translate( [0,0,z-textDepth]) 

resize([shapeWidth-1,shapeHeight-1,thickness])
           rotate(180,0,0)
       linear_extrude(height=1)
      polygon(Tpoints, convexity = 3);
  }
  //  import("T:\\Tag.stl", convexity=3);
}

module holes() {
       
translate([0, shapeHeight/2-(holeRad+1), 0])
cylinder(r = holeRad, h = 3*thickness, $fn = 36, center = true);
    }
module ring() {
       
translate([0, shapeHeight/2-(holeRad+1),z-textDepth/2])
cylinder(r = holeRad+1, h = textDepth, $fn = 36, center = true);
    }


module Mybase() {
  //      render(convexity = 3){

union() {
difference () {
    union() {
 ring();
base();
    }    
Mytext();
holes();
  }
}
//}
}

module Mytag() {
union() {
color(myColorbase)
Mybase();

color(myColor) 
Mytext();
  }
}


module Mytext() {  
  
   //     render(convexity = 3){
union() {  
translate([0, -shapeHeight/3+textSize*0.7 , thickness-textDepth]) textExtrude();
translate([0, -(shapeHeight/2)+textSize2*1.13 , thickness-textDepth]) textExtrude2();
}}

//}

module print_part() {
    
	if (showPart == "shape") {
	
	Mybase();
	} else if (showPart == "text") {
		Mytext();
	} else if (showPart == "tag") {
		Mytag();
      	}
   else if (search("text",showPart)) {
		Mytext();
	}
   else if (search("shape",showPart) == 1) {
		Mybase();
  
	} else {
		Mytag();
	}
}

Tpoints = [[-12.570599,75.002760],[-27.906511,73.924581],[-42.865391,71.774840],[-54.715417,69.257994],[-62.576849,67.118180],[-64.693516,66.456720],[-66.810182,65.795260],[-68.529974,65.160260],[-76.322366,62.171706],[-83.621146,58.674658],[-90.121214,54.835305],[-95.517474,50.819840],[-99.379977,47.087561],[-102.347031,43.325516],[-104.406233,39.553552],[-105.545182,35.791510],[-105.813899,32.738878],[-105.730390,29.031404],[-105.329381,25.224710],[-104.645599,21.874420],[-102.476015,15.789010],[-102.132057,14.889420],[-99.936015,9.968170],[-94.591432,0.205050],[-90.940182,-5.377660],[-85.837031,-12.670241],[-80.991849,-19.030160],[-79.377891,-21.014540],[-75.938307,-25.036200],[-72.631016,-28.899120],[-66.830026,-35.093677],[-58.608099,-43.213080],[-46.252057,-53.928702],[-42.018724,-57.130161],[-32.655781,-63.708363],[-23.947682,-68.718910],[-16.618724,-72.052660],[-15.533932,-72.449535],[-12.702891,-73.375577],[-9.395599,-74.328077],[-5.146558,-75.011033],[0.585804,-75.267348],[6.387620,-75.087100],[10.845022,-74.460369],[14.842712,-73.187061],[19.371219,-71.338285],[24.068398,-69.072791],[28.572102,-66.549327],[36.999082,-61.029457],[44.949812,-55.172244],[52.706240,-48.665976],[60.328721,-41.658652],[67.742842,-34.224685],[74.874192,-26.438490],[86.383562,-12.018700],[92.230852,-3.525580],[96.338509,3.217990],[99.771482,9.703590],[101.120852,12.481710],[103.091999,17.393041],[104.745642,22.403590],[105.519137,26.616669],[105.813899,30.966171],[105.627451,34.983291],[104.957312,38.199220],[103.731184,40.993209],[102.014234,43.783168],[99.831576,46.545221],[97.208326,49.255495],[94.169597,51.890115],[90.740506,54.425205],[86.946165,56.836892],[82.811692,59.101300],[77.387732,61.747130],[66.804392,65.795260],[63.497102,66.853590],[55.559602,68.996720],[52.781482,69.764010],[49.209602,70.557760],[39.449784,72.366849],[31.217942,73.600470],[22.470154,74.476898],[10.845022,75.055680],[-0.604822,75.267348],[-12.570599,75.002780],[-12.570599,75.002760]];
    print_part();

    