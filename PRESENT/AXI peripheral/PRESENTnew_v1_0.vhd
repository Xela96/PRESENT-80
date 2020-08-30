library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PRESENTnew_v1_0 is
	generic (
		-- Users to add parameters here

		-- User parameters ends
		-- Do not modify the parameters beyond this line


		-- Parameters of Axi Slave Bus Interface S00_AXI
		C_S00_AXI_DATA_WIDTH	: integer	:= 32;
		C_S00_AXI_ADDR_WIDTH	: integer	:= 5
	);
	port (
		-- Users to add ports here
        pt_clk:        out std_logic;
        pt_reset:      out std_logic;
        pt_addra:      out std_logic_vector(31 downto 0);
        pt_wr_data:    out std_logic_vector(63 downto 0);
        pt_read_data:  in std_logic_vector(63 downto 0);
        pt_e:          out std_logic;
        pt_we:         out std_logic_vector(7 downto 0);
        
        ct_clk:        out std_logic;
        ct_reset:      out std_logic;
        ct_addra:      out std_logic_vector(31 downto 0);
        ct_wr_data:    out std_logic_vector(63 downto 0);
        ct_read_data:  in std_logic_vector(63 downto 0);
        ct_e:          out std_logic;
        ct_we:         out std_logic_vector(7 downto 0);
		-- User ports ends
		-- Do not modify the ports beyond this line


		-- Ports of Axi Slave Bus Interface S00_AXI
		s00_axi_aclk	: in std_logic;
		s00_axi_aresetn	: in std_logic;
		s00_axi_awaddr	: in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
		s00_axi_awprot	: in std_logic_vector(2 downto 0);
		s00_axi_awvalid	: in std_logic;
		s00_axi_awready	: out std_logic;
		s00_axi_wdata	: in std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
		s00_axi_wstrb	: in std_logic_vector((C_S00_AXI_DATA_WIDTH/8)-1 downto 0);
		s00_axi_wvalid	: in std_logic;
		s00_axi_wready	: out std_logic;
		s00_axi_bresp	: out std_logic_vector(1 downto 0);
		s00_axi_bvalid	: out std_logic;
		s00_axi_bready	: in std_logic;
		s00_axi_araddr	: in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
		s00_axi_arprot	: in std_logic_vector(2 downto 0);
		s00_axi_arvalid	: in std_logic;
		s00_axi_arready	: out std_logic;
		s00_axi_rdata	: out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
		s00_axi_rresp	: out std_logic_vector(1 downto 0);
		s00_axi_rvalid	: out std_logic;
		s00_axi_rready	: in std_logic;
		
		done_interrupt  : out std_logic
	);
end PRESENTnew_v1_0;


architecture arch_imp of PRESENTnew_v1_0 is

    signal key : std_logic_vector(79 downto 0);
    signal pulse : std_logic;
    signal blocks : std_logic_vector(10 downto 0);
    signal done_pulse : std_logic;
    
    signal core_plaintext : std_logic_vector(63 downto 0);
    signal core_load : std_logic;
    signal core_key : std_logic_vector(79 downto 0);
    signal core_ciphertext : std_logic_vector(63 downto 0);    

	-- component declaration
	component PRESENTnew_v1_0_S00_AXI is
		generic (
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		C_S_AXI_ADDR_WIDTH	: integer	:= 5
		);
		port (
		key : out std_logic_vector(79 downto 0);
		pulse : out std_logic;
		blocks : out std_logic_vector(10 downto 0);
		
		S_AXI_ACLK	: in std_logic;
		S_AXI_ARESETN	: in std_logic;
		S_AXI_AWADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
		S_AXI_AWVALID	: in std_logic;
		S_AXI_AWREADY	: out std_logic;
		S_AXI_WDATA	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_WSTRB	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		S_AXI_WVALID	: in std_logic;
		S_AXI_WREADY	: out std_logic;
		S_AXI_BRESP	: out std_logic_vector(1 downto 0);
		S_AXI_BVALID	: out std_logic;
		S_AXI_BREADY	: in std_logic;
		S_AXI_ARADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_ARPROT	: in std_logic_vector(2 downto 0);
		S_AXI_ARVALID	: in std_logic;
		S_AXI_ARREADY	: out std_logic;
		S_AXI_RDATA	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_RRESP	: out std_logic_vector(1 downto 0);
		S_AXI_RVALID	: out std_logic;
		S_AXI_RREADY	: in std_logic
		);
	end component PRESENTnew_v1_0_S00_AXI;
	
    component PRESENT
    Port ( textIn : in STD_LOGIC_VECTOR (64-1 downto 0);
           textOut : out STD_LOGIC_VECTOR (64-1 downto 0);
           key : in STD_LOGIC_VECTOR (80-1 downto 0);
           clock : in STD_LOGIC;
           load : in STD_LOGIC;
           reset : in STD_LOGIC);
    end component;
    
    component FSM
    Port ( clk:        in std_logic;
         reset:      in std_logic;
         key:        in std_logic_vector(80-1 downto 0);
         pulse:      in std_logic;
         blocks:     in std_logic_vector(10 downto 0);
         done_intr:  out std_logic;
         
         pt_clk:        out std_logic;
         pt_reset:      out std_logic;
         pt_addra:      out std_logic_vector(31 downto 0);
         pt_wr_data:    out std_logic_vector(63 downto 0);
         pt_read_data:  in std_logic_vector(63 downto 0);
         pt_e:          out std_logic;
         pt_we:         out std_logic_vector(7 downto 0);
         
         ct_clk:        out std_logic;
         ct_reset:      out std_logic;
         ct_addra:      out std_logic_vector(31 downto 0);
         ct_wr_data:    out std_logic_vector(63 downto 0);
         ct_read_data:  in std_logic_vector(63 downto 0);
         ct_e:          out std_logic;
         ct_we:         out std_logic_vector(7 downto 0);
         
         core_plaintext: out std_logic_vector(63 downto 0);
         core_load : out std_logic;
         core_key: out std_logic_vector(79 downto 0);
         core_ciphertext: in std_logic_vector(63 downto 0)                       
    );
    end component;

begin

-- Instantiation of Axi Bus Interface S00_AXI
PRESENTnew_v1_0_S00_AXI_inst : PRESENTnew_v1_0_S00_AXI
	generic map (
		C_S_AXI_DATA_WIDTH	=> C_S00_AXI_DATA_WIDTH,
		C_S_AXI_ADDR_WIDTH	=> C_S00_AXI_ADDR_WIDTH
	)
	port map (
	   key => key,
	   pulse => pulse,
	   blocks => blocks,
		S_AXI_ACLK	=> s00_axi_aclk,
		S_AXI_ARESETN	=> s00_axi_aresetn,
		S_AXI_AWADDR	=> s00_axi_awaddr,
		S_AXI_AWPROT	=> s00_axi_awprot,
		S_AXI_AWVALID	=> s00_axi_awvalid,
		S_AXI_AWREADY	=> s00_axi_awready,
		S_AXI_WDATA	=> s00_axi_wdata,
		S_AXI_WSTRB	=> s00_axi_wstrb,
		S_AXI_WVALID	=> s00_axi_wvalid,
		S_AXI_WREADY	=> s00_axi_wready,
		S_AXI_BRESP	=> s00_axi_bresp,
		S_AXI_BVALID	=> s00_axi_bvalid,
		S_AXI_BREADY	=> s00_axi_bready,
		S_AXI_ARADDR	=> s00_axi_araddr,
		S_AXI_ARPROT	=> s00_axi_arprot,
		S_AXI_ARVALID	=> s00_axi_arvalid,
		S_AXI_ARREADY	=> s00_axi_arready,
		S_AXI_RDATA	=> s00_axi_rdata,
		S_AXI_RRESP	=> s00_axi_rresp,
		S_AXI_RVALID	=> s00_axi_rvalid,
		S_AXI_RREADY	=> s00_axi_rready
	);

	-- Add user logic here
    Present_core : PRESENT
    port map (
        textIn => core_plaintext,
        textOut => core_ciphertext,
        key => core_key,
        clock => s00_axi_aclk,
        load => core_load,
        reset => s00_axi_aresetn
    );
    
    FSM_inst : FSM
    port map (
        clk => s00_axi_aclk,
         reset => s00_axi_aresetn,
         key  => key,
         pulse => pulse,
         blocks => blocks,
         done_intr => done_interrupt,
         
         pt_clk => pt_clk,
         pt_reset => pt_reset,
         pt_addra => pt_addra,
         pt_wr_data => pt_wr_data,
         pt_read_data => pt_read_data,
         pt_e => pt_e,
         pt_we => pt_we,
         
         ct_clk => ct_clk,
         ct_reset => ct_reset,
         ct_addra => ct_addra,
         ct_wr_data => ct_wr_data,
         ct_read_data => ct_read_data,
         ct_e => ct_e,
         ct_we => ct_we,
         
         core_plaintext => core_plaintext,
         core_load => core_load,
         core_key => core_key,
         core_ciphertext => core_ciphertext
    );
    
	-- User logic ends

end arch_imp;
