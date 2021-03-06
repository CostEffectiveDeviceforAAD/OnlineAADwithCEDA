# Online AAD with CEDA

CEDA is a cost-effective, open-source device for online auditory attention detection and consists of an EEG acquisition module, a sound player module and a sound trigger module.
This instruction contains information on how to implement CEDA. 

You can read more about the project here [paper address].

## Essential Modules
figure.1

### EEG Acquisition Module

 [OpenBCI board](https://openbci.com/?utm_source=google&utm_medium=cpc&utm_campaign=716348300&utm_content=openbci&gclid=Cj0KCQiA-eeMBhCpARIsAAZfxZBwfN8ei8seomxZ255WDN04UvwYix6hzXr-pJoc7drJViXE77-MirIaAnfWEALw_wcB) (Biosensingboard Cyton with Daisy) is used as EEG Acquisition Module. The EEG acquisition module acquire sound onset trigger and EEG signal by 16 channels. Acquired data are sent to PC via bluetooth USB dongle and streamed through the [Brainflow](https://github.com/brainflow-dev/brainflow) which in open-source data acquisition software. To perform our online AAD task, you refer to follow code file:  `AcquisitionOpenBCI.ino`

   You can find the OpenBCI Tutorial and Library to program OpenBCI board.
  > 
  > https://docs.openbci.com/docs/02Cyton/CytonProgram
  > 
  > https://github.com/OpenBCI/OpenBCI_Cyton_Library

  

### Sound Player Module
During the experiment, [WAV Trigger](https://github.com/robertsonics/WAV-Trigger-Arduino-Serial-Library) presents sound stimuli by reading the commend from sound trigger module. Sound stimuli are stored in micro SD card. It is supplied 5V power from the sound trigger module (i.e., arduino UNO).

See Arduino Serial Contol Tutorial to operate WAV Trigger
> 
> http://robertsonics.com/2015/04/25/arduino-serial-control-tutorial/


### Sound Trigger Module
The sound trigger module used Arduino UNO. It not only receive the command for trial start from laptop (or PC) via COM port, but also send the command for sound play to the sound player module. Then, to synchronizate between timing information of sound onset and EEG data, the sound trigger module, the sound trigger module provides the sound onset trigger to EEG acquisition module. Refer to following code: `ArduinoTrigger.ino` 


## Experimental processing

To conduct the online AAD experiment, `OnlineAAD_EXP.py` includes data streaming, prepocessing, decoding process with mTRF, visual presentation with Psychopy and communication with arduino. It need 

You can run the task through `OnlineAAD_EXP.py` along with custom-codes in Sub_Functions file.
Also, you need to check your arduino, bluetooth COM port number and your directory of files.

+ Other requires
> https://github.com/SRSteinkamp/pymtrf

> https://github.com/brainflow-dev/brainflow

***
## Enclosure
Encloeure is producted by 3D printer with custom-made design. The dimension of the Encloeure is within 24 cm x 15 cm x 6 cm including cover (width x length x height). A Cover is made of acrilic material. 
You can use following 3D design file:

`DeviceEnclosure.step`
 or 
`DeviceEnclosure.stl`


## Detail
The outside of CEDA include DC power adapter, a switch of power for the EEG acquisition module, two LED and COM port adapter (described from left side, shown as first figure). Two LED are for checking the power on the EEG acquisition module and the trigger state on the sound trigger module. Second figure shown a parallel port adapter for EEG electrode cap, a volume controller using potentialmeter and an earphones stereo adapter. All modules are connected by jumper-wires (shown as final figure). The EEG acquisition module and sound trigger module are supplied from 5V DC power and COM port, and the sound player module is powered from the sound trigger module (5V).

***

<img src="https://user-images.githubusercontent.com/85104167/142797442-7c8c5677-199c-4192-8cdf-e37cbf4d5fd9.jpg" width="600" height="400">
<img src="https://user-images.githubusercontent.com/85104167/142797446-1ed05680-9816-4fd7-a80c-fed93afa0ad8.jpg" width="600" height="400">
<img src="https://user-images.githubusercontent.com/85104167/142797452-4d86a22f-e608-44a9-a706-3fac1b7e39b9.jpg" width="600" height="400">

