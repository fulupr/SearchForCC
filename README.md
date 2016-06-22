Original Author: Travis Lee
Modified by: Kelvin Medina 
Last Update: 06/21/2016

Description:
A collection of open source/common tools/scripts to perform a process memory dump on Windows-based PoS systems and search for unencrypted
credit card track data and PAN.

==================
SearchForPANSAD.bat

Version 1.0: Forked from Travis L., now able to search PAN from VISA, MasterCard, and AMEX.

Description: Script to search an existing memory dump with grep for 
credit card track 1 and 2 data, track 1 only, and track 2 only data, and PAN. This is useful when performing testing of payment appplications under PA-DSS.

Usage:
SearchForCC.bat <memory dump file> <output file>

Example:
SearchForCC.bat memory.dmp results.txt

