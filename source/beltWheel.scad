
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


module wheelMount(radius, height, support_length) {
    // mount
    cylinder(r=radius, h=height);
    for(a=[00:60:359]) {
        // support
        rotate([0,0,a+30])translate([radius-1,2,1])rotate([90,0,0])linear_extrude(4)polygon([[0,0],[0,height/1.2],[support_length,0]]);
    }
}

module beltWheel(wheel_radius, wheel_height, mount_radius ) {
    flange = 1.5;
    module hexHole(r, h,edge=2)  {
        $fn=6;
        cylinder (r1=r-h+edge,r2=r+edge,h=h);
        cylinder (r2=r-h+edge,r1=r+edge,h=h);
        translate ([0,0,edge])cylinder (r=r,h=h-2*edge);
    } 
    
    difference() {
        union() {
            // wheel
            cylinder(r=wheel_radius+flange, h=wheel_height);
        }
        translate([0,0,wheel_height/2])rotate_extrude()translate([wheel_radius,0]){
            trapezoid(wheel_height-3,wheel_height-3-2*flange,flange);
            translate([1,-wheel_height/2])square([1,wheel_height]);
        }
        dist = (wheel_radius-4)/1.5;
        for(a=[0:60:300]) {
           rotate ([0,0,a]) {
               // hex holes
               translate ([dist,0,0]) rotate([0,0,30])hexHole(r=wheel_radius - 4 - dist,h=12, $fn=6 );
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

module beltWheelPipe(wheel_radius, wheel_height, mount_radius ) {
    difference() {
        union() {
            beltWheel(wheel_radius, wheel_height, mount_radius);
            wheelMount(radius=19, height=40, support_length=11);
            // limit switch interruptors
            rotate ([0,0,90])translate([wheel_radius-16,-3,wheel_height-1])cube(size=[1,6,7]);
        }
        cylinder(d=Drive_pipe_OD, h=40);
        for(a=[00:120:359]) {
            // m3 hole
            translate([0,0,25])rotate([0,90,a])cylinder(d=m4_dia, h=mount_radius);
            // m3 nut hole
            translate([0,0,25])rotate([0,90,a])cylinder(d=m4_nut_dia, h=Drive_pipe_OD/2+m4_nut_height, $fn=6);
        }
            
    }
}

module beltWheelRod(wheel_radius, wheel_height, mount_radius ) {
    difference() {
        union() {
            beltWheel(wheel_radius, wheel_height, mount_radius);
            wheelMount(radius=19, height=40, support_length=11);
            // limit switch interruptors
            rotate ([0,0,-30])translate([wheel_radius-16,-3,wheel_height-1])cube(size=[1,6,7]);
        }
        cylinder(d=m8_dia, h=40);
        cylinder(d=m8_nut_dia, h=m8_nut_height, $fn=6);
        translate([0,0,40-m8_nut_height])cylinder(d=m8_nut_dia, h=m8_nut_height, $fn=6);
    }
    // print support
    color([1,0,0,1])translate([0,0,m8_nut_height])cylinder(d=m8_nut_dia, h=print_layer_height);
    
            
}

$fs=0.3;
$fa=2;
beltWheelRod(75, 12, 19);
