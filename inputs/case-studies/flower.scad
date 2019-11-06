union() {
    union() {
      translate([10, 10, 0]) {
          sphere($fn = 50);
      }

      translate([10, 5, 0]) {
          sphere($fn = 50);
      }

      translate([5, 10, 0]) {
          sphere($fn = 50);
      }

      translate([5, 5, 0]) {
          sphere($fn = 50);
      }
  }
    union () {
      translate([-10, -10, 0]) {
          sphere($fn = 50);
      }

      translate([-10, -5, 0]) {
        sphere($fn = 50);
      }

      translate([-5, -10, 0]) {
        sphere($fn = 50);
      }

      translate([-5, -5, 0]) {
        sphere($fn = 50);
      }
    }

    union() {
      translate([10, -10, 0]) {
        sphere($fn = 50);
      }

      translate([10, -5, 0]) {
        sphere($fn = 50);
      }

      translate([5, -10, 0]) {
        sphere($fn = 50);
      }

      translate([5, -5, 0]) {
        sphere($fn = 50);
      }
  }
  
  union() {
      translate([-10, 10, 0]) {
        sphere($fn = 50);
      }


      translate([-10, 5, 0]) {
        sphere($fn = 50);
      }

      translate([-5, 10, 0]) {
        sphere($fn = 50);
      }

      translate([-5, 5, 0]) {
        sphere($fn = 50);
      }
    }
}
