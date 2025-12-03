--So for executiom, we have a RISC and CISC Architecture with
-- With RISC we have MIPs and ARM Architecture(ISA)
-- With CISC we have x86.
-- So I'll give you the vhdl code for them; understand this for a 32 bit system.



--               RISC               --

--MIPs--
entity MIPS_Core is
    Port (
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        -- Instruction memory interface
        instr_addr : out STD_LOGIC_VECTOR(31 downto 0);
        instr_data : in STD_LOGIC_VECTOR(31 downto 0);
        -- Data memory interface
        data_addr : out STD_LOGIC_VECTOR(31 downto 0);
        data_write : out STD_LOGIC;
        data_in : out STD_LOGIC_VECTOR(31 downto 0);
        data_out : in STD_LOGIC_VECTOR(31 downto 0)
    );
  end MIPS_Core;
  
--ARM--
  entity ARM_Core is
    Port (
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        -- Instruction memory interface
        instr_addr : out STD_LOGIC_VECTOR(31 downto 0);
        instr_data : in STD_LOGIC_VECTOR(31 downto 0);
        -- Data memory interface
        data_addr : out STD_LOGIC_VECTOR(31 downto 0);
        data_write : out STD_LOGIC;
        data_in : out STD_LOGIC_VECTOR(31 downto 0);
        data_out : in STD_LOGIC_VECTOR(31 downto 0)
    );
    end ARM_Core;





--               CISC               --

--x86--
entity ARM_Core is
    Port (
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        -- Instruction memory interface
        instr_addr : out STD_LOGIC_VECTOR(31 downto 0);
        instr_data : in STD_LOGIC_VECTOR(31 downto 0);
        -- Data memory interface
        data_addr : out STD_LOGIC_VECTOR(31 downto 0);
        data_write : out STD_LOGIC;
        data_in : out STD_LOGIC_VECTOR(31 downto 0);
        data_out : in STD_LOGIC_VECTOR(31 downto 0)
    );
end ARM_Core;
