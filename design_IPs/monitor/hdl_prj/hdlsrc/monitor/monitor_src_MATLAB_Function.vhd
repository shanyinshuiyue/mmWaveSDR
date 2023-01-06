-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\monitor\monitor_src_MATLAB_Function.vhd
-- Created: 2022-08-29 17:43:08
-- 
-- Generated by MATLAB 9.12 and HDL Coder 3.20
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: monitor_src_MATLAB_Function
-- Source Path: monitor/monitor/MATLAB Function
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY monitor_src_MATLAB_Function IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        dataWriteAXI0                     :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
        dataWriteAXI1                     :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
        dataWriteAXI2                     :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
        dataWriteAXI3                     :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
        dataWriteAXI4                     :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
        dataWriteAXI5                     :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
        dataWriteAXI6                     :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
        dataWriteAXI7                     :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
        dataRead0                         :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
        dataRead1                         :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
        dataRead2                         :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
        dataRead3                         :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
        dataRead4                         :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
        dataRead5                         :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
        dataRead6                         :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
        dataRead7                         :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
        dataWrite0                        :   OUT   std_logic_vector(31 DOWNTO 0);  -- uint32
        dataWrite1                        :   OUT   std_logic_vector(31 DOWNTO 0);  -- uint32
        dataWrite2                        :   OUT   std_logic_vector(31 DOWNTO 0);  -- uint32
        dataWrite3                        :   OUT   std_logic_vector(31 DOWNTO 0);  -- uint32
        dataWrite4                        :   OUT   std_logic_vector(31 DOWNTO 0);  -- uint32
        dataWrite5                        :   OUT   std_logic_vector(31 DOWNTO 0);  -- uint32
        dataWrite6                        :   OUT   std_logic_vector(31 DOWNTO 0);  -- uint32
        dataWrite7                        :   OUT   std_logic_vector(31 DOWNTO 0);  -- uint32
        dataReadAXI0                      :   OUT   std_logic_vector(31 DOWNTO 0);  -- uint32
        dataReadAXI1                      :   OUT   std_logic_vector(31 DOWNTO 0);  -- uint32
        dataReadAXI2                      :   OUT   std_logic_vector(31 DOWNTO 0);  -- uint32
        dataReadAXI3                      :   OUT   std_logic_vector(31 DOWNTO 0);  -- uint32
        dataReadAXI4                      :   OUT   std_logic_vector(31 DOWNTO 0);  -- uint32
        dataReadAXI5                      :   OUT   std_logic_vector(31 DOWNTO 0);  -- uint32
        dataReadAXI6                      :   OUT   std_logic_vector(31 DOWNTO 0);  -- uint32
        dataReadAXI7                      :   OUT   std_logic_vector(31 DOWNTO 0)  -- uint32
        );
END monitor_src_MATLAB_Function;


ARCHITECTURE rtl OF monitor_src_MATLAB_Function IS

  -- Signals
  SIGNAL dataWriteAXI0_unsigned           : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL dataWriteAXI1_unsigned           : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL dataWriteAXI2_unsigned           : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL dataWriteAXI3_unsigned           : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL dataWriteAXI4_unsigned           : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL dataWriteAXI5_unsigned           : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL dataWriteAXI6_unsigned           : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL dataWriteAXI7_unsigned           : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL dataRead0_unsigned               : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL dataRead1_unsigned               : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL dataRead2_unsigned               : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL dataRead3_unsigned               : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL dataRead4_unsigned               : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL dataRead5_unsigned               : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL dataRead6_unsigned               : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL dataRead7_unsigned               : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL dataWrite0_tmp                   : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL dataWrite1_tmp                   : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL dataWrite2_tmp                   : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL dataWrite3_tmp                   : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL dataWrite4_tmp                   : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL dataWrite5_tmp                   : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL dataWrite6_tmp                   : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL dataWrite7_tmp                   : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL dataReadAXI0_tmp                 : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL dataReadAXI1_tmp                 : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL dataReadAXI2_tmp                 : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL dataReadAXI3_tmp                 : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL dataReadAXI4_tmp                 : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL dataReadAXI5_tmp                 : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL dataReadAXI6_tmp                 : unsigned(31 DOWNTO 0);  -- uint32
  SIGNAL dataReadAXI7_tmp                 : unsigned(31 DOWNTO 0);  -- uint32

BEGIN
  dataWriteAXI0_unsigned <= unsigned(dataWriteAXI0);

  dataWriteAXI1_unsigned <= unsigned(dataWriteAXI1);

  dataWriteAXI2_unsigned <= unsigned(dataWriteAXI2);

  dataWriteAXI3_unsigned <= unsigned(dataWriteAXI3);

  dataWriteAXI4_unsigned <= unsigned(dataWriteAXI4);

  dataWriteAXI5_unsigned <= unsigned(dataWriteAXI5);

  dataWriteAXI6_unsigned <= unsigned(dataWriteAXI6);

  dataWriteAXI7_unsigned <= unsigned(dataWriteAXI7);

  dataRead0_unsigned <= unsigned(dataRead0);

  dataRead1_unsigned <= unsigned(dataRead1);

  dataRead2_unsigned <= unsigned(dataRead2);

  dataRead3_unsigned <= unsigned(dataRead3);

  dataRead4_unsigned <= unsigned(dataRead4);

  dataRead5_unsigned <= unsigned(dataRead5);

  dataRead6_unsigned <= unsigned(dataRead6);

  dataRead7_unsigned <= unsigned(dataRead7);

  MATLAB_Function_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      dataWrite0_tmp <= to_unsigned(16#00000000#, 32);
      dataWrite1_tmp <= to_unsigned(16#00000000#, 32);
      dataWrite2_tmp <= to_unsigned(16#00000000#, 32);
      dataWrite3_tmp <= to_unsigned(16#00000000#, 32);
      dataWrite4_tmp <= to_unsigned(16#00000000#, 32);
      dataWrite5_tmp <= to_unsigned(16#00000000#, 32);
      dataWrite6_tmp <= to_unsigned(16#00000000#, 32);
      dataWrite7_tmp <= to_unsigned(16#00000000#, 32);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        dataWrite0_tmp <= dataWriteAXI0_unsigned;
        dataWrite1_tmp <= dataWriteAXI1_unsigned;
        dataWrite2_tmp <= dataWriteAXI2_unsigned;
        dataWrite3_tmp <= dataWriteAXI3_unsigned;
        dataWrite4_tmp <= dataWriteAXI4_unsigned;
        dataWrite5_tmp <= dataWriteAXI5_unsigned;
        dataWrite6_tmp <= dataWriteAXI6_unsigned;
        dataWrite7_tmp <= dataWriteAXI7_unsigned;
      END IF;
    END IF;
  END PROCESS MATLAB_Function_process;

  dataReadAXI0_tmp <= dataRead0_unsigned;
  dataReadAXI1_tmp <= dataRead1_unsigned;
  dataReadAXI2_tmp <= dataRead2_unsigned;
  dataReadAXI3_tmp <= dataRead3_unsigned;
  dataReadAXI4_tmp <= dataRead4_unsigned;
  dataReadAXI5_tmp <= dataRead5_unsigned;
  dataReadAXI6_tmp <= dataRead6_unsigned;
  dataReadAXI7_tmp <= dataRead7_unsigned;

  dataWrite0 <= std_logic_vector(dataWrite0_tmp);

  dataWrite1 <= std_logic_vector(dataWrite1_tmp);

  dataWrite2 <= std_logic_vector(dataWrite2_tmp);

  dataWrite3 <= std_logic_vector(dataWrite3_tmp);

  dataWrite4 <= std_logic_vector(dataWrite4_tmp);

  dataWrite5 <= std_logic_vector(dataWrite5_tmp);

  dataWrite6 <= std_logic_vector(dataWrite6_tmp);

  dataWrite7 <= std_logic_vector(dataWrite7_tmp);

  dataReadAXI0 <= std_logic_vector(dataReadAXI0_tmp);

  dataReadAXI1 <= std_logic_vector(dataReadAXI1_tmp);

  dataReadAXI2 <= std_logic_vector(dataReadAXI2_tmp);

  dataReadAXI3 <= std_logic_vector(dataReadAXI3_tmp);

  dataReadAXI4 <= std_logic_vector(dataReadAXI4_tmp);

  dataReadAXI5 <= std_logic_vector(dataReadAXI5_tmp);

  dataReadAXI6 <= std_logic_vector(dataReadAXI6_tmp);

  dataReadAXI7 <= std_logic_vector(dataReadAXI7_tmp);

END rtl;

