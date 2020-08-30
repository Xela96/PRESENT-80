#include "xil_io.h"
#include "xbasic_types.h"
#include "driver.h"
#include "xtime_l.h"

int hwTest(int size, u32 *plaintext, u32 *key, u32 *result, XScuGic *intc, u32 *expected_result) {
	xil_printf("Plaintext: %x %x\n", plaintext[0], plaintext[1]);
	xil_printf("Key: %x %x %04x\n", key[0], key[1], key[2]);

	//setup & initiation
	setup(key, intc);

	//encryption
	begin(plaintext, size, result);

	while(ISRdone == 0){}

	ISRdone = 0;
	xil_printf("Ciphertext: %x %x\n", result[0], result[1]);

	if (result == expected_result)
		return 1; //pass
	else
		return 0; //fail
}

void performanceTest(XScuGic *intc){
	u32 plaintext[1024][2];
	u32 key[4];
	u32 ciphertext[1024][2];

	// Timer variables
	XTime start, end;
	int t;

	//Timing test
	XTime_GetTime(&start);
	setup(&key, intc);
	begin(&plaintext, &ciphertext, 1024);
	while(ISRdone == 0){}
	ISRdone = 0;
	XTime_GetTime(&end);

	t = (end-start)/COUNTS_PER_SECOND;
	printf("Computing time: %f s \n", t);
}

int main(){
	//Set test vectors
	u32 plaintext[2]  = {0x00000000, 0x00000000};
	u32 key[3]        = {0x00000000, 0x00000000, 0x0000};
	u32 result[2];
	int success;

	static XScuGic intc;
	success = hwTest(1, plaintext, key, result, &intc);

	performanceTest(&intc);

	return 0;
}

