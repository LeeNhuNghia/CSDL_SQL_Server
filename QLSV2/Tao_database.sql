CREATE DATABASE QLSV_14
ON primary
(Name=QLSV_14_data,
FileName="E:\Data\QLSV_14_data.MDF",
size=2Mb, maxsize=5Mb, filegrowth=1Mb)

Log on
(Name=QLSV_14_log,
FileName="E:\Data\QLSV_14_log.LDF",
size=2Mb, maxsize=5Mb, filegrowth=1Mb)