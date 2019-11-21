$fn=64;

h=10;
bolt=9.8;
pitch=1.5;
boltAngle=30;

//////////////////////////////////////////////////////////////

screw_thread(bolt,pitch,boltAngle,h,3.14/($fn/10),1);

//////////////////////////////////////////////////////////////

module screw_thread(od,st,lf0,lt,rs,cs){
	module thread_shape(cs,lt,or,ir,sn,st){
		if ( cs == 0 ){
			cylinder(h=lt, r=or, $fn=sn, center=false);
		} else {
			u(){
				t([0,0,st/2]) cylinder(h=lt-st+0.005, r=or, $fn=sn, center=false);

				if ( cs == -1 || cs == 2 ){
					cylinder(h=st/2, r1=ir, r2=or, $fn=sn, center=false);
				} else {
					cylinder(h=st/2, r=or, $fn=sn, center=false);
				}

				t([0,0,lt-st/2])
				if ( cs == 1 || cs == 2 ){
					cylinder(h=st/2, r1=or, r2=ir, $fn=sn, center=false);
				}	else {
					cylinder(h=st/2, r=or, $fn=sn, center=false);
				}
			}
		}
	}

	module full_thread(ttn,st,sn,zt,lfxy,or,ir){
		if(ir >= 0.2){
			for(i=[0:ttn-1]){
				for(j=[0:sn-1]){
					pt = [[0,0,i*st-st],[ir*cos(j*lfxy),ir*sin(j*lfxy),i*st+j*zt-st],
								[ir*cos((j+1)*lfxy), ir*sin((j+1)*lfxy), i*st+(j+1)*zt-st   ],
								[0,                  0,                  i*st],
								[or*cos(j*lfxy),     or*sin(j*lfxy),     i*st+j*zt-st/2     ],
								[or*cos((j+1)*lfxy), or*sin((j+1)*lfxy), i*st+(j+1)*zt-st/2 ],
								[ir*cos(j*lfxy),     ir*sin(j*lfxy),     i*st+j*zt          ],
								[ir*cos((j+1)*lfxy), ir*sin((j+1)*lfxy), i*st+(j+1)*zt      ],
								[0,                  0,                  i*st+st            ]];
						
						 polyhedron(points=pt, faces=[[1,0,3],[1,3,6],[6,3,8],[1,6,4],[0,1,2],[1,4,2],[2,4,5],[5,4,6],[5,6,7],[7,6,8],[7,8,3],[0,2,3],[3,2,7],[7,2,5]]);
				}
			}
		} else {
			echo("Step Degrees too agresive, the thread will not be made!!");
		}
	}

	or=od/2;
	ir=or-st/2*cos(lf0)/sin(lf0);
	pf=2*PI*or;
	sn=floor(pf/rs);
	lfxy=360/sn;
	ttn=round(lt/st+1);
	zt=st/sn;

	intersection(){
		if (cs >= -1) thread_shape(cs,lt,or,ir,sn,st);
		full_thread(ttn,st,sn,zt,lfxy,or,ir);
	}
}


//////////////////////////////////////////////////////////////

module t(v=[0,0,0]){translate(v) children();}
module r(a=[0,0,0],rp=[0,0,0]){translate(rp) rotate(a) translate(-rp) children();}
module tr(v=[0,0,0],a=[0,0,0],rp=[0,0,0]){t(v) r(a,rp) children();}
module rt(a=[0,0,0],rp=[0,0,0],v=[0,0,0]){r(a,rp) t(v) children();}
module u(){union() children();}
