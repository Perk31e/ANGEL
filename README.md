# **ANGEL: Android Data Collection Script**
ANGEL is a script designed to automate the collection of essential data from Android devices.

## **ANGEL Introduction** <br/><br/>
ANGEL is an advanced script designed to automate the collection of essential data from Android devices, streamlining the process of digital forensics and data analysis.

## **Purpose and Use Cases** <br/><br/>
Developed as part of a cybersecurity project, ANGEL serves as a crucial tool for professionals in digital forensics, providing a fast and efficient way to gather necessary data from Android devices. It's particularly useful for scenarios involving security analysis, data recovery, and educational purposes

## **Key Features** <br/><br/>
Key features of ANGEL include automated data extraction, compatibility with a wide range of Android devices, and user-friendly operation, ensuring that even those with minimal technical expertise can effectively utilize the tool

## **To use ANGEL, follow these steps:...** <br/><br/>
To test ANGEL in a virtual environment, follow these steps:

### **1. Set Environment variable for adb**
![run](https://github.com/S3xyG4y/ANGEL/assets/55012702/11663704-1c85-41bb-986d-8a6f93b704e0)<br/>
press keyboard's "windows key" button and "r" button will pops up "run.exe" type sysdml.cpl<br/><br/>
![sysdm cpl image](https://github.com/S3xyG4y/ANGEL/assets/55012702/8c49a506-a5c6-4190-8c72-d874d68ef50e)<br/>
you can see system properties then get to the Advance tab<br/><br/>
![image](https://github.com/S3xyG4y/ANGEL/assets/55012702/68f73d4f-a4dd-405a-b4d4-b11e58586cee)<br/>
when you reached advanced tab press Environment Variables<br/><br/>
![sysdmcpl path](https://github.com/S3xyG4y/ANGEL/assets/55012702/643bb842-592c-4b8f-8040-e4d4def2ba08)<br/>
now select System variables's Path<br/><br/>
![image](https://github.com/S3xyG4y/ANGEL/assets/55012702/9ba154a5-e19f-4552-8a63-8967f6c5387a)<br/>
add your adb path ex) "C:\Users\yourusername\AppData\Local\Android\Sdk\platform-tools"<br/>
![adb success](https://github.com/S3xyG4y/ANGEL/assets/55012702/324316d8-a274-41db-ace3-17a341f899e8)<br/>
(if you set adb environment properly, cmd will show like this)<br/>
if you followed all step described above run adb on cmd if your terminal already executed exit that terminal then retry it<br/><br/>

### **2-1) Using Nox Player**
1) **Enable Root Access:** Ensure that the option to get Root privilege is enabled in Nox Player.<br/><br/>
![Nox-Root](https://github.com/S3xyG4y/ANGEL/assets/55012702/5655ff56-375b-4202-b507-c6d5375cbd2a)<br/>
2) **Connect Your Nox Player:** Establish a connection with your Nox player.<br/><br/>
![adb connect](https://github.com/S3xyG4y/ANGEL/assets/55012702/e9dd43ce-59ea-4fd8-9fb2-5640bb4d8401)<br/>
3) **Execute Shell:** Access the shell with root privileges.<br/><br/>
![shell access](https://github.com/S3xyG4y/ANGEL/assets/55012702/23b243e6-aa76-48f6-a033-9aa610b6065a)<br/>
### **2-2) Using Android Studio**
1) **Open avd:** Open Android Virtual Device<br/><br/>
![open avd](https://github.com/S3xyG4y/ANGEL/assets/55012702/2cdfc489-7d34-4806-b819-78a04c53943a)<br/>
2) **Select Hardware:** Select Hardware which has Play Store mark<br/><br/>
![create device](https://github.com/S3xyG4y/ANGEL/assets/55012702/4d55cb4b-3dc8-48b0-a29b-c6aa2af4df29)<br/>
3) **Select System Image:** Select System Image which has Target's "~~~ Google APIs"<br/><br/>
![select system image](https://github.com/S3xyG4y/ANGEL/assets/55012702/2481fc83-301e-41d5-9fd9-751e2a5a0b8b)<br/>
q) why should i choose Target's Google API -> a) Because we need root access so the virtual device already rooted status<br/><br/>
4) **type adb devices:** make sure you should type adb devices before execute adb shell<br/><br/>
![adb devices](https://github.com/S3xyG4y/ANGEL/assets/55012702/2586c76a-6101-4c08-9d82-839e331f64f1)<br/>
5) **type adb root:** now get root access<br/><br/>
![adb root](https://github.com/S3xyG4y/ANGEL/assets/55012702/78d697d9-d8c0-4c18-a75a-4b5c9622557c)<br/>
6) **type adb shell:** now you got access to Android shell<br/><br/>
![adb shell](https://github.com/S3xyG4y/ANGEL/assets/55012702/202b7a39-d9db-48f4-86ae-1da43365c2f0)<br/>
As shown above, you can access the shell with root access.

### **3. Check Your Environment's Architecture**
Determine the architecture of your environment.<br/>
![image](https://github.com/S3xyG4y/ANGEL/assets/55012702/2ff62415-eec0-49f4-a951-e988243087a4)<br/><br/>
```sh
getprop ro.product.cpu.abi
```
or
```sh
uname -m
```
For example, the output above indicates an x86 architecture.<br/>
### **4. Push the ANGEL Script**<br/>
![image](https://github.com/S3xyG4y/ANGEL/assets/55012702/2fb7ef9d-9d13-4a02-aaa8-e84c2e522cf3)<br/>
Push the ANGEL scripts and the Frida server to your environment. You can download the Frida server from following link: <br/> https://github.com/frida/frida/releases <br/>
### **5. Grant Permission**<br/>
![grant permission](https://github.com/S3xyG4y/ANGEL/assets/55012702/17bdbbc7-6103-4941-8814-4b1e0b9ba009)<br/><br/>

## **Disconnecting from the ADB Session:** <br/>
After completing your tasks using ADB, it's recommended to properly disconnect the session, especially when working with specific IP addresses and port numbers. To disconnect from an ADB session and if you want to ensure that all ADB processes are terminated and to reset the ADB server, use the following command:<br/><br/>
(Please note that the following command examples are based on the scenario where ADB was connected to a NOX Player. They demonstrate how to proceed with the disconnection in this specific context)<br/><br/>
![terminate](https://github.com/S3xyG4y/ANGEL/assets/55012702/fad4f679-f20b-4ef0-a5c9-a3be53ec9a74)<br/><br/>
```sh
adb disconnect 127.0.0.1:62001
```
and
```sh
shadb kill-server
```
**[*] Error handling**<br/><br/>
If you encounter issues where characters appear shattered after executing Android_main.sh, it may be due to the text type being CRLF instead of LF. In this case, you can convert the line endings using the following command: <br/><br/>
![sed](https://github.com/S3xyG4y/ANGEL/assets/55012702/cc9a3300-85ca-4f3f-bdee-7805685414ec)<br/><br/>
-command example-<br/>
```sh
sed -i 's/\r$//' [yourfilename]
```

## Requirements
The primary requirement for this project is ADB (Android Debug Bridge). If you only need ADB without the full Android Studio suite, you can download the Android SDK Platform-Tools from Google. This package includes ADB and other essential tools.

- Download link: [Android SDK Platform-Tools](https://developer.android.com/studio/releases/platform-tools)

After downloading, unzip the package to your desired location and set up the ADB path in your system's Environment Variables to use ADB from the command line or terminal.

## Usage

Ensure that the steps are clearly numbered or bulleted for easy following.
Check for any technical jargon that might be unclear to a general audience and clarify or simplify as needed.

## License
Currently, Our Project uses MIT License

## Contributing
We welcome contributions to ANGEL! If you're interested in contributing, please see our [CONTRIBUTING.md](https://github.com/S3xyG4y/ANGEL/blob/main/CONTRIBUTING.md) for more information on how to get started
