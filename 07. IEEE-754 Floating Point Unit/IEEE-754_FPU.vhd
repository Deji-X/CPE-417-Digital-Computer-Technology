library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.FLOAT_PKG.ALL;

entity simple_fpu is
    Port (
        A      : in  float32;
        B      : in  float32;

        opcode : in  std_logic_vector(1 downto 0);

        result : out float32
    );
end simple_fpu;

architecture Behavioral of simple_fpu is

begin

    process(A, B, opcode)
    begin

        case opcode is

            when "00" =>
                result <= A + B;

            when "01" =>
                result <= A - B;

            when "10" =>
                result <= A * B;

            when "11" =>
                result <= A / B;

            when others =>
                result <= (others => '0');

        end case;

    end process;

end Behavioral;
