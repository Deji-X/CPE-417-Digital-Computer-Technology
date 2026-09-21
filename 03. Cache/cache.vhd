library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity direct_mapped_cache is
    Port (
        clk      : in  std_logic;
        reset    : in  std_logic;

        read_en  : in  std_logic;
        address  : in  std_logic_vector(31 downto 0);

        data_out : out std_logic_vector(31 downto 0);
        hit      : out std_logic
    );
end direct_mapped_cache;

architecture Behavioral of direct_mapped_cache is

    type valid_array is array (0 to 3) of std_logic;
    type tag_array is array (0 to 3) of std_logic_vector(26 downto 0);
    type data_array is array (0 to 3) of std_logic_vector(63 downto 0);

    signal valid : valid_array := (others => '0');
    signal tag   : tag_array;
    signal data  : data_array;

    signal index : integer range 0 to 3;

begin

    -- Address:
    --
    -- [31:5] = TAG
    -- [4:3]  = INDEX
    -- [2:0]  = OFFSET

    index <= to_integer(unsigned(address(4 downto 3)));

    process(clk)
    begin

        if rising_edge(clk) then

            if reset = '1' then

                valid    <= (others => '0');
                data_out <= (others => '0');
                hit      <= '0';

            elsif read_en = '1' then

                if valid(index) = '1' and
                   tag(index) = address(31 downto 5) then

                    hit <= '1';

                    if unsigned(address(2 downto 0)) < 4 then
                        data_out <= data(index)(31 downto 0);
                    else
                        data_out <= data(index)(63 downto 32);
                    end if;

                else

                    hit      <= '0';
                    data_out <= (others => '0');

                end if;

            end if;

        end if;

    end process;

end Behavioral;
