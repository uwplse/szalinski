//How thick the object is
topThickness=3;//[1:10]
//How large the object will be at the opening, this is the radius of the circle. Due to the way this is calcuated, the less sides the less accurate the object will be. 
objectSide=98;//[5:500]
//How large the closed end of the object is. 
objectTopSide=80;//[5:500]
//How tall the object is
objectHeight=8;//[10:250]
//How many sides there are to the object, the higher the number the more circular the object is. 
fn=8;//[3:100]


module buildIt(){
    fudge = (1+1/cos(180/fn))/2;

    union(){
        difference(){
            cylinder(objectHeight + ( topThickness * 1 ),(objectSide + ( topThickness * 1 ))*fudge,(objectTopSide + ( topThickness * 1 ))*fudge,$fn=fn); //outer triangle
            cylinder(objectHeight ,(objectSide )*fudge,(objectTopSide )*fudge,$fn=fn); //inner triangle
            difference(){
                rotate(a=[0,0,60]) cylinder(objectHeight*3,((objectSide+objectSide)*3 + ( topThickness * 1 ))*fudge,(objectTopSide*3 + ( topThickness * 1 ))*fudge,$fn=fn);
                rotate(a=[0,0,60]) cylinder(objectHeight,(objectSide+(objectSide/2))*fudge,objectTopSide*fudge,$fn=fn);
            } // the cutoffs for the corners
        }
        
        difference(){
            rotate(a=[0,0,60]) cylinder(objectHeight,(objectSide+(objectSide/2)) * fudge,objectTopSide * fudge,$fn=fn);
            rotate(a=[0,0,60]) cylinder(objectHeight-topThickness,(objectSide+(objectSide/2)-topThickness)*fudge,(objectTopSide-topThickness)*fudge,$fn=fn);
            difference(){
                cylinder(objectHeight*8,objectSide*8,objectTopSide*8,$fn=fn); //outer triangle
                cylinder(objectHeight + ( topThickness * 1 ),(objectSide + ( topThickness * 1 )) *fudge,(objectTopSide + ( topThickness * 1 ))*fudge,$fn=fn);
            }

        } // the sides for the triangle and removal of extra portions
    }
}
buildIt();