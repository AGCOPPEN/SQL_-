
--首先要指向操作的数据库
use master
go

---------------------------------创建数据库（如果存在就删除就有数据库）-----------------------------------------
if exists(select * from sysdatabases where name = 'ManageDB')
drop database ManageDB
go

create database ManageDB
on primary
(
	--数据库的逻辑文件名（就是系统用的，必须唯一)
	name = 'ManageDB_data1',
	--数据库物理文件名（绝对路径）
	filename='G:\DB\ManageDB_data1.mdf',--主数据文件名（注意mdf）
	 --数据库初始文件大小(一定要根据你的实际生产需求来定)
	size=20MB,
	--数据文件增值量（也要参考文件本身大小）
	filegrowth = 1MB
),
(
	name='ManageDB_data2',	
	filename='G:\DB\ManageDB_data2.ndf',--次要数据文件名（注意ndf）	
	size=20MB,
	filegrowth=1MB
)
log on --数据库日志
(
	name='ManageDB_log',	
	filename='G:\DB\ManageDB_log.ldf',--日志文件名	
		 size=10MB,
		 filegrowth=1MB
)
go


--其次指向要操作的数据库
use ManageDB
go

---------------------------------创建表格------------------------------------------------------------------------
if exists (select * from sysobjects where name = 'Person')
drop table Person
go
create table Person
(
	UserId varchar(15) primary key,	
	LoginAccount varchar(30) not null,			--not null非空
	LoginPwd varchar(18) check(len(LoginPwd) >= 6 and len(LoginPwd) <= 18)not null,	 --check检查密码长度
	UserName varchar(20) not null,
	PhoneNumber char(11) not null,
)
go

if exists (select * from sysobjects where name='CourseCategory')--外键约束后无法删除
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
	 CategoryId int references CourseCategory(CategoryId) not null,  --外键约束（删除不了CourseCategory）
)
go

-----------------------------添加数据（包括：增、删、改、查）-------------------------------------------------

--增加数据
insert into Person( UserId, LoginAccount, LoginPwd,UserName, PhoneNumber)
values('202131205104', '202131205104@stu.hebut.edu.cn', '!Gzzx130204714', '黄天一', '13643415887')
go
insert into Person values('202131205105','202131205105@stu.hebut.edu.cn','!Bwwh154211', '黄九元', '13643415887')
go
--删除数据
delete from Person where UserId = '202131205105'
go
--修改数据
update Person set PhoneNumber = '13081492366'
--查询显示数据
select UserId, UserName, PhoneNumber from Person	--select * from Person表示查询全部

insert into CourseCategory
values( '必修课'),('核心课'),('核心课'),('培养环节'),('选修课'),('选修课'),('选修课'),('选修课')
go
select* from Coursecategory

insert into Course (CourseId,CourseName,CourseContent,ClassHour,Credit,CategoryId)
values('G00G0401','工程伦理','工程伦理指在工程中获得辩护的道德价值','16',1,1),
('G00G0402','英文科技论文写作与学术报告	','指导如何撰写国际期刊和会议论文','8',0.5,1),
('G00G0403','科研伦理与学术规范	','以经典案例为辅助，处理流程及应对策略','8',0.5,1),
('G00S0101','新时代中国特色社会主义理论与实践	','学习习近平新时代中国特色社会主义思想','36',2,1),
('G00S0102','自然辩证法概论	','马克思辩证唯物主义的新发展','18',1,1),
('G00S0105','《习近平谈治国理政》研读','习近平总书记深情回顾了马克思光辉的一生','20',1,1),
('G00S0201','硕士英语阅读与写作	','工程伦理指在工程中获得辩护的道德价值','40',2,1),
('G00S0301', '数值分析', '研究分析用计算机求解数学计算问题的数值计算方法及其理论的学科', '48',3 ,2 ),
('G00S0303', '矩阵论', '矩阵的基本理论、方法及其应用', '32',2,2),
('Z12S0501', '数值仿真与有限元', '计算材料学有限元与数值模拟', '32',2 ,3),
('Z12S0502', '机电系统建模与仿真', '机电系统的动力学方程、动力学仿真软件和试验建模方法', '32',2,3),
('Z12S0503', '数字化设计与制造', '数字化设计与制造技术的关键技术以及主流应用系统', '32', 2, 3),
('Z12S0504', '技术创新方法及应用', '工程应用角度出发介绍TRIZ理论与工具', '32',2 ,3),
('Z12S0505', '机器人机构学及应用', '机器人工程、机械设计制造及自动化、自动化及计算机等专业', '32',2 ,3),
('Z12S0506', '机电系统工程设计方法', '机电系统工程的系统分析和设计方法.利用系统工程的三维分析方法', '32',2 ,3),
('G00S0501', '学术报告（硕士）', '如何做学术报告', '16',1,4),
('G00S0502', '学术活动（硕士）', '如何做学术活动', '16',1,4),
('Z00S0503', '专业实践（硕士）', '如何做专业实践','16',1,4),
('G00G0404', '知识产权', '知识产权专业培养具有理工科基础', '16',1,5),
('G00G0407', '研究生的压力应对与健康心理', '内容涉及研究生的健康心理与适应发展(健康教育)', '8',0.5,6),
('G00G0408', '文献管理与信息分析', '要介绍信息社会,高效学习的理念', '8',0.5,6),
('Z12S0417', '工程应用课', '部门从事研发设计', '16',1,6),
('Z12S0418', '专业实验课', '做实验', '16',1,6),
('Z12S0512', '机械系统可靠性设计', '可靠性基本概念、可靠性数学基础、机械可靠性设计原理与可靠度计算', '32',2,7),
('Z12S0522', '汽车故障监测与诊断', '现代汽车故障诊断通过高新技术的仪器设备', '32',2,7),
('Z13S0101', '高等工程热力学', '工程热力学教材基础上的加深与拓宽', '32',2,7),
('Z28S0402', '先进控制理论', ' 先进控制理论是建立在状态空间法基础上的一种控制理论', '32',2,7)
go

select * from Course order by CategoryId --按CategoryId升序排列

select CourseId, CourseName,CourseContent ,ClassHour, Credit,Course.CategoryId,CategoryName from Course
inner join CourseCategory on Course.CategoryId=CourseCategory.CategoryId --inner join如果表中有至少一个匹配，则返回行