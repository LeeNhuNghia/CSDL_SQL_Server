CREATE DATABASE QLSV2
ON Primary
(Name=QLSV2_data, 
FileName="C:\Data\QLSV2_data.MDF", 
Size=2MB, Maxsize=5MB, FileGrowth=1MB)
LOG ON
(Name=QLSV2_log, 
FileName="C:\Data\QLSV2_log.LDF", 
Size=2MB, Maxsize=5MB, FileGrowth=1MB)
