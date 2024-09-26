create database NextUpgrad;
use NextUpgrad

drop table tbl_student

create table tbl_student(
id int primary key identity(100,1),
name varchar(100) not null,
fname varchar(100) not null,
email varchar(100) not null,
pwd varchar(100) not null,
dob date,
mobno bigint not null,
gender varchar(20),
qualification1 varchar(40),
qualification2 varchar(40),
qualification3 varchar(40),
qualification4 varchar(40),
state int foreign key references tbl_state(stateid) on  delete cascade on update cascade ,
dist int,
block int,
pic varchar(50)
)

truncate table tbl_student

alter proc sp_student
@id int =0,
@name varchar(100)=null,
@fname varchar(100)=null,
@email varchar(100)=null,
@pwd varchar(100) =null,
@dob date=null,
@mobno bigint=0,
@gender varchar(20)=null,
@qualification1 varchar(40)=null,
@qualification2 varchar(40)=null,
@qualification3 varchar(40)=null,
@qualification4 varchar(40)=null,
@state int=0,
@dist int=0,
@block int=0,
@pic varchar(50)=null,
@action int=0
as
begin
if(@action=1)
begin try
if not exists (select*from tbl_student where id=@id)
begin 
insert into tbl_student (name,fname,email,pwd,dob,mobno,gender,qualification1,qualification2,qualification3,qualification4,state,dist,block,pic) values (@name,@fname,@email,@pwd,@dob,@mobno,@gender,@qualification1,@qualification2,@qualification3,@qualification4,@state,@dist,@block,@pic)
select 'Data Added'
end
end try
begin catch
select 'Error in Database'
end catch
if(@action=2)
begin
select * from tbl_student inner join tbl_state on tbl_student.state=tbl_state.stateid left join tbl_dist on tbl_state.stateid=tbl_dist.id left join tbl_block on tbl_dist.id=tbl_block.blockid 
end
if(@action=3)
begin
/*select*from tbl_student where id=@id*/
select * from tbl_student inner join tbl_state on tbl_student.state=tbl_state.stateid left join tbl_dist on tbl_state.stateid=tbl_dist.id left join tbl_block on tbl_dist.id=tbl_block.blockid where tbl_student.id=@id
end
if(@action=4)
begin
delete from tbl_student where id=@id
end
if(@action=5)
begin try
if exists (select*from tbl_student where id=@id)
begin
update tbl_student set name=@name,fname=@fname,email=@email,pwd=@pwd,dob=@dob,mobno=@mobno,gender=@gender,qualification1=@qualification1,qualification2=@qualification2,qualification3=@qualification3,qualification4=@qualification4,state=@state,dist=@dist,block=@block,pic=@pic where id=@id
select 'Data Updated'
end
end try
begin catch
select 'Your Are Not Registred'
end catch
if(@action=6)
begin try
if exists(select*from tbl_student where email=@email and pwd=@pwd)
select 'Email or Password Matched'
end try
begin catch
select 'Email or Passwoed Not Match'
end catch
end

execute sp_student @name="Amit", @fname="pullu" ,@email="ak@gmail.com", @pwd="Amit@123", @dob="2003/10/25",@mobno=9372144911,@gender="male",@qualification1="bca",@state="100",@dist=100,@block=100,@action=1

execute sp_student @name="Sanjay", @fname="ManiRam" ,@email="s@gmail.com", @pwd="s@123", @dob="2003/10/25",@mobno=9372144923,@gender="male",@qualification1="bca",@state="101",@dist=101,@block=101,@action=1

execute sp_student @id=102 ,@action=3
execute sp_student @email='s@gmail.com' ,@pwd='137t2ef',@action=6

select * from tbl_student
select * from tbl_state
select * from tbl_dist
select * from tbl_block

drop table tbl_state
create table tbl_state(
stateid int primary key identity(100,1),
statename varchar(100)
)

insert into tbl_state (statename) values ('Uttar Pradesh')
insert into tbl_state (statename) values ('Bihar')

drop table tbl_state

create proc sp_selectState
as
begin
select*from tbl_state
end





create table tbl_dist(
id int primary key identity(100,1),
dist_stateid int foreign key references tbl_state(stateid) on delete cascade on update cascade,
distname varchar(100),
)



/*drop table tbl_dist*/

truncate table tbl_dist
insert into tbl_dist (dist_stateid,distname) values (100,'Basti'),(100,'Sidhart Nagar'),(100,'Ayodhya'),(100,'Azamgarh')
insert into tbl_dist (dist_stateid,distname) values (101,'Buxar'),(101,'Gaya'),(101,'Gopalgunj'),(101,'Darbhanga')

select*from tbl_dist

drop table tbl_dist

alter proc sp_selectdistrict
@dist_stateid int=0
as
begin
select*from tbl_state right join tbl_dist on tbl_state.stateid=tbl_dist.dist_stateid where dist_stateid=@dist_stateid
end

exec sp_selectdistrict 100




create table tbl_block(
blockid int primary key identity(100,1),
dist_id int foreign key references tbl_dist(id) on delete cascade on update cascade,
blockname varchar(100)
)

insert into tbl_block (dist_id,blockname) values (100,'Gaur'),(100,'Rudauli'),(100,'Kaptanganj')
insert into tbl_block (dist_id,blockname) values (101,'Jogia'),(101,'Bansi'),(101,'Birad pur')
insert into tbl_block (dist_id,blockname) values (102,'Bikapur'),(102,'Sohawal'),(102,'Tarun')
insert into tbl_block (dist_id,blockname) values (103,'Bilariyaganj'),(103,'Mirzapur'),(103,'Koilsa')

insert into tbl_block (dist_id,blockname) values (104,'Rajpur'),(104,'Simri'),(104,'Chausa')
insert into tbl_block (dist_id,blockname) values (105,'Amas'),(105,'Belaganj'),(105,'Tekari')
insert into tbl_block (dist_id,blockname) values (106,'Barauli'),(106,'Thawa'),(106,'Baikunthpur')
insert into tbl_block (dist_id,blockname) values (107,'Alinagar'),(107,'Baheri')

select*from tbl_block

truncate table tbl_block


alter proc sp_selectblock
@dist_id int=0
as
begin
select*from tbl_dist right join tbl_block on tbl_dist.id=tbl_block.dist_id where dist_id=@dist_id
end

select * from tbl_student inner join tbl_state on tbl_student.id=tbl_state.stateid left join tbl_dist on tbl_state.stateid=tbl_dist.id left join tbl_block on tbl_dist.id=tbl_block.blockid 

drop table tbl_block

exec sp_selectblock 105
select*from tbl_block where blockid=100


select * from tbl_student nolock