
include <MCAD/polyholes.scad>
include <configuration.scad>

pi=3.1415926536;

module trapezoid(top, base, h) {
    polygon([[0,-base/2],[0,base/2],[h,top/2],[h,-top/2]]);
}

module beltSlot(height) {
    module thingy(width, height, length,r) {
        difference() {
            translate([-length/2,-length/2,0])cube([length,length,height]);
            translate([0,-r-width/2,0])cylinder(r=r, h=height);
            translate([0,r+width/2,0])cylinder(r=r, h=height);
        }
    }

    for (i=[-5:10:5]) {
        translate([0, i, 0]) {
            translate([0, 0, height-2]) cylinder(d=m3_nut_dia, h=2);
            cylinder(d=5.5, h=height);
            cylinder(d=m3_nut_dia, h=2, $fn=6);
            translate([4,0,2])thingy(width=2.8, height=height, length=8, r=8);
            }
    }
}



module beltWheel() {
    wheel_radius = 75;
    wheel_height = 12;
    
    module hexHole(r, h,edge=2)  {
        $fn=6;
        cylinder (r1=r-h+edge,r2=r+edge,h=h);
        cylinder (r2=r-h+edge,r1=r+edge,h=h);
        translate ([0,0,edge])cylinder (r=r,h=h-2*edge);
    } 
    
    difference() {
        union() {
            // wheel
            cylinder(r=wheel_radius+1, h=wheel_height);
            // mount
            cylinder(r=18, h=40);

            for(a=[00:60:359]) {
                // limit switch interruptors
                rotate ([0,0,a])translate([wheel_radius-1,-3,wheel_height])cube(size=[1,6,6]);
            }
                
        }
        translate([0,0,wheel_height/2])rotate_extrude()translate([wheel_radius,0]){
            trapezoid(wheel_height-2,wheel_height-4,1);
            translate([1,-wheel_height/2])square([1,wheel_height]);
        }
        for(a=[0:60:300]) {
           rotate ([0,0,a]) {
               // hex holes
               translate ([47,0,0]) rotate([0,0,30])hexHole(r=24,h=12, $fn=6 );
           }
        }
        // Belt slot
        rotate([0,0,30])translate([wheel_radius-6, 0, 0])beltSlot(wheel_height);
    }
    // print support
        color([1,0,0,1])for (i=[-5:10:5]) {
            rotate([0,0,30])translate([wheel_radius-6, i, 2-print_layer_height])cylinder(d=m3_nut_dia, h=print_layer_height);
        }
}

$fs=0.3;
$fa=3;
beltWheel();
//trapezoid(10,8,1);
//thingy();