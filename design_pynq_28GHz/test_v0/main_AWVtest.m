clear all
close all 
clc

tcpPortCMD = tcpclient("192.168.10.5",8080);
tcpPortDATA = tcpclient("192.168.10.5",8081);
IQDataAnalyzer = objIQDataAnalyzer('fsample', 1536e6, ...
                                 'fcarrier', 0, ...
                                 'figurePositionsOption',2,...
                                 'figureLocationX', 1725, ...
                                 'figureLocationY', 700, ...
                                 'figureName', 'RX waveform' ...
                                 );
%% Basic connection test
if 1 
    % get FPGA filename
    write(tcpPortCMD,'getFGPABitStreamFileName',"uint8")
    getTheResponse(tcpPortCMD);

    % get Monitor registers
    write(tcpPortCMD,'getRegisters',"uint8")
    getTheResponse(tcpPortCMD);

    % Set frequency
    write(tcpPortCMD,['getCarrierFrequency'],"uint8")
    getTheResponse(tcpPortCMD);

    fc = 28e9;
    write(tcpPortCMD,['setCarrierFrequency ' num2str(fc)],"uint8")
    getTheResponse(tcpPortCMD);    
end

if 1
    awvAngleRX28GHz = [nan,-45.0,-40.5,-36.0,-31.5,-27.0,-22.5,-18.0,-13.5, -9.0, -4.5,  0.0,  4.5,  9.0, 13.5, 18.0, 22.5, 27.0, 31.5, 36.0, 40.5, 45.0];
    awvTableRX28GHz =[...
        0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x3F, 0x3F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F
        0x00, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x3F, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x00, 0x00, 0x3F
        0x00, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x3F, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x00, 0x3F, 0x3F, 0x00, 0x00
        0x00, 0x00, 0x3F, 0x3F, 0x00, 0x3F, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x3F, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x00, 0x3F, 0x3F, 0x00, 0x3F, 0x00, 0x00
        0x00, 0x00, 0x3F, 0x3F, 0x00, 0x3F, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x3F, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x3F, 0x3F, 0x3F, 0x00, 0x3F, 0x3F, 0x00
        0x00, 0x3F, 0x3F, 0x00, 0x3F, 0x3F, 0x3F, 0x3F, 0x00, 0x3F, 0x00, 0x3F, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x3F, 0x3F, 0x3F, 0x00, 0x3F, 0x3F, 0x00
        0x00, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x3F, 0x3F, 0x3F, 0x00, 0x3F, 0x3F, 0x3F, 0x3F, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x3F, 0x00, 0x3F
        0x00, 0x00, 0x3F, 0x3F, 0x00, 0x3F, 0x00, 0x3F, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x3F, 0x3F, 0x3F, 0x00, 0x3F, 0x3F, 0x00, 0x3F, 0x00, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x3F, 0x00, 0x00
        0x00, 0x3F, 0x3F, 0x00, 0x00, 0x3F, 0x3F, 0x3F, 0x00, 0x00, 0x00, 0x3F, 0x3F, 0x3F, 0x3F, 0x00, 0x3F, 0x00, 0x3F, 0x3F, 0x3F, 0x3F, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x3F, 0x00, 0x00
        0x00, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x3F, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x3F, 0x00, 0x3F, 0x3F
        0x00, 0x00, 0x3F, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x3F, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x3F, 0x00, 0x00, 0x3F
        0x00, 0x3F, 0x3F, 0x3F, 0x00, 0x00, 0x00, 0x3F, 0x3F, 0x3F, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x3F, 0x00, 0x3F
        0x00, 0x3F, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x00
        0x3F, 0x3F, 0x3F, 0x00, 0x00, 0x3F, 0x3F, 0x3F, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x00
        0x00, 0x00, 0x00, 0x3F, 0x3F, 0x00, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x3F, 0x3F, 0x3F, 0x00, 0x3F, 0x3F, 0x00, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x3F, 0x3F, 0x00, 0x00
        0x00, 0x3F, 0x3F, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x00, 0x3F, 0x3F, 0x3F, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x3F, 0x3F, 0x00, 0x00
        0x3F, 0x3F, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x3F, 0x3F, 0x3F, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x3F, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x3F, 0x3F, 0x00, 0x00
        0x3F, 0x3F, 0x00, 0x00, 0x00, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x3F, 0x3F, 0x00, 0x00
        0x3F, 0x3F, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x3F, 0x3F, 0x3F, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x3F, 0x3F, 0x3F, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x3F, 0x00
        0x00, 0x00, 0x00, 0x3F, 0x3F, 0x3F, 0x3F, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x00, 0x3F, 0x00, 0x00
        0x00, 0x00, 0x3F, 0x3F, 0x3F, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x00, 0x3F, 0x00, 0x00
        0x00, 0x3F, 0x3F, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x3F, 0x3F, 0x00
        ];

    awvAngleTX28GHz = [nan,-45.0,-40.5,-36.0,-31.5,-27.0,-22.5,-18.0,-13.5, -9.0, -4.5,  0.0,  4.5,  9.0, 13.5, 18.0, 22.5, 27.0, 31.5, 36.0, 40.5, 45.0];
    awvTableTX28GHz =[...
        0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x3F, 0x3F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F
        0x3F, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x3F, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x3F, 0x00, 0x3F
        0x3F, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x3F, 0x3F, 0x3F, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x3F, 0x00, 0x3F, 0x00, 0x3F, 0x3F, 0x00
        0x3F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x3F, 0x3F, 0x3F, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x00, 0x3F, 0x3F, 0x3F, 0x3F, 0x00, 0x3F, 0x00, 0x00, 0x3F, 0x00
        0x00, 0x3F, 0x3F, 0x00, 0x3F, 0x3F, 0x3F, 0x00, 0x00, 0x3F, 0x3F, 0x3F, 0x00, 0x00, 0x00, 0x3F, 0x3F, 0x3F, 0x00, 0x3F, 0x00, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x00, 0x3F, 0x3F, 0x00, 0x00
        0x3F, 0x3F, 0x3F, 0x00, 0x3F, 0x00, 0x3F, 0x00, 0x3F, 0x3F, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x3F, 0x3F, 0x00, 0x3F, 0x00, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x00
        0x3F, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x3F, 0x3F, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x3F, 0x3F, 0x00, 0x3F, 0x00, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x3F, 0x00, 0x3F, 0x3F, 0x00
        0x3F, 0x3F, 0x3F, 0x00, 0x3F, 0x3F, 0x3F, 0x00, 0x00, 0x3F, 0x3F, 0x3F, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x3F, 0x00, 0x3F, 0x3F, 0x00, 0x3F, 0x3F
        0x3F, 0x00, 0x00, 0x3F, 0x3F, 0x00, 0x00, 0x00, 0x3F, 0x3F, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x3F, 0x00, 0x3F, 0x3F, 0x00, 0x3F, 0x3F
        0x3F, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x00, 0x00, 0x3F, 0x3F, 0x3F, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x00, 0x3F, 0x3F, 0x00, 0x3F, 0x00, 0x00, 0x3F, 0x3F, 0x00, 0x00
        0x3F, 0x00, 0x00, 0x3F, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x3F, 0x3F, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x00, 0x3F, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x00
        0x00, 0x3F, 0x3F, 0x00, 0x00, 0x3F, 0x3F, 0x3F, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x00, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x3F, 0x00, 0x3F, 0x3F, 0x00, 0x00, 0x3F
        0x3F, 0x3F, 0x3F, 0x00, 0x00, 0x3F, 0x3F, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x00, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x3F, 0x3F, 0x00, 0x3F
        0x3F, 0x00, 0x00, 0x00, 0x3F, 0x3F, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x00, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x3F, 0x3F, 0x00, 0x00
        0x00, 0x00, 0x3F, 0x3F, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x00, 0x3F, 0x00, 0x3F, 0x3F, 0x00, 0x3F, 0x00, 0x00, 0x3F, 0x3F, 0x00, 0x3F, 0x3F, 0x3F, 0x00, 0x3F
        0x00, 0x3F, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x3F, 0x3F, 0x3F, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x3F, 0x00, 0x3F, 0x00, 0x00, 0x3F, 0x3F, 0x00, 0x3F, 0x3F, 0x3F, 0x00, 0x3F
        0x00, 0x3F, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x3F, 0x3F, 0x3F, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x3F, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x3F, 0x3F, 0x00, 0x00
        0x3F, 0x3F, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x3F, 0x3F, 0x3F, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x00
        0x3F, 0x3F, 0x00, 0x00, 0x00, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x3F, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x3F, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x3F, 0x3F, 0x00
        0x00, 0x00, 0x00, 0x3F, 0x3F, 0x3F, 0x3F, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x3F, 0x3F, 0x00
        0x00, 0x00, 0x3F, 0x3F, 0x3F, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x3F, 0x3F, 0x00
        0x00, 0x3F, 0x3F, 0x3F, 0x3F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x00, 0x3F, 0x3F, 0x00
        ];    
end

%% RX AWV TEST
if 0
    for beamRXIndex = 0:1
        Ishifters = uint16(awvTableRX28GHz(beamRXIndex+1,1:2:end));
        Qshifters = uint16(awvTableRX28GHz(beamRXIndex+1,2:2:end));
        IQshifters = typecast(swapbytes(Ishifters*64+Qshifters),'uint8');    
        if(0)
            write(tcpPortCMD,['setAWVRX ' num2str(beamRXIndex) ' ' num2str(IQshifters)],"uint8")
            getTheResponse(tcpPortCMD);
        end
    
        if(1)
            write(tcpPortCMD,['getAWVRX ' num2str(beamRXIndex)],"uint8")
            getTheResponse(tcpPortCMD);
            disp(IQshifters)
        end
    end
end

%% TX AWV TEST
if 1
    for beamTXIndex = 0:10
        Ishifters = uint16(awvTableTX28GHz(beamTXIndex+1,1:2:end));
        Qshifters = uint16(awvTableTX28GHz(beamTXIndex+1,2:2:end));
        IQshifters = typecast(swapbytes(Ishifters*64+Qshifters),'uint8');    
        if(0)
            write(tcpPortCMD,['setAWVTX ' num2str(beamTXIndex) ' ' num2str(IQshifters)],"uint8")
            getTheResponse(tcpPortCMD);
        end
    
        if(1)
            write(tcpPortCMD,['getAWVTX ' num2str(beamTXIndex)],"uint8")
            getTheResponse(tcpPortCMD);
            disp(IQshifters)
        end
    end
end



%% function for test
function writeIQData(tcpPortDATA, IQdata)
    IQdataInt = int16([real(IQdata) imag(IQdata)]*2^13);
    write(tcpPortDATA,IQdataInt,"int16")
end

function IQdata = readIQData(tcpPortDATA,numIQdataSamples)
    expectedNumberOfBytes = numIQdataSamples*4;
    while  tcpPortDATA.NumBytesAvailable < expectedNumberOfBytes
    end
    data = typecast(read(tcpPortDATA),"int16");
    dataIandQ=double(data)*2^-11;
    IQdata = dataIandQ(1:end/2)+1i*dataIandQ(end/2+1:end);
end


function response = getTheResponse(tcpPortCMD)
    while tcpPortCMD.NumBytesAvailable == 0
    end
    response=char(typecast(read(tcpPortCMD),"uint8"));
    disp(response)
end