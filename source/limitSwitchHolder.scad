include <configuration.scad>



module limitSwitchHolder(height=8) {
    width = 17;
    length=22;

    support_height=5;
    tol=0.1;
  rotate([0,0,90])
  difference() {
    union() {
      translate([-width/2,-length/2,0]) cube(size=[width,length,height]);
      // support
      translate([0,0,0]) cylinder(r=6.5+tol,h=height+support_height);
        // plate
        color([1,0,0,1])translate([-width/2,-length/2-30,0])cube([width,30,4]);
    }   
    // screw holes
    translate([0,-length/2-30+5,0])cylinder(d=m3_dia, h=4);
    translate([0,-length/2-30+24,0])cylinder(d=m3_dia, h=4);
    // rod hole
    cylinder(r=4+tol,h=height+support_height+2*tol);
    
    // klem gat
    translate([(-8-tol)/2,0,0-tol]) cube(size=[8+tol,length+tol,height+support_height + 2*tol]);

    // weggommen halve cirkel geleidingsbus
    translate([(-7-tol),2,height]) cube(size=[14+2*tol,12/2+tol,support_height+2*tol]);
//    translate([-10,6,1]) rotate([-30,0,0]) cube(size=[20,10,support_height]);
    
   // schroefgat
    translate([-width/2-tol,6,height/2]) rotate([0,90,0]) cylinder(r=1.5+tol*2,h=width+2*tol);
    translate([-width/2-tol,6,height/2]) rotate([0,90,0]) rotate([0,0,30]) cylinder($fn=6,r=3.25,h=1.3);
  }
}

$fs=0.3;
$fa=3;
limitSwitchHolder();