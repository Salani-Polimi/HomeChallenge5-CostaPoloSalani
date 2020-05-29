#include "Hw5.h"
#include "printf.h"
#include <stdio.h>

module Hw5C {
  uses {
    interface Boot;
    interface Leds;
    interface Receive; //interface receiving mx
    interface AMSend;  //int send packets
    interface Timer<TMilli> as Timer0;
    interface SplitControl as AMControl; //manage packet
    interface Packet;
    interface Leds as LedsC;
    interface Random;
    interface Init;
    interface ParameterInit<uint16_t> as SeedInit;
    
  }
}

implementation {
   
   message_t packet; //packet variable
  //booleans used to control the leads
  bool locked;
  int destination;
 
  uint16_t dummyVar1 = 0;
  uint16_t dummyVar2 = 0;
  uint16_t dummyVar3 = 0;
  uint16_t dummyVar4 = 0;
  

  event void Boot.booted() {
     call AMControl.start(); 
  }
  
  event void AMControl.startDone(error_t err) {
    if (err == SUCCESS) { //if radio starts badly
      switch(TOS_NODE_ID){
      case 1:
         
       	break;
       case 2:
        call Timer0.startPeriodic(5000);
       break;
       case 3:
        call Timer0.startPeriodic(5000);
       break;
     }
    }
    else {
      call AMControl.start();
    }
  }
  
  event void AMControl.stopDone(error_t err) {}

  event void Timer0.fired() {
    
    my_msg* rcm = (my_msg*)call Packet.getPayload(&packet, sizeof(my_msg));
    
    if(TOS_NODE_ID==2){
     rcm->topic=777;
     rcm->value=(rand()% (100-0))+0;
    }
    if(TOS_NODE_ID==3){
     rcm->topic=999;
     rcm->value=((rand()*rand())% (100-0))+0;
    }
    
    if (call AMSend.send(1, &packet, sizeof(my_msg)) == SUCCESS) {
    }
       
    
  }
  
  event void AMSend.sendDone(message_t* bufPtr, error_t error) {}
  
  event message_t* Receive.receive(message_t* bufPtr, 
				   void* payload, uint8_t len) {
    

    if (len != sizeof(my_msg)) {return bufPtr;}
    else {
      my_msg* rcm = (my_msg*)payload; 
      if(rcm->topic==999){
       dummyVar1=rcm->topic;
       dummyVar2=rcm->value;
  	   printf("MANDATO DA 3\n");
  	   printf("TOPIC: %u VALUE: %u\n", dummyVar1,dummyVar2);
  
  	   printfflush();
      }
      if(rcm->topic==777){
       dummyVar3=rcm->topic;
       dummyVar4=rcm->value;
  	   printf("MANDATO DA 2\n");
  	   printf("TOPIC: %u VALUE: %u\n", dummyVar3,dummyVar4);
  	   
  
  	   printfflush();
      }
    }
      
      return bufPtr;
    }    
}

