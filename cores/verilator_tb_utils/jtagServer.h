#ifndef __JTAG_SERVER_H__
#define __JTAG_SERVER_H__

#define XFERT_MAX_SIZE		512

#define DONE			0
#define IN_PROGRESS		1

#define CMD_RESET		0
#define CMD_TMS_SEQ		1
#define CMD_SCAN_CHAIN		2
#define CMD_SCAN_CHAIN_FLIP_TMS	3
#define CMD_STOP_SIMU		4

#define CHECK_CMD		0
#define TAP_RESET		1
#define GOTO_IDLE		2
#define DO_TMS_SEQ		3
#define SCAN_CHAIN		4
#define FINISHED		5

struct jtag_cmd {
	int cmd;
	unsigned char buffer_out[XFERT_MAX_SIZE];
	unsigned char buffer_in[XFERT_MAX_SIZE];
	int length;
	int nb_bits;
};

class VerilatorJtagServer {
public:
	VerilatorJtagServer(uint64_t period);
	~VerilatorJtagServer();

	int doJTAG(uint64_t t, uint8_t *tms, uint8_t *tdi, uint8_t *tck, uint8_t tdo);
	int init_jtag_server(int port);

private:
	int check_for_command(struct jtag_cmd *vpi);
	int send_result_to_server(struct jtag_cmd *packet);

	int gen_clk(uint64_t t, int nb_period, uint8_t *tck, uint8_t tdo, uint8_t *captured_tdo, int restart, int get_tdo);
	void gen_clk_restart(void);
	int reset_tap(uint64_t t, uint8_t *tms, uint8_t *tck);
	int goto_run_test_idle(uint64_t t, uint8_t *tms, uint8_t *tck);
	int do_tms_seq(uint64_t t, int length, int nb_bits, unsigned char *buffer, uint8_t *tms, uint8_t *tck);
	int do_scan_chain(uint64_t t, int length, int nb_bits, unsigned char *buffer_out,
			  unsigned char *buffer_in, uint8_t *tms, uint8_t *tck, uint8_t *tdi, uint8_t tdo, int flip_tms);

	int listenfd;
	int connfd;
	struct jtag_cmd packet;

	int jtag_state;
	int cmd_in_progress;
	int tms_flip;
	uint64_t tck_period;
};

#endif
