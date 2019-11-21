Part = "assembled";//[assembled,Top_inner,Top_outer,base]
Top_Radius = 20;
Material_thickness = 1;
offset = 0.3;
resolution = 20;
base_height = 20;

if (Part == "assembled") {
  union(){
    base();
    Top_inner();
    Top_outer();
  }
} else if (Part == "Top_inner") {
  Top_inner();
} else if (Part == "Top_outer") {
  Top_outer();
} else {
  base();
}

module Top_outer() {
  color([1,0.4,0.4]) {
    difference() {
      difference() {
        difference() {
          {
            $fn=resolution;    //set sides to resolution
            sphere(r=Top_Radius);
          }

          {
            $fn=resolution;    //set sides to resolution
            sphere(r=(Top_Radius - (0 + Material_thickness)));
          }
        }

        translate([0, 0, -4998]){
          cube([10000, 10000, 10000], center=true);
        }
      }

      difference() {
        union(){
          for (i = [1 : abs(1) : 5]) {
            rotate([0, 0, (i * (360 / 5))]){
              translate([(Top_Radius / 1.7), 0, 0]){
                {
                  $fn=resolution;    //set sides to resolution
                  cylinder(r1=(Top_Radius / 6 + offset), r2=(Top_Radius / 6 + offset), h=500, center=true);
                }
              }
            }
          }

          {
            $fn=resolution;    //set sides to resolution
            cylinder(r1=(Top_Radius / 6 + offset), r2=(Top_Radius / 6 + offset), h=500, center=true);
          }
        }

        translate([0, 0, -5000]){
          cube([10000, 10000, 10000], center=true);
        }
      }
    }
  }
}

module Top_inner() {
  difference() {
    color([1,1,1]) {
      union(){
        difference() {
          {
            $fn=resolution;    //set sides to resolution
            sphere(r=(Top_Radius - (Material_thickness + offset)));
          }

          translate([0, 0, -4998]){
            cube([10000, 10000, 10000], center=true);
          }
        }
        difference() {
          difference() {
            union(){
              for (i = [1 : abs(1) : 5]) {
                rotate([0, 0, (i * (360 / 5))]){
                  translate([(Top_Radius / 1.7), 0, 0]){
                    {
                      $fn=resolution;    //set sides to resolution
                      cylinder(r1=(Top_Radius / 6), r2=(Top_Radius / 6), h=500, center=true);
                    }
                  }
                }
              }

              {
                $fn=resolution;    //set sides to resolution
                cylinder(r1=(Top_Radius / 6), r2=(Top_Radius / 6), h=500, center=true);
              }
            }

            translate([0, 0, -4998]){
              cube([10000, 10000, 10000], center=true);
            }
          }

          difference() {
            cube([10000, 10000, 10000], center=true);

            {
              $fn=resolution;    //set sides to resolution
              sphere(r=Top_Radius);
            }
          }
        }
      }
    }

    cylinder(r1=(5 + offset), r2=(5 + offset), h=(Top_Radius - 4), center=true);
  }
}

module base() {
  color([1,1,1]) {
    union(){
      translate([0, 0, -3]){
        cylinder(r1=5, r2=5, h=Top_Radius, center=false);
      }
      translate([0, 0, (base_height * -1 + 2)]){
        cylinder(r1=(Top_Radius / 2.5), r2=(Top_Radius / 4), h=base_height, center=false);
      }
    }
  }
}


