include <configuration.scad>
include <shapes.scad>


module limitSwitchHolder(height=8) {
    width = 17;
    length=22;

    support_height=5;
    tol=0.1;
  rotate([0,0,90])
  difference() {
    union() {
      translate([-width/2,-length/2,0]) roundedCube(size=[width,length,height]);
      // support
      translate([0,0,0]) roundedCylinder(d=13,h=height+support_height);
        // plate
//        color([1,0,0,1])
      translate([-width/2,-length/2-30,0])roundedCube([width,32,height]);
    }
    translate([-width/2+2,-length/2-25,height-1])roundedCube([width-4,15,height]);   
    // screw holes
    translate([0,-length/2-30+3,0])cylinder(d=m3_dia, h=height);
    translate([0,-length/2-30+22,0])cylinder(d=m3_dia, h=height);
    // rod hole
    cylinder(r=4+tol,h=height+support_height+2*tol);
    
    // clamp space
    translate([(-8-tol)/2,0,0-tol]) cube(size=[8+tol,length+tol,height+support_height + 2*tol]);
    translate([(-7-tol),2,height]) cube(size=[14+2*tol,12/2+tol,support_height+2*tol]);
    
   // screw hole
    translate([-width/2-tol,6,height/2]) rotate([0,90,0]) cylinder(d=m3_dia,h=width+2*tol);
    // nut space
    translate([-width/2-tol,6,height/2]) rotate([0,90,0]) rotate([0,0,30]) cylinder(r=m3_dia,h=1.3,$fn=6);
  }
}

$fs=0.3;
$fa=3;
limitSwitchHolder();