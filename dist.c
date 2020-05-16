#include <stdio.h>
#include <wiringPi.h>
#include <wiringPiSPI.h>
#include <time.h>

// define pi GPIO
#define GPIO_TRIGGER 23
#define GPIO_ECHO    24



double measure(){
    /* measure distance */
    digitalWrite(GPIO_TRIGGER, 0);
    sleep(0.00001);
    digitalWrite(GPIO_TRIGGER, 0);
    time_t start, stop; 

    while(digitalRead(GPIO_ECHO) == 0){
        start = time(NULL);
    }
    while(digitalRead(GPIO_ECHO) == 1){
        stop = time(NULL);
    }

    long int total_Time = stop - start;

    double distance = (total_Time * 34300) / 2;
    return distance;
}

void main(void)
{
    wiringPiSetup();
    wiringPiSetupGpio();
    init_pins();

    // output pin: Trigger
    pinMode(GPIO_TRIGGER, OUTPUT);
    // input  pin: Echo
    pinMode(GPIO_ECHO   , INPUT);

    // initialize trigger pin to low
    digitalWrite(GPIO_TRIGGER, 0);


    for(;;){
        double distance = measure();
        printf("Distance: %.1f cm.\n", distance);
    }

    cleanup();
}