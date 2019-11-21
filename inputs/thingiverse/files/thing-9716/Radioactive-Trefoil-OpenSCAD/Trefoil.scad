/* Coded by Ben Rockhold */

/*	Customizer Variables	*/
OuterRadius = 50;
TrefoilHeight = 1;
//The ISO standard calls for a Trefoil with an inner circle of r, and three blades of inner radius 1.5*r and outer of 5*r, separated by 60 degrees. However, I have made this ratio editable here. I don't recommend changing them.
InnerRatio = 1.5;
OuterRatio = 5;
ResolutionMultiplier = 10;

Trefoil(OuterRadius,TrefoilHeight,InnerRatio,OuterRatio,ResolutionMultiplier);
//Animation is fun, but... kinda broken, and pointless.
//rotate(a=$t*100000){Trefoil(OuterRadius,TrefoilHeight,Ratio,ResolutionMultiplier);}

module Trefoil(outradius,height,inRatio,outRatio,rez){
	inradius = outradius/outRatio;
	union(){
		cylinder(r=inradius,height,center=true, $fn=inradius*rez);
		difference(){
			cylinder(r=outradius,height,center=true, $fn=inradius*rez);
			cylinder(r=inradius*inRatio,height*2,center=true, $fn=inradius*rez);
			for(i=[0:3]){
				rotate(a = i*120) {
				linear_extrude(height=height+1, center=true)
				polygon(points=[[0,0],[2*outradius,0],[(2*outradius)*cos(60),(2*outradius)*sin(60)]], paths=[[0,1,2]]);
				}
			}
		}
	}
}




