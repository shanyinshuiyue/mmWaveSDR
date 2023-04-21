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

%% Set TX/RX AWVs
if 1
    %% Set RX AWVs
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

    for beamRXIndex = 0:21
        Ishifters = uint16(awvTableRX28GHz(beamRXIndex+1,1:2:end));
        Qshifters = uint16(awvTableRX28GHz(beamRXIndex+1,2:2:end));
        IQshifters = typecast(swapbytes(Ishifters*64+Qshifters),'uint8');        
        write(tcpPortCMD,['setAWVRX ' num2str(beamRXIndex) ' ' num2str(IQshifters)],"uint8")
        getTheResponse(tcpPortCMD);

        if(0)
            write(tcpPortCMD,['getAWVRX ' num2str(beamRXIndex)],"uint8")
            getTheResponse(tcpPortCMD);
        end
    end

    %% Set TX AWVs
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

    for beamTXIndex = 0:21
        Ishifters = uint16(awvTableTX28GHz(beamTXIndex+1,1:2:end));
        Qshifters = uint16(awvTableTX28GHz(beamTXIndex+1,2:2:end));
        IQshifters = typecast(swapbytes(Ishifters*64+Qshifters),'uint8'); 
        write(tcpPortCMD,['setAWVTX ' num2str(beamTXIndex) ' ' num2str(IQshifters)],"uint8")
        getTheResponse(tcpPortCMD);  
        
        if(0)
            write(tcpPortCMD,['getAWVTX ' num2str(beamTXIndex)],"uint8")
            getTheResponse(tcpPortCMD); 
        end
    end
end
%% Choose the TX/RX beam indices between [0:21]
if 1 
    beamRXIndex = 11;
    write(tcpPortCMD,['setBeamIndexRX ' num2str(beamRXIndex)],"uint8")
    getTheResponse(tcpPortCMD);    

    write(tcpPortCMD,['getBeamIndexRX'],"uint8")
    getTheResponse(tcpPortCMD);    
    disp(['RX beam angle:' num2str(awvAngleRX28GHz(beamRXIndex+1))])    
    
    beamTXIndex = 11;
    write(tcpPortCMD,['setBeamIndexTX ' num2str(beamTXIndex)],"uint8")
    getTheResponse(tcpPortCMD);

    write(tcpPortCMD,['getBeamIndexTX'],"uint8")
    getTheResponse(tcpPortCMD);     

    disp(['TX beam angle:' num2str(awvAngleRX28GHz(beamTXIndex+1))])    
end

%% Set TX/RX gains
if 1
    if(1)
        rx_gain_ctrl_bb1 = 0x44;
        rx_gain_ctrl_bb2 = 0x11;
        rx_gain_ctrl_bb3 = 0x11;
        rx_gain_ctrl_bfrf = 0x77;
        write(tcpPortCMD,['setGainRX ' num2str(rx_gain_ctrl_bb1) ' ' num2str(rx_gain_ctrl_bb1) ' ' num2str(rx_gain_ctrl_bb1) ' ' num2str(rx_gain_ctrl_bfrf)],"uint8")
        getTheResponse(tcpPortCMD);   
    end
    write(tcpPortCMD,['getGainRX'],"uint8")
    getTheResponse(tcpPortCMD);       

     
    if(1)
        tx_bb_gain = 0x00;
        tx_bb_phase = 0x00;
        tx_bb_iq_gain = 0x77;
        tx_bfrf_gain = 0x77;
        write(tcpPortCMD,['setGainTX ' num2str(tx_bb_gain) ' ' num2str(tx_bb_phase) ' ' num2str(tx_bb_iq_gain) ' ' num2str(tx_bfrf_gain)],"uint8")
        getTheResponse(tcpPortCMD);       
    end
    write(tcpPortCMD,['getGainTX'],"uint8")
    getTheResponse(tcpPortCMD);      
end

%% Reception
if 1
    % Set the behaviour
    write(tcpPortCMD,'setModeSiver RXen1_TXen0',"uint8")
    getTheResponse(tcpPortCMD);

    modeRX = 1; % 0: STR, 1: WTR
    numIQdataSamplesPerTransfer = 1000
    write(tcpPortCMD,['setupReception' ' ' num2str(modeRX) ' ' num2str(numIQdataSamplesPerTransfer)],"uint8")
    getTheResponse(tcpPortCMD);



    % set the receiver enable flag
    flag = 1; %0: disable RX, 1: enable RX
    write(tcpPortCMD,['setTransferEnableRXFlag ' num2str(flag)],"uint8")
    getTheResponse(tcpPortCMD);

    % receive the IQ samples
    while 1
        % get # of available transfer to pull
        write(tcpPortCMD,'getNumberOfAvailableTransfers',"uint8")
        response = getTheResponse(tcpPortCMD);


        beamRXIndex = mod(beamRXIndex+1,21);
        write(tcpPortCMD,['setBeamIndexRX ' num2str(beamRXIndex)],"uint8")
        getTheResponse(tcpPortCMD);    

        responseSplit = strsplit((response));
        numberOfAvailableTransfers = num2str(responseSplit{1});
        if numberOfAvailableTransfers>0
            numberOfTransfers = 1; % 1 transfer
            timeOut = 5; % seconds
            write(tcpPortCMD,['receiveIQSamples' ' ' num2str(numberOfTransfers) ' ' num2str(timeOut)],"uint8")
            response= getTheResponse(tcpPortCMD);
            if contains(response,'Success')
                IQdata = readIQData(tcpPortDATA,numIQdataSamplesPerTransfer);
                IQDataAnalyzer(IQdata)
            end
        else
            disp('Not received...')
        end
        
    end

    % Set the behaviour
    write(tcpPortCMD,'setModeSiver RXen0_TXen0',"uint8")
    getTheResponse(tcpPortCMD);    
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

