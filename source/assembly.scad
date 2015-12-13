include <configuration.scad>
include <platform.scad>
include <motorMount.scad>
include <driveWheel.scad>
include <ZMount.scad>

module assembly() {
    // base 
    linear_extrude(3)base();
    // motor mounts
    color([1,0,0,1])for (i=[1,-1]) {
        translate([i*(rodspacing/2-10),-50, 4])rotate([90+i*15,-90,0])MotorMount(Height=60+i*10);
    }
    // Zmount 
    translate([0,0,3])ZMountBottom(rodspacing = rodspacing, rodsize = rod_diameter, thickness = 3);
    // drive wheel
    translate([0,0,60])rotate([0,180,0])beltWheelRod(75);
    // drive wheel
    translate([0,0,70])beltWheelTube(75);

}

$fs = 0.2;
$fa = 2;

assembly();