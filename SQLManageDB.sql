
--����Ҫָ����������ݿ�
use master
go

---------------------------------�������ݿ⣨������ھ�ɾ���������ݿ⣩-----------------------------------------
if exists(select * from sysdatabases where name = 'ManageDB')
drop database ManageDB
go

create database ManageDB
on primary
(
	--���ݿ���߼��ļ���������ϵͳ�õģ�����Ψһ)
	name = 'ManageDB_data1',
	--���ݿ������ļ���������·����
	filename='G:\DB\ManageDB_data1.mdf',--�������ļ�����ע��mdf��
	 --���ݿ��ʼ�ļ���С(һ��Ҫ�������ʵ��������������)
	size=20MB,
	--�����ļ���ֵ����ҲҪ�ο��ļ������С��
	filegrowth = 1MB
),
(
	name='ManageDB_data2',	
	filename='G:\DB\ManageDB_data2.ndf',--��Ҫ�����ļ�����ע��ndf��	
	size=20MB,
	filegrowth=1MB
)
log on --���ݿ���־
(
	name='ManageDB_log',	
	filename='G:\DB\ManageDB_log.ldf',--��־�ļ���	
		 size=10MB,
		 filegrowth=1MB
)
go


--���ָ��Ҫ���������ݿ�
use ManageDB
go

---------------------------------�������------------------------------------------------------------------------
if exists (select * from sysobjects where name = 'Person')
drop table Person
go
create table Person
(
	UserId varchar(15) primary key,	
	LoginAccount varchar(30) not null,			--not null�ǿ�
	LoginPwd varchar(18) check(len(LoginPwd) >= 6 and len(LoginPwd) <= 18)not null,	 --check������볤��
	UserName varchar(20) not null,
	PhoneNumber char(11) not null,
)
go

if exists (select * from sysobjects where name='CourseCategory')--���Լ�����޷�ɾ��
drop table CourseCategory
go
create table CourseCategory
(
     CategoryId  int identity(1,1) primary key,
     CategoryName nvarchar(20) not null    
)
go

if exists (select * from sysobjects where name='Course')
drop table Course
go
create table Course
(
     CourseId  varchar(8) primary key,
     CourseName nvarchar(50) not null ,
	 CourseContent nvarchar(500) not null,
	 ClassHour int not null,
	 Credit int check(Credit>=0 and Credit<=5) not null,
	 CategoryId int references CourseCategory(CategoryId) not null,  --���Լ����ɾ������CourseCategory��
)
go

-----------------------------������ݣ�����������ɾ���ġ��飩-------------------------------------------------

--��������
insert into Person( UserId, LoginAccount, LoginPwd,UserName, PhoneNumber)
values('202131205104', '202131205104@stu.hebut.edu.cn', '!Gzzx130204714', '����һ', '13643415887')
go
insert into Person values('202131205105','202131205105@stu.hebut.edu.cn','!Bwwh154211', '�ƾ�Ԫ', '13643415887')
go
--ɾ������
delete from Person where UserId = '202131205105'
go
--�޸�����
update Person set PhoneNumber = '13081492366'
--��ѯ��ʾ����
select UserId, UserName, PhoneNumber from Person	--select * from Person��ʾ��ѯȫ��

insert into CourseCategory
values( '���޿�'),('���Ŀ�'),('���Ŀ�'),('��������'),('ѡ�޿�'),('ѡ�޿�'),('ѡ�޿�'),('ѡ�޿�')
go
select* from Coursecategory

insert into Course (CourseId,CourseName,CourseContent,ClassHour,Credit,CategoryId)
values('G00G0401','��������','��������ָ�ڹ����л�ñ绤�ĵ��¼�ֵ','16',1,1),
('G00G0402','Ӣ�ĿƼ�����д����ѧ������	','ָ�����׫д�����ڿ��ͻ�������','8',0.5,1),
('G00G0403','����������ѧ���淶	','�Ծ��䰸��Ϊ�������������̼�Ӧ�Բ���','8',0.5,1),
('G00S0101','��ʱ���й���ɫ�������������ʵ��	','ѧϰϰ��ƽ��ʱ���й���ɫ�������˼��','36',2,1),
('G00S0102','��Ȼ��֤������	','���˼��֤Ψ��������·�չ','18',1,1),
('G00S0105','��ϰ��ƽ̸�ι��������ж�','ϰ��ƽ���������ع������˼��Ե�һ��','20',1,1),
('G00S0201','˶ʿӢ���Ķ���д��	','��������ָ�ڹ����л�ñ绤�ĵ��¼�ֵ','40',2,1),
('G00S0301', '��ֵ����', '�о������ü���������ѧ�����������ֵ���㷽���������۵�ѧ��', '48',3 ,2 ),
('G00S0303', '������', '����Ļ������ۡ���������Ӧ��', '32',2,2),
('Z12S0501', '��ֵ����������Ԫ', '�������ѧ����Ԫ����ֵģ��', '32',2 ,3),
('Z12S0502', '����ϵͳ��ģ�����', '����ϵͳ�Ķ���ѧ���̡�����ѧ������������齨ģ����', '32',2,3),
('Z12S0503', '���ֻ����������', '���ֻ���������켼���Ĺؼ������Լ�����Ӧ��ϵͳ', '32', 2, 3),
('Z12S0504', '�������·�����Ӧ��', '����Ӧ�ýǶȳ�������TRIZ�����빤��', '32',2 ,3),
('Z12S0505', '�����˻���ѧ��Ӧ��', '�����˹��̡���е������켰�Զ������Զ������������רҵ', '32',2 ,3),
('Z12S0506', '����ϵͳ������Ʒ���', '����ϵͳ���̵�ϵͳ��������Ʒ���.����ϵͳ���̵���ά��������', '32',2 ,3),
('G00S0501', 'ѧ�����棨˶ʿ��', '�����ѧ������', '16',1,4),
('G00S0502', 'ѧ�����˶ʿ��', '�����ѧ���', '16',1,4),
('Z00S0503', 'רҵʵ����˶ʿ��', '�����רҵʵ��','16',1,4),
('G00G0404', '֪ʶ��Ȩ', '֪ʶ��Ȩרҵ�����������ƻ���', '16',1,5),
('G00G0407', '�о�����ѹ��Ӧ���뽡������', '�����漰�о����Ľ�����������Ӧ��չ(��������)', '8',0.5,6),
('G00G0408', '���׹�������Ϣ����', 'Ҫ������Ϣ���,��Чѧϰ������', '8',0.5,6),
('Z12S0417', '����Ӧ�ÿ�', '���Ŵ����з����', '16',1,6),
('Z12S0418', 'רҵʵ���', '��ʵ��', '16',1,6),
('Z12S0512', '��еϵͳ�ɿ������', '�ɿ��Ի�������ɿ�����ѧ��������е�ɿ������ԭ����ɿ��ȼ���', '32',2,7),
('Z12S0522', '�������ϼ�������', '�ִ������������ͨ�����¼����������豸', '32',2,7),
('Z13S0101', '�ߵȹ�������ѧ', '��������ѧ�̲Ļ����ϵļ������ؿ�', '32',2,7),
('Z28S0402', '�Ƚ���������', ' �Ƚ����������ǽ�����״̬�ռ䷨�����ϵ�һ�ֿ�������', '32',2,7)
go

select * from Course order by CategoryId --��CategoryId��������

select CourseId, CourseName,CourseContent ,ClassHour, Credit,Course.CategoryId,CategoryName from Course
inner join CourseCategory on Course.CategoryId=CourseCategory.CategoryId --inner join�������������һ��ƥ�䣬�򷵻���