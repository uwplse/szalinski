// Mouthstick Length
length = 320; // [10:350]
// Surface Smoothing
smooth = 30;  // [30:100]
// Bite Plate Size
bite_plate =50;	//	[25:small, 32:medium, 40:large, 50:supersized]


$fn = smooth;
difference()
{
union()
{
// stylus
rotate([-90,0,0]) 
{
difference()
{
translate([0,-2.5,0])
cylinder (length, 3.5, 3.5, false);

// hole in end for foam
translate([0,-2.75,length-9])
cylinder (h=9, r1=2, r2=2);


// flat bottom on stylus
translate([-3.5,0,0])
cube ([7, 7, length]);
}
}




// mouthpeice
translate([0,-bite_plate/2,0])
scale ([bite_plate/2,(bite_plate/2)*1.2,1])
{
difference()
{
union()
{
difference()
{
cylinder (h=5, r1=1, r2=1, center=false);
translate ([0,-1,2.5])
cube ([2,2,5], center=true);
}

//rounded bite plate ends
translate ([-.84,0,0])
cylinder (h=5,r1=.16,r2=.16, center=false);

translate ([.84,0,0])
cylinder (h=5,r1=.16,r2=.16, center=false);
}
// inner mouthpeice hole
cylinder (h=5,r1=.68, r2=.68);
}
}
}
translate ([-bite_plate/2,-bite_plate+7, 1])
rotate ([5,0,0])
cube ([bite_plate, bite_plate*2, 30]);
}