import React from "react";

const caddyInput = `(Fold
  Diff
  (Map2
    Trans
    (MapI
      4
      (Vec3
        (+ (* (* i i) -5) (* i 15))
        (+ (* (* i i) -4.999949999999998) (* i 14.999849999999995))
        0))
    (List
      (Cube (Vec3 120 95 2.5) false)
      (Cube (Vec3 100 75 2.5) false)
      (Cube (Vec3 100 75 1) false)
      (Fold
        Union
        (Map2
          Trans
          (List
            (Vec3 77.6 35.975 0)
            (Vec3 44.300000000000004 35.975 0)
            (Vec3 10 35.975 0)
            (Vec3 44.300000000000004 10 0)
            (Vec3 77.6 10 0)
            (Vec3 10 10 0)
            (Vec3 44.300000000000004 60.94999999999999 0)
            (Vec3 10 60.94999999999999 0)
            (Vec3 77.6 60.94999999999999 0))
          (Map2
            Scale
            (List
              (Vec3 32.4 23.975 1)
              (Vec3 32.3 23.975 1)
              (Vec3 33.3 23.975 1)
              (Vec3 32.3 24.975 1)
              (Vec3 32.4 24.975 1)
              (Vec3 33.3 24.975 1)
              (Vec3 32.3 24.05 1)
              (Vec3 33.3 24.05 1)
              (Vec3 32.4 24.05 1))
            (Repeat 9 (Cube (Vec3 1 1 1) false))))))))`;

export default function CaddyEditor(props) {
  return (
    <div className="column">
      <h2>Caddy</h2>
      <button className="hidden">hide me</button>
      <textarea value={caddyInput}></textarea>
    </div>
  );
}
