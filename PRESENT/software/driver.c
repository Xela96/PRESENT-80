/*
 * driver.c
 *
 *  Created on: 29 Aug 2020
 *      Author: 96doh
 */
#include "xparameters.h" //contains base address
#include "xil_io.h"
#include "xbasic_types.h"
#include "driver.h"
#include "xtime_l.h" //for sleep routines
#include "PRESENTnew.h" //contains slave register offsets
#include "xscugic.h" //general interrupt controller

int blocks, ISRdone;
u32 PRESENToutput[2048]; //blocks that can be stored in BRAM
u32 key[1024];

void isr(){
	//set output of system
	for(int i=0; i<blocks;i++){
		PRESENToutput[2*i] = Xil_In32(XPAR_PRESENTNEW_0_S00_AXI_BASEADDR+(4 + (i*8))); // upper 32 bits of output ciphertext
		PRESENToutput[(2*i)+1] = XPAR_PRESENTNEW_0_S00_AXI_BASEADDR + (i*8); // lower 32 bits of output ciphertext
	}
	//set ISR to 1 as outputs have all been stored and ISR complete
	ISRdone = 1;
}

//setup and initialisation for ISR, GIC and key value
void setup(u32 key[1024], XScuGic *intc){

	//reset ISR
	ISRdone = 0;

	XScuGic *intcPtr=intc;
	//GIC configuration
	XScuGic_Config *Config;

	XScuGic_LookupConfig(XPAR_PS7_SCUGIC_0_DEVICE_ID); //device parameter defined in xparameters.h

	//initialises a GIC controller instance
	XScuGic_CfgInitialize(intcPtr, Config,
									Config->CpuBaseAddress);

	//connects the fabric interrupt to handler
	XScuGic_Connect(intcPtr, XPAR_FABRIC_PRESENTNEW_0_DONE_INTERRUPT_INTR, (Xil_ExceptionHandler)isr(), (void *) intcPtr);

	//setup/initialise exceptions
	Xil_ExceptionInit();
	Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT, (Xil_ExceptionHandler)XScuGic_InterruptHandler, intcPtr);
	Xil_ExceptionEnable();

	//enables the interrupt from the provided source (arg 2)
	XScuGic_Enable(intcPtr, XPAR_FABRIC_PRESENTNEW_0_DONE_INTERRUPT_INTR);

	//set key value
	Xil_Out32(XPAR_PRESENTNEW_0_S00_AXI_BASEADDR+PRESENTNEW_S00_AXI_SLV_REG3_OFFSET, key[0]);  //set upper 32 bits of key
	Xil_Out32(XPAR_PRESENTNEW_0_S00_AXI_BASEADDR+PRESENTNEW_S00_AXI_SLV_REG4_OFFSET, key[1]);  //set middle 32 bits of key
	Xil_Out32(XPAR_PRESENTNEW_0_S00_AXI_BASEADDR+PRESENTNEW_S00_AXI_SLV_REG5_OFFSET, key[2]);  //set lower 16 bits of key
}

void begin(u32 plaintext[1024], int size, u32 ciphertext[1024]){
	//setup plaintext value to appropriate BRAM
	for (int i=0; i<size; i++) {
			Xil_Out32(XPAR_AXI_BRAM_CTRL_0_S_AXI_BASEADDR+(4+(i*8)), plaintext[i]);
			Xil_Out32(XPAR_AXI_BRAM_CTRL_0_S_AXI_BASEADDR+(i*8), plaintext[i+1]);
	}

	//Set pulse in control register
	u32 pulseValue = ((size<<1) & 0xFFE) | 0x1;
	Xil_Out32(XPAR_PRESENTNEW_0_S00_AXI_BASEADDR+PRESENTNEW_S00_AXI_SLV_REG0_OFFSET, pulseValue);

	for (int i=0; i<1024; i++) {
		PRESENToutput[2*i]=ciphertext[2*i];
		PRESENToutput[(2*i)+1]=ciphertext[(2*i)+1];
	}

	blocks=size;

	//reset pulse
	Xil_Out32(XPAR_PRESENTNEW_0_S00_AXI_BASEADDR+PRESENTNEW_S00_AXI_SLV_REG0_OFFSET, (pulseValue & 0xFFFFFFFE));
}
