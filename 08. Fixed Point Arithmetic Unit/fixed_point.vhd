library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fixed_point_unit is
    Port (
        A      : in  signed(15 downto 0);
        B      : in  signed(15 downto 0);

        opcode : in  std_logic_vector(1 downto 0);

        result : out signed(15 downto 0)
    );
end fixed_point_unit;

architecture Behavioral of fixed_point_unit is

    signal multiplication_result :
        signed(31 downto 0);

begin

    process(A, B, opcode)

        variable temp : signed(31 downto 0);

    begin

        case opcode is

            -- Addition
            when "00" =>
                result <= A + B;

            -- Subtraction
            when "01" =>
                result <= A - B;

            -- Multiplication
            when "10" =>

                temp := A * B;

                -- Q8.8 × Q8.8 = Q16.16
                -- Shift right by 8
                result <= temp(23 downto 8);

            -- Pass A
            when "11" =>
                result <= A;

            when others =>
                result <= (others => '0');

        end case;

    end process;

end Behavioral;
