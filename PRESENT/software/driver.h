/*
 * driver.h
 *
 *  Created on: 29 Aug 2020
 *      Author: 96doh
 */

#ifndef SRC_DRIVER_H_
#define SRC_DRIVER_H_
#include "xscugic.h" //general interrupt controller

void isr();
void setup(u32 key[1024], XScuGic *intc);
void begin(u32 plaintext[1024], int length, u32 ciphertext[1024]);

#endif /* SRC_DRIVER_H_ */
