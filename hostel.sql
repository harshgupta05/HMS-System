#Create Table

create database hostel ;
use hostel ;
create table student (studentid int , phone varchar(15) , messid int , roomid int , name varchar(50) , password varchar(50) ) ;
insert into student values(873 , "8798739489" , 38 , 2190 , "name1" , "123") ;
insert into student values(984 , "9823928933" , 43 , 9823 , "name2" , "kalia123") ;
create table roommaintenance (studentid int , complaint varchar(50) , description varchar(200) , roomid int) ;
create table messfeedback (messid int , hygiene int , quality int , taste int , studentid int) ;