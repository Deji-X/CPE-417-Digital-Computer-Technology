library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity simple_paging is
    Port (
        virtual_address  : in  std_logic_vector(31 downto 0);

        physical_address : out std_logic_vector(31 downto 0);
        page_fault       : out std_logic
    );
end simple_paging;

architecture Behavioral of simple_paging is

    type page_table_type is
        array (0 to 3) of std_logic_vector(19 downto 0);

    signal page_table : page_table_type;

    signal valid : std_logic_vector(3 downto 0);

    signal page_index : integer range 0 to 3;

begin

    page_index <= to_integer(
        unsigned(virtual_address(13 downto 12))
    );

    -- Example page table

    page_table(0) <= x"00100";
    page_table(1) <= x"00200";
    page_table(2) <= x"00300";
    page_table(3) <= x"00400";

    valid <= "1111";

    page_fault <= not valid(page_index);

    process(page_index, virtual_address, valid, page_table)
    begin

        if valid(page_index) = '1' then

            physical_address <=
                page_table(page_index) &
                virtual_address(11 downto 0);

        else

            physical_address <= (others => '0');

        end if;

    end process;

end Behavioral;
