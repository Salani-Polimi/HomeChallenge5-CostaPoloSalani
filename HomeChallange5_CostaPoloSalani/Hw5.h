
#ifndef H_W_5_H
#define H_W_5_H

typedef nx_struct my_msg {
  nx_uint16_t value;
  nx_uint16_t topic;
} my_msg;



enum {
  AM_RADIO_COUNT_MSG = 6,
  MIN_VALUE=0,
  MAX_VALUE=100,
};

#endif
