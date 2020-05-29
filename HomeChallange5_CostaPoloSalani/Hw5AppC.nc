#define NEW_PRINTF_SEMANTICS
#include "Hw5.h"

configuration Hw5AppC{
}
implementation {
  components LedsC;
  components MainC, Hw5C as App;
  components new TimerMilliC() as Timer0;
  components PrintfC;
  components ActiveMessageC;
  components SerialStartC;
  components new AMSenderC(AM_RADIO_COUNT_MSG);
  components new AMReceiverC(AM_RADIO_COUNT_MSG);
  

  App.Boot -> MainC;
  App.Receive -> AMReceiverC;
  App.AMSend -> AMSenderC;
  App.AMControl -> ActiveMessageC;
  App.Leds -> LedsC;
  App.Timer0 -> Timer0;
  App.Packet -> AMSenderC;
  App.LedsC -> LedsC;
  
}
