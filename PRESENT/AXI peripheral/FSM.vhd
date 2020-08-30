library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity FSM is
  Port ( clk:        in std_logic;
         reset:      in std_logic;
         key:        in std_logic_vector(80-1 downto 0);
         pulse:      in std_logic;
         blocks:     in std_logic_vector(10 downto 0);
         done_intr:  out std_logic:= '0';
         
         pt_clk:        out std_logic;
         pt_reset:      out std_logic;
         pt_addra:      out std_logic_vector(31 downto 0):= x"00000000";
         pt_wr_data:    out std_logic_vector(63 downto 0);
         pt_read_data:  in std_logic_vector(63 downto 0);
         pt_e:          out std_logic;
         pt_we:         out std_logic_vector(7 downto 0);
         
         ct_clk:        out std_logic;
         ct_reset:      out std_logic;
         ct_addra:      out std_logic_vector(31 downto 0):= x"00000000";
         ct_wr_data:    out std_logic_vector(63 downto 0):= x"0000000000000000";
         ct_read_data:  in std_logic_vector(63 downto 0);
         ct_e:          out std_logic;
         ct_we:         out std_logic_vector(7 downto 0):= x"00";
         
         core_plaintext: out std_logic_vector(63 downto 0);
         core_load : out std_logic:= '0';
         core_key: out std_logic_vector(79 downto 0);
         core_ciphertext: in std_logic_vector(63 downto 0)                       
);
end FSM;

architecture Behavioral of FSM is

type states is (INIT, READ, LOAD, BUSY, WRITE, DONE, RSVD1, RSVD2);

signal CURRENT_STATE: states;
signal NEXT_STATE: states;
signal count_s: std_logic_vector(4 downto 0);
signal current_block: std_logic_vector(10 downto 0);
signal current_address: std_logic_vector(31 downto 0);
signal enable_counter: std_logic;
signal inc_block_cnt: std_logic;


begin

    core_key <= key;
    core_plaintext <= pt_read_data;
    
    pt_clk <= clk;
    pt_reset <= NOT reset;
    pt_wr_data <= x"0000000000000000";
    pt_e <= '1';
    pt_we <= x"00"; 
    
    ct_clk <= clk;
    ct_reset <= NOT reset;
    ct_e <= '1';
    
    process(clk) is
    	begin
    	   if reset = '0' then 
    	       current_state <= INIT;
    	       
           else
               current_state <= NEXT_STATE;
    	   end if;
            
    end process;


    FSM: process(current_state, pulse, blocks) is
    	begin
    	   NEXT_STATE <= current_state;
    	   case current_state IS
    	   
    	       WHEN INIT =>
    	       if pulse = '1' then 
    	           NEXT_STATE <= READ;
               else
                   NEXT_STATE <= INIT;
               end if;
               
               WHEN READ =>
    	           NEXT_STATE <= LOAD;
    	           
               WHEN LOAD =>
    	           NEXT_STATE <= BUSY;	           
    	           
    	       WHEN BUSY =>
    	       if count_s = "11111" then 
    	           NEXT_STATE <= WRITE;  
               else
                   NEXT_STATE <= BUSY;
               end if;
               
               WHEN WRITE =>
    	       if current_block /= std_logic_vector(unsigned(blocks)-1) then 
    	           NEXT_STATE <= READ;    	       
               else
                   NEXT_STATE <= DONE;
               end if;
    	          	       
    	       WHEN DONE =>
    	           NEXT_STATE <= INIT;
    	           
    	       WHEN RSVD1 =>
    	           NEXT_STATE <= INIT;
    	           
    	       WHEN RSVD2 =>
    	           NEXT_STATE <= INIT;    
    	       
            end case;
    end process;
    
    LOGIC: process(current_address,core_ciphertext) is
        variable core_load_v: std_logic;
        variable done_intr_v : std_logic;
        variable pt_addra_v : std_logic_vector(31 downto 0);
        variable ct_addra_v : std_logic_vector(31 downto 0);
        variable ct_wr_data_v : std_logic_vector(63 downto 0);
        variable ct_we_v : std_logic_vector(7 downto 0);
    
    
        begin
            enable_counter <= '0';
            inc_block_cnt <= '0';         
            
            case current_state IS
    	   
    	       WHEN INIT =>
    	           null;
    	           
    	       WHEN READ => 
    	           pt_addra <= current_address;
    	           
               WHEN LOAD =>
    	           core_load <= '1';
                   
               WHEN BUSY =>
                   enable_counter <= '1';
                   
               WHEN WRITE =>
                   ct_addra <= current_address;
                   ct_wr_data <= core_ciphertext;
                   ct_we <= x"FF";
                   inc_block_cnt <= '1';
                   
               WHEN DONE =>
                   done_intr <= '1';  
                   
               WHEN RSVD1 =>
                   null;
               WHEN RSVD2 =>
                   null;                   
            end case;                   
        
    end process;
    
    
    Round_Counter: process(clk) is
        begin
            if reset = '0' then
                count_s <= "00001";
            elsif enable_counter = '0' then
                count_s <= "00001";
            elsif enable_counter = '1' then
                count_s <= std_logic_vector(unsigned(count_s)+1);             
            end if;        
        end process;

    Block_reg: process(clk) is
        begin    
            if (reset = '0' OR current_state = INIT) then
                current_block <= "00000000000";
                current_address <= x"00000000";
            elsif inc_block_cnt = '1' then
                current_block <= std_logic_vector(unsigned(current_block)+1); 
                current_address <= std_logic_vector(unsigned(current_address)+8); 
            end if;
        end process;
end Behavioral;
